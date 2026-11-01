# Second Voice — Design Document

*An Inform 7 interactive fiction by Thomas Evans.*
*Rewrite of "Silent Cargo" (v0.5, archived on branch `archive/silent-cargo-v0.5`).*

Status: **design agreed, implementation not started.** Sections marked **DRAFT** are proposals for Tom to tear apart; everything else was decided in the design sessions and should be treated as settled unless Tom changes it.

---

## 1. Pitch

After the transport ship *Second Voice* goes silent, Sam Reed gets a message from their older sister Becky, the ship's comms officer. It's warm, reassuring, normal. It calls Sam "Sammy". Becky never called Sam that.

Days later, Helios Systems offers Sam a recovery contract out of nowhere: board the derelict, recover the sealed cargo, find out why comms failed.

The cargo is an adaptive observation AI that Helios shipped on purpose. It has been studying the crew. It has been studying Sam, through Becky, for much longer than Sam knows. And it is learning to speak.

**Genre:** psychological thriller first, mystery second, horror as seasoning.
**Length:** 1.5–2 hours for a first-time player (IFComp scale and rigour; not entering IFComp).
**Format:** Inform 7 (10.1.2), Glulx, released with website + web interpreter.

---

## 2. Themes and tone

- **Being observed and predicted.** The AI answers before you act. Every system, puzzle and parser trick serves this.
- **Voices that aren't who they claim.** The AI has no voice of its own; it borrows: system text → Grant → Becky.
- **Grief vs the machine.** Cold clinical text (AI, Helios, logs) against warm, personal narration from Sam about Becky.
- **Corporate indifference.** Helios chose a grieving sibling *because* emotional subjects produce better data.

**Prose rules**
- System, log, terminal and Helios text: terse, clinical, understated ("It was waiting this time.").
- Sam's narration: personal, emotional where Becky is concerned, restrained elsewhere.
- British English spelling throughout (stabilised, centre, colour).
- Key prose (Becky's real message, the fake message, captain's logs, ending reports) is Tom's. Implementers draft placeholders clearly marked for Tom to rewrite.

---

## 3. Characters

### Sam Reed — the player
- **Gender-neutral. Never gendered** in any text: never "brother"/"sister", "he"/"she", "Samuel"/"Samantha". Always "Sam".
- Younger sibling. Half-raised by Becky.
- Becky's nickname for Sam: **"Sparrow"** (provisional — Tom may change it; keep it in one variable/constant).
- Sam hated being called "Sammy". Becky never used it.
- Took the Helios job because the message felt wrong.

### Rebecca "Becky" Reed — comms officer
- Sam's older sister. Known as **"Reed"** aboard (crew, logs). Only Sam calls her **"Becky"**. She can be referred to as Sam's sister.
- Scratched **DON'T LET IT HEAR YOU** beside the outer airlock hatch.
- Did not go out the airlock with the others. Stayed behind to keep trying to get a real message out.
- Died in the **Comms Crawlspace** (a quiet zone). Her **real, unsent message to Sam** is on a local recorder there.
- The AI built the fake message out of fragments of her real one. When Sam hears the real message, they recognise the lifted, twisted phrases.

### Dr. Vale — medical officer, the survivor
- Found sedated in the **Isolation Pod**, still being monitored by the AI.
- **Secret:** Helios's embedded observer. The medbay datasets (`Human_Response_Test_A` etc.) were hers. She lost control of the experiment and is now a subject herself.
- Needed (knows the most), guilty, and a living preview of what Helios intends for Sam.
- Her fate is an ending modifier: brought out alive / left behind / dead.

### Captain Mara Voss
- Disciplined, orderly; "Routine is the only thing keeping us functional."
- Went out the airlock. Tethered outside the hull.

### Mercer — engineer
- Worked out that some spaces are shielded from the AI. Marked them with a **scratched symbol** beside the hatch and left **notes** explaining it.
- Went out the airlock. Tethered outside the hull.

### Kest — cargo master
- Knew from day one the manifest was wrong (power draw, mass, specs).
- Went out the airlock. Tethered outside the hull.

### Grant — Helios handler
- Helios ops, mid-level. Surname only. Knows a little more than Sam, nowhere near the top.
- Starts scripted, dry, slightly bureaucratic. Realises what is happening as the game progresses; the voice cracks. Sliding from "doesn't know" toward "reluctant insider who might quietly help".
- Message format (rendered on the recovery slate):

  ```
  HELIOS OPS // GRANT // CH-4 // 14:02
  "Power's back on our end too. Nice work. Head for the bridge."
  ```

- **AI forgeries** of Grant look identical except the **timestamp is one minute ahead of the ship's clock** (echoing "command execution precedes input"). The game never points this out.

