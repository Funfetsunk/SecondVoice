// Checks the ship map in DESIGN.md section 7 for softlocks.
//
// Every scripted seal combination must leave all rooms reachable from where Sam
// is when it happens. Extra Act 4 seals are only counted: the game's own check
// (DESIGN.md 4.10) refuses any that cut a required room off.

import process from 'node:process'

const never_sealable = [
    ['Recovery Shuttle', 'Airlock'],
    ['Engineering', 'Reactor Control'],
    ['Aft Corridor', 'Crew Quarters'],
    ['Fore Corridor', "Captain's Cabin"],
    ['Medbay', 'Isolation Pod'],
    ['Navigation', 'Bridge'],
    ['Fore Corridor', 'Comms Crawlspace'],
    ['EVA Prep', 'Hull Spine'],
    ['Hull Spine', 'Cargo Hull'],
    ['Cargo Hull', 'Comms Dish'],
    ['Comms Dish', 'Comms Crawlspace'],
]

const sealable = [
    ['Airlock', 'Storage Bay'],
    ['Airlock', 'EVA Prep'],
    ['EVA Prep', 'Cargo Hold'],
    ['Storage Bay', 'Cargo Hold'],
    ['Storage Bay', 'Engineering'],
    ['Storage Bay', 'Aft Corridor'],
    ['Cargo Hold', 'Cargo Gantry'],
    ['Cargo Gantry', 'Fore Corridor'],
    ['Aft Corridor', 'Fore Corridor'],
    ['Aft Corridor', 'Mess'],
    ['Mess', 'Medbay'],
    ['Medbay', 'Fore Corridor'],
    ['Fore Corridor', 'Navigation'],
    ['Navigation', 'Server Core'],
    ['Server Core', 'Cable Trunk'],
    ['Cable Trunk', 'Cargo Gantry'],
    ['Engineering', 'Maintenance Crawlway'],
    ['Maintenance Crawlway', 'Mess'],
]

const act4_start = ['Cargo Gantry', 'Fore Corridor']

// Sam's location when each scripted combination takes effect
const scripted = [
    {name: 'Early Act 2', from: 'Aft Corridor', seals: [['Aft Corridor', 'Fore Corridor']]},
    {name: 'Vale wakes', from: 'Medbay', seals: [['Medbay', 'Fore Corridor'], ['Aft Corridor', 'Mess']]},
    {name: 'Vale wakes, early seal still on', from: 'Medbay', seals: [['Medbay', 'Fore Corridor'], ['Aft Corridor', 'Mess'], ['Aft Corridor', 'Fore Corridor']]},
    {name: 'Act 3', from: 'Storage Bay', seals: [['Storage Bay', 'Cargo Hold']]},
    {name: 'Act 4 starts, from flood in Fore Corridor', from: 'Fore Corridor', seals: [act4_start]},
    {name: 'Act 4 starts, from flood in EVA Prep', from: 'EVA Prep', seals: [act4_start]},
    {name: 'Act 4 starts, Act 3 seal still on', from: 'Fore Corridor', seals: [act4_start, ['Storage Bay', 'Cargo Hold']]},
]

const same_door = (a, b) => (a[0] === b[0] && a[1] === b[1]) || (a[0] === b[1] && a[1] === b[0])

function distances(start, seals = []) {
    const open = [...never_sealable, ...sealable].filter(door => !seals.some(seal => same_door(door, seal)))
    const found = new Map([[start, 0]])
    const queue = [start]
    while (queue.length) {
        const room = queue.shift()
        for (const [a, b] of open) {
            const next = a === room ? b : b === room ? a : null
            if (next && !found.has(next)) {
                found.set(next, found.get(room) + 1)
                queue.push(next)
            }
        }
    }
    return found
}

const rooms = [...distances('Recovery Shuttle').keys()]
const failures = []

if (rooms.length !== 24) {
    failures.push(`expected 24 rooms, found ${rooms.length}`)
}

for (const door of [...never_sealable, ...sealable, ...scripted.flatMap(beat => beat.seals)]) {
    if (!rooms.includes(door[0]) || !rooms.includes(door[1])) {
        failures.push(`unknown room in door: ${door.join(' - ')}`)
    }
}

for (const {name, from, seals} of scripted) {
    for (const seal of seals) {
        if (!sealable.some(door => same_door(door, seal))) {
            failures.push(`${name}: not a sealable door: ${seal.join(' - ')}`)
        }
    }
    const found = distances(from, seals)
    const cut = rooms.filter(room => !found.has(room))
    if (cut.length) {
        failures.push(`${name}: cut off ${cut.join(', ')}`)
    }
}

// The Act 4 seal must make the trunk the natural Destroy route
const via_trunk = distances('Server Core', [act4_start]).get('Cargo Hold')
const via_corridors = distances('Server Core', [act4_start, ['Server Core', 'Cable Trunk']]).get('Cargo Hold')
if (via_trunk !== 3 || via_corridors !== 5) {
    failures.push(`Server Core to Cargo Hold: expected 3 by trunk and 5 by corridors, found ${via_trunk} and ${via_corridors}`)
}

// Counted, not failed: the game refuses these at runtime
const extras = sealable.filter(door => !same_door(door, act4_start))
const combos = []
extras.forEach((first, index) => {
    combos.push([first])
    extras.slice(index + 1).forEach(second => combos.push([first, second]))
})
const refused = combos.filter(extra =>
    rooms.some(from => {
        const found = distances(from, [act4_start, ...extra])
        return found.size > 1 && found.size < rooms.length
    }))

failures.forEach(failure => console.log(`FAIL ${failure}`))
console.log(`tools/check-map: ${rooms.length} rooms, ${scripted.length} scripted seal combinations, ${failures.length} failures`)
console.log(`tools/check-map: Act 4 extra seals (1 or 2 doors): ${refused.length} of ${combos.length} combinations would split the ship and must be refused`)
process.exit(failures.length ? 1 : 0)
