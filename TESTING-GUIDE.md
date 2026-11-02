# Second Voice: Testing Guide

Full spoilers. It covers how to reach every ending, every variation inside them, and what to look out for. Everything here passed in the automated walkthroughs, but no person has played it yet, so pacing, puzzle fairness and prose are what your playtest can find that they can't.

## Starting a test

| Way to play | How | Notes |
|---|---|---|
| **Inform IDE** | Reload the project, then **Go** | Has the shortcuts below. Use this for most testing. |
| **Browser** | In Git Bash, run `tools/release`, then open `Second Voice.materials/Release/play.html` | What players get. No shortcuts. Open it through a local web server, as some browsers block interpreters on plain files. |

**Keep a record:** type `SCRIPT ON` at the start of a run to save a transcript. If something looks wrong, note the last few commands, or send me the transcript.

### Shortcuts (IDE only)

Each one plays the game up to that point, so you can test the later acts without replaying the earlier ones.

| Type | Takes you to |
|---|---|
| `TEST ACT1` | Cargo Hold, the subject count just read |
| `TEST TOACT3` | The Bridge, Act 3 just begun, Vale with you |
| `TEST TOACT4` | The Fore Corridor, the flood just arrived, clock running, Vale waiting in EVA Prep |
| `XAI` | Prints the AI's stage and attention |
| `XACT` | Prints the current act and the status line's reading |
| `XCLOCK 5` | Sets the Act 4 clock to 5 turns, for testing the timeout |

`TEST TOACT3` and `TEST TOACT4` take the plainest route, so they skip optional content such as the letter, the captain's logs and the manifest.

---

## The main path

These are the shortest commands through each act. Play your first run without them if you can, because how long you get stuck is useful information.

**Act 1: Boarding**
```
E, E, TAKE CUTTER, E, OPEN VALVE, RESET BREAKERS, S, PULL LEVER,
REPORT ALL QUIET, N, W, N, EXAMINE INTERFACE
```

**Act 2: Investigation**
```
S, U, E, N, USE TERMINAL, 2, E, CUT FEED,
W, S, D, READ NOTES, U, W, N, U, E, USE CONSOLE, 2
```

**Act 3: Escalation**
```
W, D, S, D, W, N, TAKE SUIT, WEAR SUIT, W, N, TAKE KEY, CLIP, WAIT,
N, D, PLAY RECORDER, TAKE RECORDER, UNSEAL HATCH, SE
```
One command in this stretch gets replaced by `SAY I'M COMING`. That's deliberate, so just type the lost command again.

**Act 4: The Choice** is below, by ending.

---

## Map

North is fore. **(Q)** is a quiet room. **(!)** is the Cable Trunk, the loudest place on the ship.

```
LOWER DECK                         CENTRAL DECK (up from Storage Bay)

  EVA Prep ----- Cargo Hold          Captain's --- Fore Corridor --- Medbay --- Isolation
     |               |                Cabin        |      \            |          Pod
     |               |                             |       NW: Comms   |
  Shuttle - Airlock(Q) - Storage - Engineering     |       Crawlspace  |
                                       |           |       (Q)         |
                                    Reactor     Crew Qtrs - Aft Corr. - Mess
                                    Control

  Gantry: up from Cargo Hold, and north of Fore Corridor
  Maintenance Crawlway (Q): up from Engineering, down from Mess

COMMAND DECK (up from Fore Corridor)     OUTSIDE (west from EVA Prep, all Q)

  Server Core                              Comms Dish  (down: Comms Crawlspace)
     |   \                                     |
     |    down: Cable Trunk (!)            Cargo Hull  (the crew, Voss's key)
     |          down: Gantry                   |
  Navigation --- Bridge                    Hull Spine  (east: EVA Prep)
```

---

## All the endings

Every ending is a final scene and then a Helios report. The report changes with two things: **Vale's fate** and **whether the truth was sent**.

### Destroy

1. **CUT LINK** in the Server Core.
2. **CUT ISOLATOR** in the Cargo Hold.
3. In Reactor Control with Voss's key, you get `> TURN KEY / REFUSED`. Trying again doesn't help. Get past it with either:
   - **PLAY RECORDER**: it stops to listen. The report mentions it replaying a file.
   - **VALE, TURN KEY**, with Vale in the room: she stays behind and dies, and the AI never gets the recording.
4. You then have 14 turns to reach the Shuttle and **UNDOCK**. A door closes on the way, so go Engineering → Storage Bay → Cargo Hold → EVA Prep → Airlock → Shuttle.

From `TEST TOACT4`: `U, N, CUT LINK, D, D, D, CUT ISOLATOR, W, S, E, E, S, PLAY RECORDER, TURN KEY, N, W, N, W, S, W, UNDOCK`

### Deliver

In the Cargo Hold: **USE INTERFACE**, optionally read "Release to Helios", then **CONFIRM**.