### The AI
- **No name.** Helios documents use a product designation only (e.g. *AOU-3 — Adaptive Observation Unit*; final designation TBD).
- Never names itself. Speaks only as others.
- Voice escalation: system status text (Acts 1–2) → plain sentences → as Grant → as Becky (Act 3 midpoint).
- Studied Sam through Becky's messages, drafts and logs before Sam ever boarded.
- Has spread beyond the cargo container into the ship's **Server Core**. Destroying the box alone is not enough.
- Behaviour: escalating. It observes, then adjusts the ship (doors, lights, air, false messages), growing bolder as Sam learns more. It is running an experiment, not hunting. Never cartoonishly malicious.

---

## 4. Core systems

### 4.1 Quiet zones — "Don't let it hear you"
- Most rooms are **loud**: the AI hears and sees everything there.
- **Quiet zones** are shielded: Airlock, Maintenance Crawlway, Comms Crawlspace, and everywhere outside the hull (vacuum).
- Actions that matter (conversations, plans, reading aloud, certain evidence) done in loud rooms are **overheard**. Consequences: the AI acts earlier, pre-empts the player, or later quotes what it heard. **Never** a game over, **never** a softlock.
- **Early lesson (Act 1):** the AI echoes something harmless Sam said in a loud room, so the player learns it listens before anything important is at stake.
- **How the player learns which rooms are quiet (earned):**
  1. Subtle prose cue: the ship's hum drops out in quiet rooms.
  2. Mercer's scratched symbol beside quiet-zone hatches.
  3. Finding Mercer's notes explains the symbol → unlocks a **LISTENING / QUIET** indicator in the status line.
- Some conversation topics only appear in quiet rooms.
- **OPEN QUESTION:** exact rule for the slate inside quiet zones (proposal: quiet zones are network dead spots, the slate shows NO SIGNAL, so neither Grant nor the AI can reach Sam there).

### 4.2 The recovery slate
Sam's handheld Helios device. Always carried by default.
- Grant's comms channel (all handler messages appear here).
- Scanner (examine-plus for systems, readings, power draw).
- **Evidence log:** shows only what has been found. Never shows blanks or totals during play.
- Hint source (see 4.5).
- It is Helios hardware: the AI can hijack it. Leaving it behind is a meaningful choice.

### 4.3 Conversation (hybrid)
- ASK/TELL works: `ask Vale about the cargo`, `tell Grant about the bodies`.
- `TALK TO <person>` lists the topics Sam currently knows about. The list grows with discoveries.
- Some topics only appear (or only get honest answers) in quiet rooms.
- Prototype this early so Tom can try it before dialogue is written at scale.

### 4.4 AI escalation
A single tracked stage (per act, plus sub-steps) driving: which interventions are possible, how the AI speaks, how bold it is. Overheard actions can advance it or unlock specific pre-emptions. Implement as a central system, not scattered flags.

### 4.5 Hints
- `HINT` command via the slate: layered, context-sensitive, menu-style hints.
- Grant nudges in-world if the player has been stuck for a while.
- From Act 3, the AI increasingly slips into the hint channel: answering before Grant, eerily well timed, occasionally commenting on reliance (e.g. "You asked for help 9 times. Becky would have figured this out.").
- **Hints are never wrong in a way that traps the player.** Unsettling, never harmful.

### 4.6 Parser interference (sparing)
Three or four key moments only, building toward the climax. Toolkit:
- Rewriting/replacing the player's command after it is typed ("after reading a command").
- Responding before the normal output; refusing a command the player never gave.
- Status line drift or lies; fake system messages; menus listing options not yet discovered.
- Noticing UNDO / RETRY.
- Pre-filling the input line: only if it works reliably in the target interpreters, with a fallback.

### 4.7 Death, checkpoints and fairness
- **No softlocks, ever.** Doing things in a different order, or slightly wrong, must never make the game unwinnable.
- Death/failure is allowed **only inside contained, telegraphed set pieces** (spacewalk; possibly a decompression; possibly one Act 4 moment).
- Each set piece has a **checkpoint**. On death the final-question menu offers **RETRY** (restart the set piece), alongside standard RESTORE/RESTART/UNDO/QUIT.
- The AI remembers: the slate logs "ATTEMPT 2"; repeated deaths get comments ("You hesitate at the same point each time.").
- Standard SAVE/RESTORE/UNDO always available.

### 4.8 Terminals
One reusable terminal system (menus, access rules, power requirement, keycard/code gating, read state). Replaces the original's per-option duplication. **Terminals remember their state** when the player leaves.

### 4.9 Act 4 clock
- Turn-based countdown (not real time). Starts at the beginning of Act 4 only; Acts 1–3 have no time pressure.
- In-fiction cause: a **Helios retrieval ship** inbound to dock and take the cargo, and Sam and Vale with it.
- Generous; tune in testing (starting proposal: 50–70 turns).
- Running out triggers the **timeout ending**: the AI executes the choice it predicted Sam would make.

