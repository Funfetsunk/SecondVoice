# CLAUDE.md — Second Voice

Inform 7 interactive fiction by Thomas Evans (Tom). Full rewrite of the earlier "Silent Cargo" (archived on branch `archive/silent-cargo-v0.5` — reference only, do not restore it).

**Read `DESIGN.md` before doing anything.** It is the source of truth for story, characters, systems, structure and endings. Settled decisions there are Tom's; don't change them without asking. Sections marked DRAFT or listed under "Open questions" are proposals — raise them with Tom rather than silently deciding.

## Working with Tom

- Tom wants to be told when an idea of his is weaker, with a better alternative suggested. The final call is always his.
- Tom owns the key prose: Becky's real message, the fake message, captain's logs, ending reports. Draft placeholders marked `[DRAFT — Tom to rewrite]` and keep them easy to find.
- Commit in small, working steps. Never commit a build that doesn't compile or fails tests.

## Toolchain

- Inform for Windows **10.1.2** (installed at `C:\Program Files\Inform`). Story format: **Glulx**.
- The project is created by Tom in the Inform IDE as `Second Voice.inform` (with its `Second Voice.materials` folder) in the repo root. Don't hand-create `uuid.txt`/IFID or IDE settings files.
- **Build (Git Bash):** `tools/build` compiles to `Second Voice.inform/Build/output.ulx`; `tools/build --release` drops debug verbs and Volume 4. It calls `Compilers/inform7.exe` (with `-internal "C:\Program Files\Inform\Internal"`, `-external "%USERPROFILE%\Documents\Inform"`, `-project`, `-format=Inform6/32d`), then `Compilers/inform6.exe -E2SDwG auto.inf output.ulx` from `Build/`. Set `INFORM_HOME` if Inform is installed elsewhere.
- **Test (Git Bash):** `tools/test` builds, then plays every `tests/*.txt` walkthrough and checks key lines; `tools/test --no-build` skips the build. Failures exit non-zero; transcripts go to `Second Voice.inform/Build/tests/`. Walkthrough format is described at the top of `tools/run-tests.mjs`.
- **Interpreter:** `emglken` (Glulxe in WebAssembly, pinned in `tools/package.json`), run under Node. After a fresh clone: `npm install --prefix tools`. The bundled `Interpreters/glulxe.exe` exits 1 with no output when run outside the IDE, so it can't be used. emglken can't read stdin to EOF, so `tools/run-tests.mjs` feeds one command each time output goes idle.

## Repo layout (target)

```
DESIGN.md                 design source of truth
CLAUDE.md                 this file
Second Voice.inform/      Inform project (Source/story.ni)
Second Voice.materials/   release materials, cover art, extensions
tests/                    walkthrough scripts, one per route/ending
tools/                    build and test scripts
```

## Source structure

Use Inform headings so the source stays navigable at ~24 rooms:

```
Volume 1 - Framework
  Book 1 - Quiet Zones
  Book 2 - Recovery Slate (messages, evidence log, hints)
  Book 3 - Terminals
  Book 4 - Conversation
  Book 5 - AI Escalation
  Book 6 - Checkpoints and Death
  Book 7 - Act 4 Clock
  Book 8 - Parser Interference
Volume 2 - World
  Book 1 - Docking / Book 2 - Lower Deck / ... / Book 5 - Exterior
Volume 3 - Story (acts, scenes, endings)
Volume 4 - Testing (test commands; not for release)
```

Build each system once and drive it from data (kinds, properties, tables). Avoid repeating the same guard conditions across many rules; the original's copy-pasted terminal checks are what this rewrite replaces.

## Non-negotiables

- **Sam is never gendered.** No he/she/brother/sister/Samuel/Samantha. Always "Sam". Becky is Sam's sister ("she").
- Aboard ship Becky is "Reed"; only Sam calls her "Becky". Sam's nickname "Sparrow" lives in one place (it may change). The fake message says "Sammy".
- **Grant's message format:** `HELIOS OPS // GRANT // CH-4 // HH:MM`. AI forgeries are identical except the timestamp is **one minute ahead** of the ship clock. Never point this out to the player.
- The AI has no name and never names itself.
- **No softlocks.** Death only inside checkpointed set pieces, with RETRY.
- The evidence log shows only what has been found; there is no score.
- Act 4 clock counts turns, never real time, and starts only at Act 4.
- Parser interference: sparing, at the key moments in DESIGN.md only.
- British English spelling.

## Testing

- Every route and ending gets a walkthrough in `tests/`, plus out-of-order and edge-case runs (overheard vs quiet variants, Vale alive/left/dead, truth sent/not sent, timeout).
- Use Inform `Test ... with` commands for quick in-IDE checks; keep them in Volume 4.
- Run the full test suite before every commit.
