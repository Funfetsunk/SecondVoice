// Plays each walkthrough in tests/ through emglken (Glulxe) and checks key lines.
//
// Walkthrough format, one per line:
//   # comment
//   + text     output so far must contain text (before the first command: the opening)
//   - text     same output must not contain text
//   > command  type command; later + and - lines check its output
//              (also answers single-key prompts; a bare > presses Enter)
//
// Matching ignores case and collapses whitespace, so line wrapping doesn't matter.
// Transcripts are written to Second Voice.inform/Build/tests/.

import {spawn} from 'node:child_process'
import fs from 'node:fs'
import path from 'node:path'
import {fileURLToPath} from 'node:url'

const tools = path.dirname(fileURLToPath(import.meta.url))
const root = path.dirname(tools)
const story = path.join(root, 'Second Voice.inform', 'Build', 'output.ulx')
const emglken = path.join(tools, 'node_modules', 'emglken', 'bin', 'emglken.js')
const log_dir = path.join(root, 'Second Voice.inform', 'Build', 'tests')

// The interpreter flushes a whole turn at once, then waits for input
const IDLE_MS = 100
const TIMEOUT_MS = 60000

const normalise = text => text.replace(/\s+/g, ' ').trim().toLowerCase()

function parse(file) {
    const steps = [{command: null, checks: []}]
    fs.readFileSync(file, 'utf8').split(/\r?\n/).forEach((raw, index) => {
        const line = raw.trim()
        if (!line || line.startsWith('#')) {
            return
        }
        const kind = line[0]
        const text = line.slice(1).trim()
        if (kind === '>') {
            steps.push({command: text, checks: []})
        }
        else if (kind === '+' || kind === '-') {
            steps.at(-1).checks.push({kind, text, line: index + 1})
        }
        else {
            throw new Error(`${path.basename(file)}:${index + 1}: expected #, +, - or >`)
        }
    })
    return steps
}

// Plays the commands, returning the output that followed each step
function play(steps) {
    return new Promise((resolve, reject) => {
        const vm = spawn(process.execPath, [emglken, story], {stdio: ['pipe', 'pipe', 'pipe']})
        const outputs = steps.map(() => '')
        let current = 0
        let idle = null
        let stderr = ''

        const timeout = setTimeout(() => {
            vm.kill()
            reject(new Error(`timed out after ${TIMEOUT_MS} ms at step ${current}`))
        }, TIMEOUT_MS)

        const advance = () => {
            if (current + 1 >= steps.length) {
                vm.kill()
                return
            }
            current++
            vm.stdin.write(steps[current].command + '\n')
        }

        vm.stdout.on('data', data => {
            outputs[current] += data.toString()
            clearTimeout(idle)
            idle = setTimeout(advance, IDLE_MS)
        })
        vm.stderr.on('data', data => {
            stderr += data.toString()
        })
        vm.stdin.on('error', () => {})
        vm.on('error', reject)
        vm.on('close', () => {
            clearTimeout(idle)
            clearTimeout(timeout)
            if (stderr) {
                reject(new Error(`interpreter error: ${stderr.trim()}`))
            }
            else if (current + 1 < steps.length) {
                reject(new Error(`game ended early, before: ${steps[current + 1].command}`))
            }
            else {
                resolve(outputs)
            }
        })
    })
}

function check(steps, outputs) {
    const failures = []
    steps.forEach((step, index) => {
        const output = normalise(outputs[index])
        if (output.includes('run-time problem')) {
            failures.push(`> ${step.command}: Inform run-time problem`)
        }
        for (const {kind, text, line} of step.checks) {
            if (output.includes(normalise(text)) !== (kind === '+')) {
                const where = step.command === null ? 'opening' : `> ${step.command}`
                failures.push(`line ${line}: ${where}: ${kind === '+' ? 'missing' : 'unwanted'}: ${text}`)
            }
        }
    })
    return failures
}

function transcript(steps, outputs) {
    return steps.map((step, index) =>
        (step.command === null ? '' : `[[> ${step.command}]]\n`) + outputs[index]).join('\n')
}

async function main() {
    const tests_dir = path.join(root, 'tests')
    const names = fs.readdirSync(tests_dir).filter(name => name.endsWith('.txt')).sort()
    if (!names.length) {
        console.error('tools/test: no walkthroughs in tests/')
        process.exit(1)
    }

    fs.mkdirSync(log_dir, {recursive: true})
    let failed = 0
    for (const name of names) {
        let failures
        try {
            const steps = parse(path.join(tests_dir, name))
            const outputs = await play(steps)
            fs.writeFileSync(path.join(log_dir, name), transcript(steps, outputs))
            failures = check(steps, outputs)
        }
        catch (error) {
            failures = [error.message]
        }
        console.log(`${failures.length ? 'FAIL' : 'ok  '} ${name}`)
        failures.forEach(failure => console.log(`     ${failure}`))
        failed += failures.length ? 1 : 0
    }

    console.log(`tools/test: ${names.length - failed}/${names.length} passed`)
    process.exit(failed ? 1 : 0)
}

main()