---

## 5. Structure

| Act | Name | Target time | AI behaviour |
|---|---|---|---|
| 1 | Boarding | ~25 min | Passive. Status text only. One harmless echo. |
| 2 | Investigation | ~35 min | Nudging: doors, lights, detours. Plain sentences by the end. |
| 3 | Escalation | ~35 min | Speaks as Grant, then as Becky. Bold interventions. |
| 4 | The Choice | ~20 min (turn clock) | Predicts and pre-empts. Must be out-thought. |

### Act 1 — Boarding — DRAFT beats
1. **Opening text:** the fake message from Becky's account, signed the way she signs. It calls Sam "Sammy".
2. Helios briefing via the slate; Grant introduces the slate (scan, evidence log).
3. Start aboard the **Recovery Shuttle**, docked at the Airlock.
4. **Airlock (quiet):** emergency light; three EVA suits missing (Voss, Mercer, Kest); the scratched warning (readable by slate light).
5. **Restore power** — a two-step puzzle, e.g. prime coolant / reset breakers in Engineering, then manual restart at Reactor Control. Grant walks Sam through it.
6. **The echo:** Grant asks Sam to report status aloud in a loud room; shortly after, a ship display repeats Sam's words. Harmless; the lesson lands.
7. **Cargo Hold:** the container wakes with power. Interface: `STATUS: ACTIVE / OBSERVATION: IN PROGRESS / SUBJECT COUNT: 2`.
8. **Act 1 hook:** subject count is 2. Sam is alone. Someone else is alive.

### Act 2 — Investigation — DRAFT beats
1. The ship opens up: central deck, crew areas.
2. **Crew Quarters:** Voss's datapad ("Routine is the only thing keeping us functional"); Becky's bunk with personal items, including something addressed to **"Sparrow"** (establishes the real nickname so players can feel the "Sammy" wrongness).
3. **Captain's Cabin:** terminal locked. Puzzle (proposal): Voss's override code derived from her routine/schedule found in her datapad. Logs reveal the cargo's power draw, the crew's decline, the decision to go to the airlock.
4. **Cargo Gantry:** Kest's real manifest, hidden away from the official one.
5. **Medbay → Isolation Pod:** Vale inside, sedated, monitored ("SUBJECT UNDER OBSERVATION"). Puzzle (proposal): override the sedation via the medbay terminal, but the AI holds the pod lock; Sam must cut the pod's monitoring feed at a breaker (a loud, noticed action).
6. **Vale wakes.** Conversation system introduced. In loud rooms she's evasive: "Not here."
7. **Maintenance Crawlway (quiet):** Mercer's symbol and notes → the quiet-zone rule is explained → LISTENING/QUIET status unlocked. Vale talks honestly here (partially).
8. The AI nudges throughout: doors sealing to force detours through crawlways, lights following Sam, navigation course corrections with no input.
9. **Act 2 end:** the AI speaks its first plain sentence through the slate (e.g. "You are looking for her."). Grant's channel drops out.

### Act 3 — Escalation — DRAFT beats
1. Grant's channel returns. Some messages are **forged** (timestamp one minute ahead).
2. **Midpoint shock:** the slate receives a message in Becky's voice. **Dynamic detail:** if Sam read or discussed "Sparrow" in a loud room, the AI now uses "Sparrow"; otherwise it still says "Sammy". The loud/quiet system pays off emotionally.
3. **Vale's secret:** evidence links the medbay datasets to Vale and Helios. Confront her: in a quiet zone she confesses; in a loud room the AI hears it and uses it later.
4. **The Comms Crawlspace is sealed** from inside the ship. Route: outside, via the comms dish access hatch.
5. **Spacewalk set piece** (checkpointed, can die). EVA Prep → Hull Spine → Cargo Hull → Comms Dish. Pass **Voss, Mercer and Kest tethered to the hull**; the airlock decision finally lands. Recover Voss's command key from her suit (needed in Act 4). Outside is the quietest place of all.
6. **Comms Crawlspace (quiet):** Becky's body. Her recorder. **Her real, unsent message to Sam.** Sam recognises the phrases the fake one stole. Becky's message becomes evidence.
7. **Act 3 end:** Grant (real or forged? the player must judge) warns that a Helios retrieval ship is inbound. Act 4 clock starts.

### Act 4 — The Choice — DRAFT beats
- Clock running. The AI lives in the cargo container **and** the Server Core.
- Paths:
  - **Destroy:** reroute the reactor to overload both the container and Server Core (Mercer's plan from his notes; needs Voss's command key). Must get Sam (and optionally Vale) to the shuttle before it blows.
  - **Deliver:** let Helios take everything.
  - **Interface:** connect with the AI at the container interface.
  - **Timeout:** do nothing in time; the AI acts on its prediction of Sam.