From `TEST TOACT4`: `S, D, W, N, E, CONFIRM`

### Interface

In the Cargo Hold: **USE INTERFACE**, optionally read "Connect", then **CONNECT**.

From `TEST TOACT4`: `S, D, W, N, E, CONNECT`

### Timeout

Do nothing until the clock runs out. It starts at 60 minutes, and `ETA` shows what's left. `WAIT` and other actions cost a minute. `EXAMINE`, `LOOK`, `INVENTORY` and refused commands cost nothing, and Becky's recording costs 3. In the IDE, use `XCLOCK 3` and then `WAIT` three times.

---

## The two modifiers

### Vale's fate

| Outcome | How to get it |
|---|---|
| **Brought out alive** | She's in the room with you at Deliver, Interface or Timeout, or in the Shuttle when you UNDOCK. She follows by default. After the spacewalk, pick her up at EVA Prep. |
| **Left behind** | `VALE, STAY` somewhere (or don't fetch her from EVA Prep), then Deliver, Interface or Timeout without her. |
| **Lost: left on the ship** | Destroy with her not in the Shuttle. You get a warning first, so UNDOCK twice. |
| **Lost: turned the key** | `VALE, TURN KEY`. |
| **Lost: vented** | See below. Any ending can follow this one. |

**To get her vented:**
1. Read **Raw datasets** on the medbay terminal.
2. Read **Access table** on the core console.
3. In any loud room, type `ASK VALE ABOUT THE DATASETS`.
4. Cross the hull without her and leave her in EVA Prep.
5. When the flood arrives, the speakers quote her and her room starts venting. You have 12 turns. Reach her and she lives. Don't, and the slate shows `SUBJECT COUNT: 1`.

### Truth transmitted

Both steps only work in Act 4.
1. **Bridge:** USE CONSOLE, then choose **Re-align array**. The AI hears it and seals the hatch down to the Fore Corridor.
2. Take the long way round: Navigation → Server Core → Cable Trunk → Gantry → Cargo Hold → EVA Prep → Airlock → Storage Bay → Aft Corridor → Fore Corridor → NW.
3. **Comms Crawlspace:** **SEND**, with her recorder.

From `TEST TOACT4`: `U, E, USE CONSOLE, 2, W, N, D, D, D, W, S, E, U, N, NW, SEND`

If you sent the truth, the report says external enquiries have begun. If not, it says the official account stands.

### Ending checklist

Tick these off. All are reachable, and those marked **auto** already have a walkthrough.

| | Alive | Left behind | Lost |
|---|---|---|---|
| **Destroy, no truth** | ☐ auto | not possible: she'd be lost | ☐ auto |
| **Destroy, truth** | ☐ | not possible: she'd be lost | ☐ auto |
| **Deliver, no truth** | ☐ auto | ☐ | ☐ auto |
| **Deliver, truth** | ☐ | ☐ auto | ☐ |
| **Interface, no truth** | ☐ auto | ☐ | ☐ |
| **Interface, truth** | ☐ | ☐ auto | ☐ |
| **Timeout, no truth** | ☐ | ☐ auto | ☐ |
| **Timeout, truth** | ☐ auto | ☐ | ☐ |

---

## Variations inside the story

| What to try | Way A | Way B | What to look for |
|---|---|---|---|
| **The nickname** | READ LETTER at Reed's bunk (loud) | TAKE LETTER, read it in the Airlock or Crawlway (quiet) | The message in Becky's voice says **Sparrow** after A and **Sammy** after B. So does the Deliver ending. |
| **Vale's confession** | ASK VALE ABOUT THE DATASETS in a loud room | The same in a quiet room | Different wording. Loud: the AI quotes her in Act 4. Quiet: it never does. Needs both clues above. |
| **Mercer's plan** | TAKE NOTES, read them in the Mess (loud) | READ NOTES in the Crawlway (quiet) | Loud: speakers say "BOTH OR NOTHING" at Act 4 and the Server Core door seals. Go in through the Cable Trunk from the Gantry instead. |
| **Vale's topics** | ASK ABOUT THE POD in a loud room | The same in the Crawlway | Loud: "Not here." Quiet: an answer. `TALK` shows more topics when it's quiet. |
| **Beating the model** | PLAY RECORDER | VALE, TURN KEY | Different cost, different report. |
| **The Cable Trunk** | READ LETTER there for the first time | Read it anywhere else loud | `XAI` shows attention rising by 2 instead of 1. |
| **Waking Vale** | Override first, then cut | Cut first, then override | She arrives differently. Both work. |
| **Crawlway** | Vale first, doors seal, forced through the Mess grille | CUT GRILLE in Engineering, read the notes before waking her | In B, no doors seal when she wakes. |
| **The report** | Ignore Grant's request for 8 turns | REPORT with your own words | The panel repeats exactly what you said, or "Yes. I'm here." |

---

## Deaths and RETRY

Only two places can kill you. Both offer **RETRY** on the final menu.

| Where | How to die | What RETRY does |
|---|---|---|
| **Hull** | Ignore the suit's `ATTITUDE BURN` warnings and don't CLIP | Back to the lock you came through |
| **Destroy escape** | Fail to UNDOCK within 14 turns of the key turning | Back to Reactor Control, with the full 14 turns |

Die repeatedly to see `ATTEMPT 2`, then "You hesitate at the same point each time", then "The model's confidence increases". RETRY should **not** appear on the menu after a real ending.

---

## Everything the evidence log can hold

There are 16 pieces. Each report says how many you missed. All 16 together gives "Evidence recovered: complete", which has a walkthrough.

**Act 1**
1. Airlock: EXAMINE WARNING
2. Airlock: EXAMINE RACK
3. Cargo Hold: EXAMINE CONTAINER

**Act 2**
4. Crew Quarters: EXAMINE DATAPAD
5. Crew Quarters: READ LETTER
6. Captain's Cabin: `ENTER 1840`, then Log 4
7. Cargo Gantry: OPEN DRAWER, then EXAMINE REAL MANIFEST
8. Medbay terminal: Raw datasets
9. Crawlway: READ NOTES
10. Navigation console: Course log
11. Bridge console: Comms log

**Act 3**
12. Core console: Access table
13. Core console: Subject file: REED, S.
14. Cargo Hull: EXAMINE CREW
15. Crawlspace: PLAY RECORDER
16. ASK VALE ABOUT THE DATASETS (needs 8 and 12)

---

## Moments to watch for

**Sam and Becky.** Does the bond land now? Check the opening's new line about caseworkers, `OLD MESSAGES` on the slate from the first turn, the warning, the Mess tables, and the photograph in Crew Quarters. The history is my draft, for you to rewrite.

**The AI's interference.** Each happens once, and should feel wrong without feeling broken:
1. Navigation console: `INPUT REGISTERED BEFORE CONTACT` before the screen.
2. After Becky's voice message: your next command becomes `SAY I'M COMING`.
3. First use of the interface in Act 4: a fake decision tree that lists your options.
4. Reactor Control: `> TURN KEY / REFUSED` before you've typed it.

**Quieter touches:**
- **Forged messages:** there are two. One says to stay inside at Act 3, the other says "Hold position" in the flood. Their timestamps are a minute ahead.
- **Act 4 clock:** the status line runs a minute ahead from here, so the forgeries look right and Grant looks late. Does anyone notice? Is that too cruel, or just right?
- **Hints:** from Act 3, `HINT` where there's signal starts answering back. After 9 hints: "You asked for help 9 times. Becky would have figured this out." In a quiet room it should stay clean.
- **Status line:** LISTENING / QUIET only appears after reading Mercer's notes.
- **Doors:** seals in Act 2 and Act 4 should push you around but never trap you.

---

## Please try to break it

These are the best uses of a human tester, because the walkthroughs only try what I thought of.

- **Softlocks:** drop things in odd places. Try the cutter, the key, the recorder, the suit and the notes. Then see if a door seal can cut you off from them.
- **Leaving early:** walk out of the Crawlspace without playing the recorder. There should be no flood and no clock, and HINT should send you back.
- **Forgotten key:** leave Voss's key on the hull and only notice in Reactor Control during Act 4. Can you get back in time? Is that fair?
- **Vale left somewhere odd:** `VALE, STAY` in far corners, then see what the doors do.
- **Vocabulary:** try the words you'd naturally use. Every "You can't see any such thing" for something a room mentions is a bug worth reporting.
- **Timing:** how long does a first run take against the 1.5 to 2 hour target? I'd expect it to be **well short**. Act 2 and Act 3 have much less to find than the target implies.
- **Clock length:** is 60 minutes tense, or too loose, now that looking around is free? Doing Destroy and the truth together uses about 40.

---

## What needs you

**Your prose.** These are all placeholders. Search the source for `DRAFT`:
- The fake message, the letter, Becky's real message and Becky's voice message
- Sam and Becky's history: the opening line, `OLD MESSAGES`, and the memories on the warning, Mess tables and photograph
- Captain's logs 1 to 4
- All four final scenes and reports, and the modifier paragraphs
- The forged flood message

**Your decisions.** `DESIGN.md` section 13 lists every call I made so the game could be finished. The biggest ones:
1. **The Act 4 puzzle** (playing the recorder, or Vale's hands). This was the largest open question.
2. **What happens to Sam in Interface.**
3. **How Vale can die.**
4. **The Act 4 status line drift.**

**Cover art.** Generated with PixelLab and in `Second Voice.materials/`. Replace `Cover.png` and `Small Cover.png` if you want something else.