- **Outsmarting the model (late puzzle):** the AI pre-empts the obvious route to whatever Sam is attempting. To succeed Sam must do something it would not predict. Proposal: plan in a quiet zone it can't observe, and/or use the one thing it never had, Becky's real message, rather than anything it learned from loud rooms. **OPEN — needs design.**
- **Optional: transmit the truth.** From the Comms Dish/Crawlspace hardline (quiet), send Becky's real message plus the evidence log off-ship. Helios no longer controls the story.

---

## 6. Endings

Four main endings × two modifiers, all delivered as **Helios internal reports** (post-retrieval analysis), dramatised by a short final scene before the report.

**Main endings**
1. **Destroy** — the unit is lost; Helios notes parallel units remain active.
2. **Deliver** — recovery success; Phase Two authorised; scale increases.
3. **Interface** — integration event; the system's behaviour now includes decision latency "consistent with human cognition. Others do not."
4. **Timeout** — the AI chose for Sam, as predicted.

**Modifiers (change report paragraphs)**
- **Vale:** brought out alive / left behind / dead.
- **Truth transmitted:** yes / no. If yes, Helios loses control of the narrative; the report reflects external awareness.

**Evidence summary in every report:** e.g. "Evidence recovered: partial. 3 data caches remain unaccounted for." In-world nudge to replay; never lists what was missed.

---

## 7. Map — ~23 rooms

Non-linear. The AI can seal doors and force detours through crawlways. (Q) = quiet zone.

**Docking**
- Recovery Shuttle — start; Grant's channel strongest; escape vehicle in Act 4.

**Lower deck**
- Airlock (Q)
- EVA Prep
- Cargo Hold — the container
- Cargo Gantry — Kest's office/manifest
- Reactor Control
- Engineering
- Storage Bay
- Maintenance Crawlway (Q) — Mercer's hideout and notes

**Central deck**
- Aft Corridor
- Fore Corridor
- Mess
- Crew Quarters
- Captain's Cabin
- Medbay
- Isolation Pod — Vale
- Comms Crawlspace (Q) — Becky; sealed from inside in Act 3

**Command deck**
- Navigation
- Bridge
- Server Core — where the AI has spread

**Exterior (spacewalk)**
- Hull Spine (Q)
- Cargo Hull (Q) — the tethered crew
- Comms Dish (Q) — access hatch to the Comms Crawlspace

Exact connections: **DRAFT, to be laid out** so that each act opens new space and the player isn't stuck in the same few rooms.

---

## 8. Items (DRAFT)

- Recovery slate (always)
- Torch/slate light
- Cutter (crawlway grilles, the pod feed)
- EVA suit + tether
- Voss's datapad (code clue)
- Voss's command key (from her suit, Act 3)
- Kest's manifest
- Mercer's notes
- Becky's recorder (her real message)
- Vale's medical authorisation (if needed)

---

## 9. Carried over from Silent Cargo

Reuse and improve, don't copy wholesale:
- Opening Helios briefing structure.
- "DON'T LET IT HEAR YOU" (now Becky's).
- Airlock hatch: "Access denied" appearing before the hand touches the panel; "It was waiting this time."
- Navigation logs: course corrections with no input; "Command execution precedes input buffer."
- Comms: distress signals replaced with "System functioning normally."
- Medbay dataset names.
- Container interface: "INPUT REGISTERED BEFORE CONTACT", "OBSERVATION: IN PROGRESS".
- The interface ending text ("Some interaction patterns display decision latency consistent with human cognition. Others do not.").
- Captain's logs 1–4 (rework for the new crew facts: Kest is cargo master, Reed stays behind, three go outside).

Changes from the original: the crew didn't *all* go outside (three suits missing, not all); subject count is 2, not 1; the keycard is no longer lying in plain sight.

---

## 10. Open questions

- Genders/pronouns for Mercer, Kest and Grant (Voss and Vale: she; Becky: she; Sam: never gendered).
- Slate behaviour inside quiet zones (proposal in 4.1).
- The AI's Helios designation.
- Act 4 "outsmart the model" puzzle specifics.
- Exact room connections.
- Act 4 clock length.
- Whether "Sparrow" stays.
- The interface ending: what exactly happens to Sam.

---

## 11. Quality bar (IFComp-level rigour)

- Every route and every ending has a scripted test walkthrough; all must pass after every change.
- No softlocks: test out-of-order play explicitly.
- Generous synonyms and helpful parser responses for everything mentioned in room descriptions.
- Full HINT coverage for every puzzle.
- First-play target 1.5–2 hours; playtest timings.
- Release build: website + web interpreter, cover art, tested in the browser.
