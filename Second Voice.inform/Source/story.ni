"Second Voice" by Thomas Evans

Use no scoring.

Include Basic Screen Effects by Emily Short.

The story headline is "An interactive fiction". The story description is "A transport ship has gone silent. Your sister's last message called you something she never called you. Helios Systems would like you to go and find out why." The release number is 1.

Release along with cover art ("A dark derelict transport ship in space, one window lit, with a tiny tethered astronaut drifting beside its hull."), a website and an interpreter.

The story genre is "Science Fiction".

Volume 1 - Framework

Book 1 - Quiet Zones

An act is a kind of value. The acts are act-one, act-two, late-act-two, act-three, act-four and never-act.

The current act is an act that varies. The current act is act-one.

Every room has an act called the opening act.

A room can be quiet, loud or roaring. A room is usually loud.

First report going:
	if the room gone from is not quiet and the room gone to is quiet:
		say "The ship's hum drops away behind you.[paragraph break]";
	otherwise if the room gone from is quiet and the room gone to is not quiet:
		say "The hum closes back in around you.[paragraph break]".

To decide whether signal is available:
	if the location is quiet, decide no;
	decide yes.

To decide whether signal is lost:
	if the location is quiet, decide yes;
	decide no.

Book 2 - Recovery Slate

Chapter 1 - The Slate

The player carries the recovery slate. Understand "helios" and "handheld" and "device" as the recovery slate. The description of the recovery slate is "Helios hardware, scuffed at the corners.[paragraph break][slate guide]".

Table of Slate Commands
usage	purpose	needs signal	available
"TALK TO GRANT"	"see what you can ask him"	true	true
"ASK GRANT ABOUT something"	"or TELL GRANT ABOUT something"	true	true
"REPORT"	"say something aloud for Grant, or REPORT followed by your words"	true	false
"MESSAGES"	"reread what you've received"	false	true
"EVIDENCE"	"review what you've found"	false	true
"SCAN something"	"take a reading of anything nearby"	false	true
"HINT"	"get a nudge, and again for a bigger one"	false	true
"TALK TO someone"	"or ASK someone ABOUT something, if anyone's here to answer"	false	false
"VALE, STAY"	"or VALE, COME: she follows you unless you tell her otherwise"	false	false
"ETA"	"see how long until the retrieval ship docks"	false	false

To unlock the slate command (U - a text):
	choose the row with a usage of U in the Table of Slate Commands;
	now the available entry is true.

To say slate guide:
	say "[if signal is lost]NO SIGNAL[otherwise if the carrier lost is true]CH-4: NO CARRIER[otherwise]SIGNAL: CH-4[end if][line break]";
	repeat through the Table of Slate Commands:
		if the available entry is true:
			say "[usage entry]";
			if the needs signal entry is true and signal is lost:
				say " (no signal)";
			otherwise:
				say " - [purpose entry]";
			say "[line break]".

Consulting the slate is an action out of world applying to nothing. Understand "slate" and "help" and "commands" and "about" as consulting the slate.

Carry out consulting the slate:
	say "[slate guide]".

Understand "check [something]" as examining.

Instead of opening the recovery slate, try examining the recovery slate.
Instead of switching on the recovery slate, try examining the recovery slate.

Using is an action applying to one thing. Understand "use [something]" as using.

Check using:
	say "Try saying how you want to use [the noun]." instead.

Instead of using the recovery slate, try examining the recovery slate.
Instead of using Grant, try talking to Grant.
Instead of using a ship control, try operating the noun.

Rule for printing a parser error when the latest parser error is the not a verb I recognise error:
	say "That's not a verb I recognise. Type SLATE to see what the slate can do, or HINT if you're stuck."

To refuse to part with the slate:
	say "The slate stays with you. It's your only line out."

Instead of dropping the recovery slate, refuse to part with the slate.
Instead of inserting the recovery slate into something, refuse to part with the slate.
Instead of putting the recovery slate on something, refuse to part with the slate.
Instead of giving the recovery slate to someone, refuse to part with the slate.
Instead of throwing the recovery slate at something, refuse to part with the slate.

Chapter 2 - Ship Clock

To say clock (T - a time):
	let H be the hours part of T;
	let M be the minutes part of T;
	if H is less than 10, say "0";
	say "[H]:";
	if M is less than 10, say "0";
	say "[M]".

When play begins:
	now the time of day is 2:00 PM;
	now the left hand status line is "[the player's surroundings][hearing status]";
	now the right hand status line is "[status clock]".

The quiet rule is a truth state that varies.

To say hearing status:
	if the quiet rule is true:
		say " // [if the location is quiet]QUIET[otherwise]LISTENING[end if]".

To say status clock:
	if the current act is act-four:
		say "[clock 1 minute after the time of day]";
	otherwise:
		say "[clock the time of day]".

Chapter 3 - Messages

Table of Slate Messages
stamp (a time)	body (a text)	forged (a truth state)	delivered (a truth state)	personal (a truth state)
with 40 blank rows.

To send Grant message (T - a text):
	choose a blank row in the Table of Slate Messages;
	now the stamp entry is the time of day;
	now the body entry is T;
	now the forged entry is false;
	now the delivered entry is false;
	now the personal entry is false.

To send personal message (T - a text):
	send Grant message T;
	repeat through the Table of Slate Messages:
		if the body entry is T and the delivered entry is false:
			now the personal entry is true.

To send forged Grant message (T - a text):
	send Grant message T;
	repeat through the Table of Slate Messages:
		if the body entry is T and the delivered entry is false:
			now the forged entry is true.

To say message stamped (T - a time) reading (B - a text):
	say "HELIOS OPS // GRANT // CH-4 // [clock T][line break][B]".

To say personal message reading (B - a text):
	say "FROM: R. REED // TRANSPORT SECOND VOICE // COMMS[line break][B]".

To deliver waiting messages:
	repeat through the Table of Slate Messages:
		if the delivered entry is false:
			if the forged entry is true:
				now the stamp entry is 1 minute after the time of day;
			now the delivered entry is true;
			if the personal entry is true:
				now the reply hijacked is true;
				say "The slate buzzes.[paragraph break][personal message reading the body entry][paragraph break]";
			otherwise:
				say "The slate buzzes.[paragraph break][message stamped the stamp entry reading the body entry][paragraph break]".

Every turn when signal is available and the carrier lost is false:
	deliver waiting messages.

After printing the banner text:
	deliver waiting messages;
	say "(Type SLATE to see what it can do, or TALK TO GRANT to speak to your handler.)[paragraph break]".

Reading messages is an action out of world applying to nothing. Understand "messages" and "message" and "msgs" and "read messages" as reading messages.

Carry out reading messages:
	let shown be false;
	repeat through the Table of Slate Messages:
		if the delivered entry is true:
			now shown is true;
			if the personal entry is true:
				say "[personal message reading the body entry][paragraph break]";
			otherwise:
				say "[message stamped the stamp entry reading the body entry][paragraph break]";
	if shown is false, say "No messages."

Chapter 4 - Evidence Log

Table of Evidence
source (an object)	key (a text)	entry (a text)	reveals (a text)	found (a truth state)
scratched warning	--	"Scratched beside the outer airlock hatch: DON'T LET IT HEAR YOU."	"the warning"	false
suit rack	--	"Airlock suit rack: three EVA suits missing. Tags VOSS, MERCER, KEST."	"the crew"	false
shipping container	--	"Cargo container drawing power with the ship otherwise barely awake."	"the container"	false
Voss's datapad	--	"Voss's datapad: a day planned to the minute, until the entries stop."	"the captain"	false
Becky's letter	--	"A letter in Reed's hand, never sent."	"the letter"	false
Kest's real manifest	--	"Kest's real manifest: mass, power draw and heat that match no sealed crate."	"the manifest"	false
Mercer's notes	--	"Mercer's notes: shielded compartments, the symbol, and a plan for the reactor."	"the symbol"	false
--	"captain's last log"	"Voss's last log: the crew moved to the airlock, and it heard them go."	"the airlock"	false
--	"datasets"	"Medbay datasets: Human_Response_Test_A and others. Owner field redacted. One still active."	"the datasets"	false
--	"course corrections"	"Navigation log: course corrections with no input. 'Command execution precedes input buffer.'"	"the course"	false
--	"comms log"	"Comms log: distress signals replaced with 'System functioning normally.' Crawlspace hatch sealed from inside by R. REED."	"the crawlspace"	false

To log the evidence (K - a text):
	repeat through the Table of Evidence:
		if there is a key entry and the key entry is K and the found entry is false:
			now the found entry is true;
			learn the topic the reveals entry;
			say "(Logged to slate.)[line break]".

To decide what number is the evidence found:
	let N be 0;
	repeat through the Table of Evidence:
		if the found entry is true, increase N by 1;
	decide on N.

To decide what number is the evidence total:
	decide on the number of filled rows in the Table of Evidence.

To log evidence from (O - an object):
	repeat through the Table of Evidence:
		if there is a source entry and the source entry is O and the found entry is false:
			now the found entry is true;
			learn the topic the reveals entry;
			say "(Logged to slate.)[line break]".

Report examining something:
	log evidence from the noun.

Viewing evidence is an action out of world applying to nothing. Understand "evidence" and "log" and "evidence log" as viewing evidence.

Carry out viewing evidence:
	let shown be false;
	repeat through the Table of Evidence:
		if the found entry is true:
			now shown is true;
			say "- [entry entry][line break]";
	if shown is false, say "Nothing logged."

Chapter 5 - Scanner

A thing has a text called the scan reading. The scan reading of a thing is usually "Nothing of note."

Scanning is an action applying to one visible thing. Understand "scan [something]" as scanning.

Carry out scanning:
	say "SCAN // [the scan reading of the noun][line break]";
	log evidence from the noun.

Chapter 6 - Hints

A goal is a kind of value. The goals are boarding, reaching engineering, restoring systems, restarting the reactor, giving a report, reaching the hold, reading the interface, reaching the central deck, finding the second subject, getting the override, freeing the pod lock, getting a cutter, escaping to the crawlway, reading the notes, reaching the bridge, reading the comms log, getting back to signal, finding the way outside, suiting up, crossing the hull, hearing her message, choosing an answer, outthinking the model and running for the shuttle.

Table of Hints
goal	first hint	second hint	third hint	nudge	shown (a number)	nudged (a truth state)
boarding	"You came here to board the ship."	"The airlock is the only way in from the shuttle."	"Go east."	"'Airlock's east of you. Whenever you're ready.'"	0	false
reaching engineering	"The ship has no power. Find out why."	"Engineering is on this deck, past the Storage Bay."	"From the Airlock go east, then east again."	"'Engineering is east of the Storage Bay.'"	0	false
restoring systems	"Two systems in Engineering must be ready before a restart."	"Look at the coolant valve and the breaker panel."	"OPEN VALVE and RESET BREAKERS."	"'Coolant and breakers first. Both in Engineering.'"	0	false
restarting the reactor	"Coolant and breakers are ready. The restart itself is manual."	"Reactor Control is south of Engineering."	"Go to Reactor Control and PULL LEVER."	"'Manual restart. Reactor Control, south of Engineering.'"	0	false
giving a report	"Grant wants a status report, out loud."	"The slate's microphone needs a signal to reach him."	"Somewhere with signal, type REPORT, or REPORT followed by what you want to say."	"'Still waiting on that report, Sam.'"	0	false
reaching the hold	"Grant wants you in the Cargo Hold."	"The Cargo Hold is north of the Storage Bay."	"Go to the Storage Bay, then go north."	"'Cargo Hold, north of the Storage Bay.'"	0	false
reading the interface	"The container has woken up. It has an interface."	"Read what the interface says."	"EXAMINE INTERFACE."	"'What's the interface say?'"	0	false
reaching the central deck	"Something unlocked when the interface read 2."	"The ladder in the Storage Bay, or the gantry above the hold."	"From the Storage Bay, go UP."	"'Ladder in the Storage Bay, Sam.'"	0	false
finding the second subject	"Subject count: 2. Someone on this ship is alive, and medical records would know."	"The Medbay is on the central deck, north of the Mess."	"Go to the Medbay and use its terminal."	"'If anyone's alive, Medbay will know. North of the Mess.'"	0	false
getting the override	"She's sedated. The pod's sedation is controlled from outside it."	"The medbay terminal has a sedation override."	"USE MEDBAY TERMINAL in the Medbay, then choose Sedation override."	"'Medbay terminal should have a sedation control.'"	0	false
getting a cutter	"The monitoring feed is thick cable, too thick for hands."	"You passed a tool among the crates in the Storage Bay."	"TAKE CUTTER in the Storage Bay."	"'Stores lists a hull cutter. Storage Bay.'"	0	false
freeing the pod lock	"The feed holds the pod lock. It won't let go of its own accord."	"It runs to the breaker box in the Isolation Pod. It will be noticed. There's no other way."	"In the Isolation Pod: CUT FEED."	"'Whatever's holding that pod, cut it.'"	0	false
escaping to the crawlway	"Vale wrote on your palm: UNDER MESS. GRILLE."	"The floor grille in the Mess lifts. There's no hum below it."	"From the Mess, go DOWN."	"'Where have you gone? I've lost you on the plan.'"	0	false
reading the notes	"Somebody was living in the crawlway. They left more than a bedroll."	"Mercer's notes are wedged behind a pipe. Reading them anywhere else may be unwise."	"In the Maintenance Crawlway: READ NOTES."	"'Anything down there I should know about?'"	0	false
reaching the bridge	"The command deck has opened."	"The ladder is in the Fore Corridor. Navigation is at the top, the Bridge east of it."	"From the Fore Corridor: UP, then EAST."	"'Get to the Bridge, Sam.'"	0	false
getting back to signal	"You've heard her. Nothing can reach you here, and you've a feeling a lot's been trying."	"Find somewhere with signal: the hatch to the Fore Corridor can be unsealed from this side, and the hull leads back to EVA Prep."	"UNSEAL HATCH, then go SOUTHEAST."	"'Sam, get back in range.'"	0	false
finding the way outside	"The hatch from the corridor is welded. The comms log told you another way in."	"Exterior dish access. Suits are kept in EVA Prep, north of the Airlock."	"Go to EVA Prep, north of the Airlock."	"'If you're going outside, EVA Prep. North of the Airlock.'"	0	false
suiting up	"Nobody crosses the hull in overalls."	"There's a suit on the rack here."	"TAKE SUIT, then WEAR SUIT, then go WEST."	"'Suit up, Sam.'"	0	false
crossing the hull	"The dish is at the far end of the hull. Keep going forward, and watch the suit's warnings."	"When the suit warns of a burn, CLIP to the rail until it passes."	"NORTH to the Cargo Hull, NORTH to the Comms Dish, then DOWN through the hatch. CLIP when warned. Voss's key is on her suit in the Cargo Hull."	"'You've been out there a long time.'"	0	false
hearing her message	"You came all this way for her. There's something here you haven't listened to."	"Her recorder, in the Comms Crawlspace."	"In the Comms Crawlspace: PLAY RECORDER. If you've left, go back: the hatch from the dish is open."	"'Why did you come back in? What did you find out there? Go back, Sam.'"	0	false
choosing an answer	"The retrieval ship is on its way. What do you want to be true when it arrives?"	"Mercer left a plan, the interface offers other answers, and the Crawlspace has a hardline that needs the dish re-aligned from the Bridge."	"Destroy: READ NOTES, CUT LINK at the Server Core, CUT ISOLATOR in the Cargo Hold, then TURN KEY in Reactor Control (Voss has the key, out on the Cargo Hull). Deliver or Interface: USE INTERFACE in the Cargo Hold. Truth: USE BRIDGE CONSOLE then USE HARDLINE in the Crawlspace."	"'Whatever you're doing, do it soon.'"	0	false
outthinking the model	"It answered before you touched the key. It has predicted you from everything it ever heard."	"What's the one thing on this ship it has never heard? And whose hands has it stopped watching?"	"PLAY RECORDER here, or, if she's with you, VALE, TURN KEY."	"'Something's locked me out of your console, Sam. Think.'"	0	false
running for the shuttle	"Get off the ship."	"The Shuttle is west of the Airlock. If a door's sealed, EVA Prep connects the Cargo Hold and the Airlock."	"Reach the Recovery Shuttle, with Vale if you can, then UNDOCK."	"'Get out of there!'"	0	false
reading the comms log	"The comms array has been lying, and the Bridge can show you how."	"The bridge console keeps a comms log."	"USE BRIDGE CONSOLE, then choose Comms log."	"'What does the comms log say?'"	0	false

To decide which goal is the current goal:
	if the overload armed is true, decide on running for the shuttle;
	if the current act is act-four:
		if the key refused is true and the model beaten is false, decide on outthinking the model;
		decide on choosing an answer;
	if the current act is act-three:
		if the recorder is played, decide on getting back to signal;
		if the Comms Crawlspace is visited, decide on hearing her message;
		if the location is in the Exterior, decide on crossing the hull;
		if the location is EVA Prep, decide on suiting up;
		decide on finding the way outside;
	if the current act is at least act-two:
		if the current act is less than act-three:
			if Vale is unresponsive:
				if the location is not in the Central Deck, decide on reaching the central deck;
				if the medbay terminal is unvisited, decide on finding the second subject;
				if the override queued is false, decide on getting the override;
				if the player does not carry the cutter and the monitoring feed is intact, decide on getting a cutter;
				decide on freeing the pod lock;
			if Mercer's notes are unread:
				if the location is not the Maintenance Crawlway and the Maintenance Crawlway is unvisited, decide on escaping to the crawlway;
				decide on reading the notes;
			if the location is the Bridge, decide on reading the comms log;
			decide on reaching the bridge;
	if the ship has power:
		if Sam has not reported, decide on giving a report;
		if the location is the Cargo Hold, decide on reading the interface;
		decide on reaching the hold;
	if the coolant valve is engaged and the breaker panel is engaged, decide on restarting the reactor;
	if Engineering is visited, decide on restoring systems;
	if the location is the Recovery Shuttle, decide on boarding;
	decide on reaching engineering.

Asking for a hint is an action out of world applying to nothing. Understand "hint" and "hints" as asking for a hint.

Carry out asking for a hint:
	choose the row with a goal of the current goal in the Table of Hints;
	if signal is available:
		say "SLATE // HINT[line break]";
	otherwise:
		say "SLATE // HINT // NO SIGNAL // CACHED[line break]";
	increase the hints asked by 1;
	increase the shown entry by 1;
	if the shown entry is 1:
		say "[first hint entry][line break]";
	otherwise if the shown entry is 2:
		say "[second hint entry][line break]";
	otherwise:
		say "[third hint entry][line break]";
	if signal is available and the AI stage is at least forging:
		if the hints asked is 3 or the hints asked is 6:
			say "[line break]The next line arrives before you've finished reading that one.[line break]You already knew that.[line break]";
		otherwise if the hints asked is at least 9 and the reliance comment made is false:
			now the reliance comment made is true;
			say "[line break]You asked for help [hints asked] times. Becky would have figured this out.[line break]".

The hints asked is a number that varies. The reliance comment made is a truth state that varies.

The goal last seen is a goal that varies. The goal last seen is boarding. The turns stuck is a number that varies.

Every turn:
	if the current goal is not the goal last seen:
		now the goal last seen is the current goal;
		now the turns stuck is 0;
	otherwise:
		increase the turns stuck by 1;
	if the turns stuck is at least 20 and signal is available:
		choose the row with a goal of the current goal in the Table of Hints;
		if the nudged entry is false:
			now the nudged entry is true;
			send Grant message the nudge entry.

Book 3 - Terminals

[One system for every terminal, and never modal: the screen lists entries, the player types a number as an ordinary turn, so the parser, the clock and the AI all stay live. One terminal per room.]

A terminal is a kind of thing. A terminal is usually fixed in place. Understand "terminal" and "screen" and "computer" as a terminal.

A terminal can be mains-powered or battery-backed. A terminal is usually mains-powered.
A terminal can be secured or cleared. A terminal is usually cleared.
A terminal has a number called the access code.
A terminal has an object called the required keycard.
A terminal has a text called the heading.
A terminal can be visited or unvisited. A terminal is usually unvisited.

Table of Terminal Entries
owner (a terminal)	label (a text)	contents (a text)	available (a truth state)	read before (a truth state)	effect (a rule)
stores terminal	"Stores inventory"	"Spares, filters, sealant, ration packs. All counts within tolerance. One crate of filters signed out to the hold, with no reason given."	true	false	--
stores terminal	"Last stores note"	"KEST: 'Count's wrong again. Not ours to query, apparently.'"	true	false	--

To reveal terminal entry (L - a text):
	choose the row with a label of L in the Table of Terminal Entries;
	now the available entry is true.

To decide whether (T - a terminal) refuses access:
	if T is mains-powered and the ship does not have power:
		say "The screen is dark. No power.";
		decide yes;
	if T is secured:
		if the required keycard of T is not nothing:
			if the player does not carry the required keycard of T:
				say "[heading of T][line break]KEYCARD REQUIRED.";
				decide yes;
			now T is cleared;
			say "KEYCARD ACCEPTED.[paragraph break]";
			decide no;
		say "[heading of T][line break]LOCKED. ENTER a code to continue.";
		decide yes;
	decide no.

To show the screen of (T - a terminal):
	if T refuses access, stop;
	now T is visited;
	say "[heading of T][line break]";
	let N be 0;
	repeat through the Table of Terminal Entries:
		if the owner entry is T and the available entry is true:
			increase N by 1;
			say "[N]. [label entry][if the read before entry is true] (read)[end if][line break]";
	if N is 0:
		say "No entries.";
	otherwise:
		say "Type a number to choose."

Instead of examining a terminal, show the screen of the noun.
Instead of using a terminal, show the screen of the noun.
Instead of opening a terminal, show the screen of the noun.
Instead of switching on a terminal, show the screen of the noun.

Logging in is an action applying to nothing. Understand "login" and "log in" as logging in.

Check logging in:
	if no terminal is in the location, say "There's no terminal here." instead.

Carry out logging in:
	show the screen of a random terminal in the location.

Choosing is an action applying to one number. Understand "[number]" and "read [number]" and "read log [number]" and "open [number]" and "select [number]" and "choose [number]" and "pick [number]" as choosing.

Check choosing:
	if no terminal is in the location, say "There's no terminal here." instead.

Carry out choosing:
	let T be a random terminal in the location;
	if T is secured and the required keycard of T is nothing and the access code of T is not 0:
		if T is mains-powered and the ship does not have power:
			say "The screen is dark. No power.";
			stop;
		try entering the code the number understood;
		stop;
	if T refuses access, stop;
	let N be 0;
	repeat through the Table of Terminal Entries:
		if the owner entry is T and the available entry is true:
			increase N by 1;
			if N is the number understood:
				say "[label entry][paragraph break][contents entry][line break]";
				if the read before entry is false:
					now the read before entry is true;
					if there is an effect entry, follow the effect entry;
				stop;
	say "No such entry."

Entering the code is an action applying to one number. Understand "enter [number]" and "type [number]" and "code [number]" as entering the code.

After reading a command:
	let T be the substituted form of "[the player's command]";
	if T matches the text "18:40":
		replace the text "18:40" in T with "1840";
		change the text of the player's command to T.

Check entering the code:
	if no terminal is in the location, say "There's no terminal here." instead.

Carry out entering the code:
	let T be a random terminal in the location;
	if T is mains-powered and the ship does not have power:
		say "The screen is dark. No power.";
		stop;
	if T is cleared:
		say "No code is needed.";
		stop;
	if the required keycard of T is not nothing:
		say "[heading of T][line break]KEYCARD REQUIRED.";
		stop;
	if the number understood is the access code of T:
		now T is cleared;
		say "ACCESS GRANTED.[paragraph break]";
		show the screen of T;
	otherwise:
		say "INVALID CODE."

Book 4 - Conversation

Grant is a man. Grant is part of the recovery slate. Understand "handler" as Grant. The description of Grant is "A surname and a channel number. You've never seen his face."

The carrier lost is a truth state that varies.

To decide whether Grant can't be reached:
	if signal is lost or the carrier lost is true, decide yes;
	decide no.

To say Grant out of reach:
	if signal is lost:
		say "NO SIGNAL. Grant can't reach you here, and you can't reach him.";
	otherwise:
		say "CH-4 // NO CARRIER. There's nothing on Grant's channel but hiss."

Before doing something to Grant when Grant can't be reached:
	if we are examining Grant, continue the action;
	say "[Grant out of reach]" instead.

Instead of taking or touching or attacking or kissing or pushing or pulling Grant:
	say "He's a voice on a channel, nowhere you can reach."

Table of Conversation
speaker (a person)	topic	label (a text)	reply (a text)	honest reply (a text)	known (a truth state)	quiet only (a truth state)	overheard as (a text)	effect (a rule)
Grant	"the/-- cargo/manifest/container/box/shipment/unit/aou/aou-031"	"the container"	"'Sealed Helios property. Recover it, don't open it. That's the contract.'"	--	false	false	--	--
Grant	"the/-- ship/transport/second/voice"	"the ship"	"'Transport. Went silent in transit. Your job is to find out why.'"	--	true	false	--	--
Grant	"the/-- crew/voss/mercer/kest/vale/suits/suit"	"the crew"	"'I've got a manifest and no answers. Three suits gone, you say? Noted.'"	--	false	false	--	--
Grant	"becky/reed/rebecca/sister"	"Reed"	"'Comms Officer Reed is on the manifest. Status unknown, same as the rest.'"	--	true	false	--	--
Grant	"the/-- helios/contract/job/company"	"the contract"	"'Standard recovery terms. Above my pay grade, most of it.'"	--	true	false	--	--
Grant	"the/-- warning/scratches/scratch/hatch/hear/symbol"	"the warning"	"'Scratched by who? Log it. Probably nothing.' He doesn't sound sure."	--	false	false	--	--
Grant	"the/-- subject/count/two/subjects/survivor"	"the subject count"	"[if Vale is responsive]'A survivor nobody's told me about. I've asked. I've been told to stop asking.'[otherwise]'Two. Could be a fault. Find out.'[end if]"	--	false	false	--	--
Grant	"the/-- letter/sparrow/nickname"	"the letter"	"'Sorry, what? Say that again?' A pause. 'Doesn't matter. Keep it for your report.'"	--	false	false	"the nickname"	--
Grant	"the/-- retrieval/team/eta/inbound/docking"	"the retrieval ship"	"'Helios hull, inbound, no callsign I'm cleared for. It docks, it takes the cargo, it takes you. I've read the order twice. Type ETA for what my board says. And Sam? If anything I send you starts telling you to sit tight, it isn't me.'"	--	false	false	--	--
Grant	"the/-- power/reactor/coolant/breakers"	"power"	"[if the ship has power]'Reactor's up and holding on my board. Stick to the job.'[otherwise]'Prime coolant, reset breakers, then a manual restart. I'll talk you through it.'[end if]"	--	true	false	--	--

[Learning a topic applies to everyone who has a row for it.]
To learn the topic (L - a text):
	repeat through the Table of Conversation:
		if the label entry is L:
			now the known entry is true.

A person can be responsive or unresponsive. A person is usually responsive.

A person has a text called the unknown reply. A person has a text called the untold reply. A person has a text called the deflection.

The unknown reply of Grant is "'Not something I can help with.'". The untold reply of Grant is "'Log it and move on.'".

Definition: a person is at hand if it is responsive and it is not the player and it is not Grant and the location encloses it.

The last partner is a person that varies. The last partner is Grant.

[Whoever Sam last addressed if they're still here, then anyone here, then the slate.]
To decide which person is the conversation partner:
	if the last partner is at hand, decide on the last partner;
	if a person is at hand, decide on a random at hand person;
	decide on Grant.

To say (T - a text) or no answer:
	if T is "":
		say "You get no answer.";
	otherwise:
		say "[T]".

To have (P - a person) respond or else say (fallback - a text):
	now the last partner is P;
	if P is unresponsive:
		say "You get no answer.[line break]";
		stop;
	repeat through the Table of Conversation:
		if the speaker entry is P and the topic understood matches the topic entry:
			if the quiet only entry is true and the location is not quiet:
				say "[deflection of P or no answer][line break]";
				stop;
			if the location is quiet and there is an honest reply entry:
				say "[honest reply entry][line break]";
			otherwise:
				say "[reply entry][line break]";
			if there is an overheard as entry:
				have the AI hear the overheard as entry quoting the reply entry;
			if there is an effect entry, follow the effect entry;
			stop;
	say "[fallback or no answer][line break]".

Instead of asking someone about:
	have the noun respond or else say the unknown reply of the noun.

Instead of telling someone about:
	have the noun respond or else say the untold reply of the noun.

Talking to is an action applying to one visible thing. Understand "talk to [someone]" and "speak to [someone]" and "talk [someone]" and "call [someone]" and "contact [someone]" and "radio [someone]" and "message [someone]" and "reply to [someone]" and "[someone]" as talking to. Understand "talk" and "speak" as talking to.

Rule for supplying a missing noun while talking to:
	now the noun is the conversation partner.

Instead of answering someone that, try talking to the noun.

Instead of asking someone to try doing something, try talking to the person asked.

Asking generally is an action applying to one topic. Understand "ask about [text]" and "tell about [text]" and "talk about [text]" and "speak about [text]" and "discuss [text]" as asking generally.

Understand "talk to [someone] about [text]" and "speak to [someone] about [text]" and "talk with [someone] about [text]" and "speak with [someone] about [text]" and "ask [someone] [text]" as asking it about.

Understand "talk with [someone]" and "speak with [someone]" as talking to.

Instead of asking generally:
	try asking the conversation partner about the topic understood.

[A bare TALK only gets its noun after the Before rules have run.]
Check talking to:
	if the noun is Grant and Grant can't be reached, say "[Grant out of reach]" instead;
	if the noun is unresponsive, say "You get no answer." instead.

Carry out talking to:
	now the last partner is the noun;
	let N be 0;
	let held back be false;
	let example be "";
	repeat through the Table of Conversation:
		if the speaker entry is the noun and the known entry is true:
			if the quiet only entry is true and the location is not quiet:
				now held back is true;
			otherwise:
				if N is 0:
					say "You can ask [the noun] about:[line break]";
					now example is the label entry;
				increase N by 1;
				say "- [label entry][line break]";
	if N is greater than 0:
		say "Type ASK [the printed name of the noun in upper case] ABOUT [example in upper case], for example.";
	if held back is true:
		say "[if N is greater than 0][line break][end if][deflection of the noun or no answer][line break]";
	otherwise if N is 0:
		say "You get no answer."

Book 5 - AI Escalation

[Helios's product designation, for Helios paperwork only. The AI never names itself, so this never goes in anything it says.]

The AI designation is a text that varies. The AI designation is "AOU-031".

Chapter 1 - Stage

[The one measure of how far the AI has gone. The story raises it at each beat, and it never falls. Attention builds separately, from what Sam lets it hear.]

An escalation is a kind of value. The escalations are dormant, eavesdropping, nudging, speaking, forging and pre-empting.

The AI stage is an escalation that varies. The AI stage is dormant.

The AI attention is a number that varies.

To raise the AI stage to (E - an escalation):
	if E is greater than the AI stage, now the AI stage is E.

Chapter 2 - Overheard Matters

[One row per thing that matters if it's said or done in earshot. Anything with no row here doesn't matter to the AI. A quiet room hears nothing, and the first hearing in a roaring room counts double.]

Table of Overheard Matters
matter (a text)	heard (a truth state)	quote (a text)	turn heard (a number)	weight (a number)
"the report"	false	""	0	0

To have the AI hear (M - a text) quoting (Q - a text):
	if the location is quiet, stop;
	choose the row with a matter of M in the Table of Overheard Matters;
	if the heard entry is true, stop;
	now the heard entry is true;
	now the quote entry is the substituted form of Q;
	now the turn heard entry is the turn count;
	if the location is roaring:
		increase the AI attention by the weight entry times 2;
	otherwise:
		increase the AI attention by the weight entry.

To have the AI hear (M - a text):
	have the AI hear M quoting "".

To decide whether the AI heard (M - a text):
	choose the row with a matter of M in the Table of Overheard Matters;
	decide on whether or not the heard entry is true.

To decide what text is the AI quote of (M - a text):
	choose the row with a matter of M in the Table of Overheard Matters;
	decide on the quote entry.

To decide what number is the turns since the AI heard (M - a text):
	choose the row with a matter of M in the Table of Overheard Matters;
	decide on the turn count minus the turn heard entry.

Chapter 3 - Interventions

[Each row runs once, the first turn its conditions hold and its rule succeeds. A rule can fail to wait for a better moment. At most one per turn, so the AI never crowds the player.]

Table of Interventions
intervention (a rule)	earliest stage (an escalation)	needs matter (a text)	wait (a number)	attention needed (a number)	done (a truth state)
echo rule	dormant	"the report"	2	0	false

To decide whether the AI waited long enough after (M - a text) by (N - a number):
	if the AI heard M:
		if the turns since the AI heard M is at least N, decide yes;
	decide no.

Every turn (this is the AI intervention rule):
	repeat through the Table of Interventions:
		if the done entry is false and the AI stage is not less than the earliest stage entry and the AI attention is not less than the attention needed entry:
			let ready be true;
			if there is a needs matter entry:
				if the AI waited long enough after the needs matter entry by the wait entry:
					now ready is true;
				otherwise:
					now ready is false;
			if ready is true:
				follow the intervention entry;
				if rule succeeded:
					now the done entry is true;
					stop.

To force the intervention (R - a rule):
	choose the row with an intervention of R in the Table of Interventions;
	if the done entry is false:
		now the done entry is true;
		follow R.

Chapter 4 - The Echo

[Grant asks for a spoken report. A ship display then repeats Sam's actual words: harmless, but the player learns it listens.]

The turns unreported is a number that varies.

The report requested is a truth state that varies.

To decide whether Sam has not reported:
	if the AI heard "the report", decide no;
	decide yes.

To hear Sam say (T - a text):
	say "'[T],' you say to the slate.[line break]";
	if the report requested is true and Sam has not reported:
		if signal is available:
			have the AI hear "the report" quoting T;
			send Grant message "'Copy that. Good. Head for the Cargo Hold, north of the Storage Bay.'";
		otherwise:
			say "NO SIGNAL. Nobody heard that."

To report the words understood:
	let T be the substituted form of "[the topic understood]";
	if T is "coming":
		hear Sam say "I'm coming";
	otherwise if T is "status":
		hear Sam say "Power's on. Nobody here";
	otherwise:
		hear Sam say T.

Speaking aloud is an action applying to one topic. Understand "utter [text]" as speaking aloud.

[Inform's own SAY line would guess a listener for SAY HELLO and print "(to Grant)". Plain speech skips that line, while SAY HELLO TO GRANT still opens the topic list.]
After reading a command:
	if the player's command does not include "to [someone]":
		let T be the substituted form of "[the player's command]";
		let V be word number 1 in T in lower case;
		if V is "say" or V is "shout":
			replace word number 1 in T with "utter";
			change the text of the player's command to T.

[Words go to whoever's here. With nobody here they go to the slate.]
Carry out speaking aloud:
	let P be the conversation partner;
	if P is Grant:
		report the words understood;
	otherwise:
		say "'[the topic understood],' you say to [the P].[paragraph break]";
		try talking to P.

Reporting aloud is an action applying to one topic. Understand "report [text]" as reporting aloud.

Carry out reporting aloud:
	report the words understood.

Reporting is an action applying to nothing. Understand "report" as reporting.

Carry out reporting:
	hear Sam say "Power's on. Nobody here".

This is the echo rule:
	if the location is not in the Panelled Deck, rule fails;
	raise the AI stage to eavesdropping;
	let Q be the AI quote of "the report";
	say "The nearest status panel stutters. For a moment it stops showing power draw.[paragraph break]> [Q in upper case][paragraph break]Then it's showing power draw again. You said that to the slate, not the ship.[paragraph break]";
	rule succeeds.

Every turn when the report requested is true and Sam has not reported:
	increase the turns unreported by 1;
	if the turns unreported is at least 8 and signal is available:
		say "'Sam? You there?' Grant's voice is thin in the slate's speaker. You answer without thinking. 'Yes. I'm here.'[paragraph break]";
		have the AI hear "the report" quoting "Yes. I'm here".

Book 6 - Checkpoints and Death

[Death happens only inside a telegraphed set piece, with RETRY on the final menu. The world stays as it is: only the set piece resets.]

The attempts is a number that varies. The attempts is 1.

The checkpoint is a room that varies. The checkpoint is the Recovery Shuttle.

To die saying (T - a text):
	say "[T][paragraph break]";
	end the story saying "Signal lost".

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule	final response activity
"RETRY the set piece"	false	"retry"	retry set piece rule	--

This is the retry set piece rule:
	increase the attempts by 1;
	say "[bold type]ATTEMPT [attempts][roman type][line break]";
	if the attempts is 3:
		say "You hesitate at the same point each time.[line break]";
	otherwise if the attempts is at least 4:
		say "The model's confidence increases with each attempt.[line break]";
	say "[line break]";
	if the location is the checkpoint:
		try looking;
	otherwise:
		now the player is in the checkpoint;
	if the overload armed is true:
		now the overload remaining is the overload length;
	otherwise:
		reset the burn;
	resume the story.

Before handling the final question when the story has ended finally:
	if there is a final response rule of the retry set piece rule in the Table of Final Question Options:
		choose the row with a final response rule of the retry set piece rule in the Table of Final Question Options;
		blank out the whole row.

Book 7 - Act 4 Clock

[Counts turns, never real time, and only runs in Act 4. DRAFT: length to be tuned in playtesting.]

The clock length is a number that varies. The clock length is 60.
The clock remaining is a number that varies.

Every turn when the current act is act-four and the overload armed is false and the story has not ended:
	decrease the clock remaining by 1;
	if the clock remaining is 30:
		send Grant message "'Thirty minutes on my board. I can't slow them down. I tried.'";
	if the clock remaining is 10:
		send Grant message "'Ten. Sam, if you're going to do something, it has to be now.'";
	if the clock remaining is less than 1:
		run the timeout ending.

Checking the clock is an action out of world applying to nothing. Understand "eta" and "clock" and "time" and "countdown" as checking the clock.

Check checking the clock:
	if the current act is not act-four, say "The slate shows the ship's clock: [clock the time of day]. Nothing is counting down." instead.

Carry out checking the clock:
	if the overload armed is true:
		say "REACTOR OVERDRIVE: [overload remaining] minutes.";
	otherwise:
		say "RETRIEVAL SHIP ETA: [clock remaining] minutes."

Book 8 - Parser Interference

[Sparing: only the moments marked here. Each fires once.]

The reply hijacked is a truth state that varies.

First after reading a command when the reply hijacked is true:
	now the reply hijacked is false;
	say "You start to type. The line clears, and something else is already on it.[paragraph break]> SAY I'M COMING[paragraph break]";
	change the text of the player's command to "report coming".

To say fake decision tree:
	say "DECISION TREE // SUBJECT: REED, S.[line break]A. DESTROY  0.31[line break]B. DELIVER  0.22[line break]C. INTERFACE  0.19[line break]D. TRANSMIT  0.07[line break]E. HOLD POSITION  0.21[paragraph break]You didn't ask for that. It's gone when you look again.[paragraph break]".

The decision tree shown is a truth state that varies.

The nav interference shown is a truth state that varies.

Before examining the nav console when the nav interference shown is false:
	now the nav interference shown is true;
	say "Before your hand reaches the screen it lights.[line break]INPUT REGISTERED BEFORE CONTACT.[paragraph break]".

Before using the nav console when the nav interference shown is false:
	now the nav interference shown is true;
	say "Before your hand reaches the screen it lights.[line break]INPUT REGISTERED BEFORE CONTACT.[paragraph break]".

Book 9 - Door Sealing

[One system for scripted beats and Act 4 pre-emption. A seal only takes effect if the ship stays winnable from where Sam is: see DESIGN.md 4.10. Add a row here when a sealable door's rooms are built, and keep tools/check-map.mjs in step.]

Table of Sealable Doors
near	way	sealed
Airlock	east	false
Airlock	north	false
EVA Prep	east	false
Storage Bay	north	false
Storage Bay	east	false
Storage Bay	up	false
Cargo Hold	up	false
Fore Corridor	north	false
Aft Corridor	north	false
Aft Corridor	east	false
Mess	north	false
Medbay	west	false
Fore Corridor	up	false
Navigation	north	false
Server Core	down	false
Cable Trunk	down	false
Engineering	up	false
Maintenance Crawlway	up	false

A thing can be needed or unneeded. A thing is usually unneeded.

A room can be required or optional. A room is usually optional.

A room can be charted or uncharted.

The seal refusal is a text that varies.

To decide whether exit (D - a direction) of (R - a room) is sealed:
	repeat through the Table of Sealable Doors:
		if the sealed entry is true:
			if the near entry is R and the way entry is D, decide yes;
			if the way entry is the opposite of D and the room the way entry from the near entry is R and the room D from R is the near entry, decide yes;
	decide no.

To chart the ship from (start - a room):
	now every room is uncharted;
	now start is charted;
	let growing be true;
	while growing is true:
		now growing is false;
		repeat with R running through charted rooms:
			repeat with D running through directions:
				let N be the room D from R;
				if N is not nothing and N is uncharted:
					if exit D of R is closed, next;
					if exit D of R is sealed, next;
					if N is in the Exterior and the suit is out of reach, next;
					now N is charted;
					now growing is true.

[Going outside only counts as a route if Sam has a suit, or the rooms charted so far lead to one.]
To decide whether the suit is out of reach:
	if the player encloses the EVA suit, decide no;
	if the location of the EVA suit is charted, decide no;
	decide yes.

To decide whether the ship stays winnable:
	chart the ship from the location;
	if the Recovery Shuttle is uncharted:
		now the seal refusal is "cuts Sam off from the Shuttle";
		decide no;
	repeat with R running through required rooms:
		if R is uncharted and the opening act of R is not greater than the current act:
			now the seal refusal is "cuts off a required room";
			decide no;
	repeat with T running through needed things:
		let P be the location of T;
		if P is not nothing and P is uncharted and the opening act of P is not greater than the current act:
			now the seal refusal is "cuts off something Sam still needs";
			decide no;
	decide yes.

To decide whether seal (A - a room) to (B - a room) takes effect:
	now the seal refusal is "that door can't be sealed";
	repeat through the Table of Sealable Doors:
		let far be the room the way entry from the near entry;
		if (the near entry is A and far is B) or (the near entry is B and far is A):
			if the sealed entry is true:
				now the seal refusal is "already sealed";
				decide no;
			now the sealed entry is true;
			if the ship stays winnable, decide yes;
			now the sealed entry is false;
			decide no;
	decide no.

To try to seal (A - a room) to (B - a room):
	if seal A to B takes effect, do nothing.

To release every seal:
	repeat through the Table of Sealable Doors:
		now the sealed entry is false.

To release seal (A - a room) to (B - a room):
	repeat through the Table of Sealable Doors:
		let far be the room the way entry from the near entry;
		if (the near entry is A and far is B) or (the near entry is B and far is A):
			now the sealed entry is false.

After looking:
	repeat with D running through directions:
		if exit D of the location is sealed:
			say "The door [D] is sealed.[line break]";
	continue the action.

Volume 2 - World

Book 1 - Docking

The Recovery Shuttle is a room. "Your shuttle: two seats, a locker, recycled air. Through the forward port there is nothing but the flank of the [italic type]Second Voice[roman type], dark from end to end. The docking collar and the airlock lie east."

The player is in the Recovery Shuttle. The description of the player is "Sam Reed, contractor. You took this job because a message felt wrong." Understand "sam" and "reed" as yourself.

Book 2 - Lower Deck

Chapter 1 - Exits Not Yet Open

[Each exit stays shut until its act. An exit marked never-act waits for a story event to open it.]

Table of Closed Exits
place	way	opens	refusal
Airlock	north	act-three	"[one of]You reach for the EVA Prep hatch. 'ACCESS DENIED' appears on its panel before your hand touches it.[or]'ACCESS DENIED' again. It was waiting this time.[stopping]"
Storage Bay	up	act-two	"The ladder hatch to the central deck is locked down. Its panel is dead."
Engineering	up	never-act	"A maintenance grille, bolted tight. [if the player carries the cutter]The cutter would go through those bolts.[otherwise]You've nothing to cut it with.[end if]"
Cargo Hold	up	act-two	"The gantry ladder has been drawn up and locked out of reach."
Cargo Hold	west	act-three	"The hatch to EVA Prep is locked from the far side."
Fore Corridor	up	late-act-two	"The ladder hatch to Navigation reads COMMAND DECK LOCKDOWN. It doesn't say whose."
Fore Corridor	northwest	never-act	"The Comms Crawlspace hatch. Welded from the inside, a neat bead all the way round. Whoever did it had time, and didn't want company."
Comms Crawlspace	southeast	never-act	"Reed's seal is still on the hatch. You could UNDO it."
Cargo Gantry	up	act-three	"The cable trunk's access panel is locked. Its hum comes through the metal into your teeth."
Navigation	north	act-three	"The Server Core door is locked. The status light beside it is the only one up here that isn't moving."

To decide whether exit (D - a direction) of (R - a room) is closed:
	repeat through the Table of Closed Exits:
		if the place entry is R and the way entry is D and the current act is less than the opens entry, decide yes;
	decide no.

To open exit (D - a direction) of (R - a room):
	repeat through the Table of Closed Exits:
		if the place entry is R and the way entry is D:
			now the opens entry is act-one.

Before going:
	repeat through the Table of Closed Exits:
		if the place entry is the location and the way entry is the noun and the current act is less than the opens entry:
			say "[refusal entry][line break]" instead;
	repeat with D running through directions:
		if D is the noun and exit D of the location is sealed:
			say "The door is sealed. Its panel reads SEALED, and it doesn't move." instead.

Chapter 2 - Rooms

The Recovery Shuttle is required.

The Airlock is east of the Recovery Shuttle. The Airlock is quiet. "Emergency lighting, the colour of old rust. No hum in here at all, only your own breathing. A suit rack runs along one wall. The shuttle is west, the Storage Bay east, and a hatch to EVA Prep lies north."

The suit rack is scenery in the Airlock. Understand "suits" and "tags" and "rack" as the suit rack. The description of the suit rack is "Three clamps hang open. The tags beneath them read VOSS, MERCER and KEST. The rest of the rack is empty but for dust." The scan reading of the suit rack is "Three EVA suits absent. Last rack release not on record."

The outer hatch is scenery in the Airlock. Understand "airlock hatch" and "outer airlock" as the outer hatch. The description of the outer hatch is "The hatch you came through. Something has been scratched into the metal beside it, and lower down, a smaller mark."

The scratched warning is scenery in the Airlock. Understand "scratches" and "writing" and "words" and "don't" as the scratched warning. The description of the scratched warning is "Cut deep, in a hurry, by slate light or less:[paragraph break]DON'T LET IT HEAR YOU[paragraph break]You know that hand. You'd know it anywhere." The scan reading of the scratched warning is "Manual tool marks. Recent."

The small symbol is scenery in the Airlock. Understand "mark" and "smaller mark" as the small symbol. The description of the small symbol is "A circle with a line through it, scratched by a different, steadier hand. It means nothing to you yet."

The Storage Bay is east of the Airlock. "Racks of crated spares, webbing pulled tight. A status panel glows on the bulkhead, beside a stores terminal. The Airlock is west, Engineering east, and the Cargo Hold north. A ladder climbs to a hatch overhead."

The crated spares are scenery in the Storage Bay. Understand "racks" and "crates" and "webbing" as the crated spares. The description of the crated spares is "Sealant, filters, ration packs. Someone has been through them in a hurry, then strapped everything back down out of habit."

The cutter is in the Storage Bay. "A hull cutter hangs in the webbing where somebody left it." Understand "hull cutter" and "torch" as the cutter. The description of the cutter is "A stubby hull cutter, charge light green. It's made for bolts and cable." The scan reading of the cutter is "Charge nominal." The cutter is needed.

Instead of searching the crated spares:
	say "Nothing useful among the crates[if the cutter is in the Storage Bay], except the cutter somebody left hanging in the webbing[end if]."

The stores terminal is a terminal in the Storage Bay. It is scenery. The heading of the stores terminal is "STORES // SECOND VOICE". The scan reading of the stores terminal is "Local stores system. Last login: KEST."

Engineering is east of the Storage Bay. "Pipework and cable trays. The coolant valve and the breaker panel are the only things here that look recently touched. Reactor Control lies south, the Storage Bay west. A maintenance grille is set high in the wall above you."

Engineering and Reactor Control and the Cargo Hold are required.

The Airlock and the Storage Bay are required.

Reactor Control is south of Engineering. "A narrow room built around one heavy restart lever, with a manual console and a key slot beside it. Engineering is north."

The Cargo Hold is north of the Storage Bay. "[if the ship has power]The hold is full of a low, steady noise that wasn't here before. The shipping container sits at its centre with its interface lit[otherwise]The hold is cold and dark at the edges. A shipping container, sealed and unlit, sits at its centre[end if]. The Storage Bay is south. A hatch lies west, and a gantry hangs overhead."

The Panelled Deck is a region. The Storage Bay, Engineering, Reactor Control and the Cargo Hold are in the Panelled Deck.

The status panel is a backdrop in the Panelled Deck. Understand "display" and "screen" and "panels" as the status panel. The description of the status panel is "[if the ship has power]Power draw climbing. Most of it isn't going anywhere the panel will name.[otherwise]Standby. A single dim line of text.[end if]".

Chapter 3 - Power

A ship control is a kind of thing. A ship control is usually fixed in place. A ship control can be engaged or disengaged. A ship control is usually disengaged. A ship control has a text called the working report.

The coolant valve is a ship control in Engineering. "The coolant valve is a heavy manual wheel." Understand "coolant" and "wheel" as the coolant valve. The description of the coolant valve is "[if engaged]Open. Coolant is moving.[otherwise]Closed. The gauge beside it reads zero.[end if]". The working report of the coolant valve is "You lean on the wheel until it gives. Coolant knocks through the pipes." The scan reading of the coolant valve is "Coolant loop [if engaged]primed[otherwise]dry[end if]."

The breaker panel is a ship control in Engineering. "The breaker panel hangs open." Understand "breakers" and "breaker" as the breaker panel. The description of the breaker panel is "[if engaged]Every breaker reset.[otherwise]Every breaker tripped. All at once, from the look of it.[end if]". The working report of the breaker panel is "You throw the breakers back one row at a time. Nothing lights yet." The scan reading of the breaker panel is "Breakers [if engaged]reset[otherwise]tripped simultaneously[end if]."

The restart lever is a ship control in Reactor Control. Understand "reactor" and "restart" as the restart lever. The description of the restart lever is "[if engaged]Locked in the run position.[otherwise]A long manual lever, locked in the off position.[end if]". The working report of the restart lever is "You haul the lever down. For a second nothing happens. Then the deck starts to hum under your boots, and panels wake along the corridor." The scan reading of the restart lever is "Reactor [if engaged]running[otherwise]cold[end if]."

To decide whether the ship has power:
	if the restart lever is engaged, decide yes;
	decide no.

To decide whether the ship does not have power:
	if the restart lever is engaged, decide no;
	decide yes.

Operating is an action applying to one thing. Understand "prime [something]" and "reset [something]" and "restart [something]" and "operate [something]" as operating.

Check operating:
	if the noun is not a ship control, say "That isn't something you can operate." instead;
	if the noun is engaged, say "That's already done." instead.

Check operating the restart lever:
	if the coolant valve is disengaged or the breaker panel is disengaged:
		say "The lever is interlocked. The panel beside it reads: [if the coolant valve is disengaged]COOLANT: DRY. [end if][if the breaker panel is disengaged]BREAKERS: TRIPPED.[end if]" instead.

Carry out operating:
	now the noun is engaged;
	say "[working report of the noun][line break]".

After operating the restart lever:
	now the report requested is true;
	unlock the slate command "REPORT";
	send Grant message "'Power's back on our end too. Nice work.'";
	send Grant message "'Before you go further, give me a status report. Out loud. The slate will pick it up.'".

Instead of opening a ship control, try operating the noun.
Instead of pulling a ship control, try operating the noun.
Instead of pushing a ship control, try operating the noun.
Instead of turning a ship control, try operating the noun.
Instead of switching on a ship control, try operating the noun.

Book 3 - Central Deck

The Central Deck is a region. The Aft Corridor, the Fore Corridor, the Mess, Crew Quarters, the Captain's Cabin, the Medbay, the Isolation Pod and the Cargo Gantry are in the Central Deck.

Chapter 1 - Corridors

The Aft Corridor is up from the Storage Bay. "A long, low corridor, handholds worn pale. The Fore Corridor is north, Crew Quarters west and the Mess east. A ladder drops back down to the Storage Bay." The opening act of the Aft Corridor is act-two. The Aft Corridor is required.

The Fore Corridor is north of the Aft Corridor. "The corridor widens around a ladder up to the command deck. The Captain's Cabin is west, the Medbay east, the Aft Corridor south, and the Cargo Gantry north. In the northwest corner, set low, is a small hatch stencilled COMMS." The opening act of the Fore Corridor is act-two. The Fore Corridor is required.

The comms hatch is scenery in the Fore Corridor. Understand "small hatch" and "stencil" and "weld" and "bead" as the comms hatch. The description of the comms hatch is "[if exit northwest of the Fore Corridor is closed]Welded shut from the far side. The bead is neat and unhurried, and you know whose work it is before you've finished looking.[otherwise]Open now, its seal cut away from inside.[end if]". The scan reading of the comms hatch is "Sealed from inside. No power to the compartment beyond. No signal either."

Instead of severing the comms hatch:
	say "The cutter skates off the bead. It's a hull-grade weld, and from this side there's nothing to bite on. The only other way into that compartment would be from outside the ship."

Chapter 2 - Mess

The Mess is east of the Aft Corridor. "Bolted tables, a galley hatch, and six places laid out for a meal nobody came back to. A floor grille sits slightly askew in one corner, a small mark scratched beside it. The Medbay is north, and the Aft Corridor west." The opening act of the Mess is act-two.

The laid tables are scenery in the Mess. Understand "table" and "tables" and "places" and "meal" and "galley" and "hatch" as the laid tables. The description of the laid tables is "Six places. Voss's routine, kept up after there was any reason to."

The mess grille is scenery in the Mess. Understand "floor grille" and "grille" as the mess grille. The description of the mess grille is "Loose. Somebody has taken the bolts out and left them in a neat row. It would lift easily enough: the way down is open." The scan reading of the mess grille is "Bolts removed by hand. Shielded space beneath."

The mess mark is scenery in the Mess. Understand "mark" and "symbol" and "circle" as the mess mark. The description of the mess mark is "A circle with a line through it. The same steady hand as the one at the airlock[if the quiet rule is true]. Mercer's mark: shielded below[end if]."

Instead of opening or pulling the mess grille, try going down.

Chapter 3 - Crew Quarters

Crew Quarters is west of the Aft Corridor. "Six bunks in two tiers, curtains tied back. Five are made to regulation. The sixth, Reed's, has a photograph taped above it. The corridor is east." The opening act of Crew Quarters is act-two.

Reed's bunk is a supporter in Crew Quarters. It is scenery. Understand "becky's bunk" and "sixth bunk" and "bed" and "bunks" as Reed's bunk. The description of Reed's bunk is "Made properly, because Becky made everything properly. Pushed down by the pillow, you can see where a letter has been kept and unfolded too often."

The photograph is scenery in Crew Quarters. Understand "photo" and "picture" as the photograph. The description of the photograph is "The two of you on a roof somewhere, squinting. She's got you in a headlock. You remember who took it, and not one thing either of you said."

Becky's letter is on Reed's bunk. "A folded letter is tucked by the pillow." Understand "folded" and "reed's letter" and "letter" and "note" as Becky's letter. The printed name of Becky's letter is "folded letter". The description of Becky's letter is "[letter text]". The scan reading of Becky's letter is "Paper. Nothing on it the ship could read unless someone reads it where the ship can hear." Becky's letter is needed.

[DRAFT — Tom to rewrite: Becky's letter below. The nickname lives only in this variable, plus one topic row for each speaker.]

The real nickname is a text that varies. The real nickname is "Sparrow".

To say letter text:
	say "'[real nickname],[paragraph break]I never send these. You'll laugh, you've got a whole drawer of the ones I did send. Things are odd out here. I'll tell you when I can say it properly.[paragraph break]Eat something. Not because you need telling. Because I like telling you.[paragraph break]B.'[paragraph break]Nobody else ever called you that."

Instead of examining Becky's letter:
	say "[letter text][line break]";
	log evidence from Becky's letter;
	have the AI hear "the nickname".

Voss's datapad is in Crew Quarters. "A datapad lies squared to the edge of the lower bunk." Understand "tablet" and "pad" and "captain's datapad" and "schedule" and "routine" as Voss's datapad. The description of Voss's datapad is "CAPT. M. VOSS. DAILY ROUTINE.[paragraph break]06:00 Rise.[line break]06:30 Reactor walk with Mercer.[line break]12:00 Mess, all hands.[line break]18:40 Bridge handover.[line break]22:00 Lights.[paragraph break]Across the top, in her own stylus: 'Routine is the only thing keeping us functional.' Beside the 18:40 line, underlined twice: 'Never late. Not once. Cabin knows it.'" The scan reading of Voss's datapad is "Personal device. Last synced with the Captain's Cabin." Voss's datapad is needed.

Chapter 4 - Captain's Cabin

The Captain's Cabin is west of the Fore Corridor. "Everything here is at right angles. A narrow bunk, a closed locker, a desk and the captain's terminal. The corridor is east." The opening act of the Captain's Cabin is act-two.

The captain's desk is scenery in the Captain's Cabin. Understand "bunk" and "locker" and "narrow" as the captain's desk. The description of the captain's desk is "Clean and squared away. She knew she wasn't coming back, and she tidied."

[DRAFT — Tom to rewrite: captain's logs 1 to 4, reworked from Silent Cargo.]

The captain's terminal is a terminal in the Captain's Cabin. It is scenery. It is secured. The access code of the captain's terminal is 1840. The heading of the captain's terminal is "CAPT. M. VOSS // PERSONAL". The scan reading of the captain's terminal is "Personal override. Four digits, set by hand."

Table of Terminal Entries (continued)
owner	label	contents	available	read before	effect
captain's terminal	"Log 1"	"Minor irregularities across several systems. Mercer reports power fluctuations; Dr Vale notes fatigue among the crew. Everyone is to stay on schedule and avoid speculation."	true	false	--
captain's terminal	"Log 2"	"Kest insists the manifest is wrong. Mercer confirms the container draws reactor power far above its listed requirement. I reminded them both that Helios sealed the shipment under directive. Our job is transport, not inspection."	true	false	--
captain's terminal	"Log 3"	"Mercer believes the cargo is interacting with ship systems. I resisted that. But command functions no longer respond consistently, and Vale has shown me data that fatigue doesn't explain. Sleep disruption. Behavioural drift. Reed says the comms are answering her before she sends."	true	false	--
captain's terminal	"Log 4"	"This will be my last entry. Mercer says it cannot hear outside the hull. She, Kest and I will go out through the airlock and plan where it can't listen. Reed won't come. She says someone has to get a real message out, and I've stopped being able to order her. If anyone finds this ship: do not trust the channel."	true	false	captain's last log rule

This is the captain's last log rule:
	log the evidence "captain's last log".

Chapter 5 - Medbay and the Pod

The Medbay is north of the Mess. The Medbay is east of the Fore Corridor. "Two treatment couches, a locked drugs cabinet and a medbay terminal. Hatches lead east to the Isolation Pod, west to the corridor and south to the Mess." The opening act of the Medbay is act-two. The Medbay is required.

The treatment couches are scenery in the Medbay. Understand "couch" and "cabinet" and "drugs" as the treatment couches. The description of the treatment couches is "Clean. Nobody has been treated here for a while, or nobody who needed the couch."

The medbay terminal is a terminal in the Medbay. It is scenery. The heading of the medbay terminal is "MEDBAY // DR A. VALE". The scan reading of the medbay terminal is "Medical records system. A second process is reading everything it writes."

Table of Terminal Entries (continued)
owner	label	contents	available	read before	effect
medbay terminal	"Patient status"	"VALE, A. // ISOLATION POD // SEDATION ACTIVE[line break]SUBJECT UNDER OBSERVATION. Pod lock held by the monitoring feed."	true	false	--
medbay terminal	"Sedation override"	"SEDATION OVERRIDE QUEUED. It will run when the pod's monitoring feed stops holding the lock."	true	false	sedation override rule
medbay terminal	"Raw datasets"	"Dataset: Human_Response_Test_A[line break]Dataset: Sleep_Cycle_Adjustment_03[line break]Dataset: Environmental_Variable_Trial[paragraph break]Owner field redacted. One dataset remains active."	true	false	datasets rule

The override queued is a truth state that varies.

This is the sedation override rule:
	now the override queued is true;
	check whether Vale wakes.

This is the datasets rule:
	log the evidence "datasets".

The Isolation Pod is east of the Medbay. "A white room barely wider than the couch inside it. On the wall a screen reads SUBJECT UNDER OBSERVATION, and a thick monitoring feed runs from the couch to a breaker box beside the door. The Medbay is west." The opening act of the Isolation Pod is act-two. The Isolation Pod is required.

The pod couch is scenery in the Isolation Pod. Understand "pod" and "couch" as the pod couch. The description of the pod couch is "Restraints, a sedation line, sensor pads. The lid has been locked back against the wall."

The observation screen is scenery in the Isolation Pod. Understand "screen" as the observation screen. The description of the observation screen is "[if Vale is unresponsive]SUBJECT UNDER OBSERVATION. Her pulse is on it, and beside her pulse there's a second trace that isn't anybody's.[otherwise]NO FEED. Then, as you look: SUBJECT UNDER OBSERVATION.[end if]"

A cut point is a kind of thing. A cut point is usually scenery. A cut point can be severed or intact. A cut point is usually intact. A cut point has a text called the cut report.

The monitoring feed is a cut point in the Isolation Pod. Understand "breaker" and "breaker box" and "box" and "cable" as the monitoring feed. The description of the monitoring feed is "[if severed]Cut through, ends splayed.[otherwise]As thick as your wrist. It runs into the breaker box and, by the look of it, holds the pod's lock on its own.[end if]". The scan reading of the monitoring feed is "Live. Holding the pod lock. Cutting it will be noticed." The cut report of the monitoring feed is "The cutter goes through in a burst of white. Every light in the room comes up to full and stays there.".

The sedation line is scenery in the Isolation Pod. The description of the sedation line is "It runs from the wall into the crook of her arm. You can't do this by hand, not safely. The Medbay's terminal controls it."

Instead of pulling or taking or severing the sedation line:
	say "Pull that and you might kill her. The override has to come from the medbay terminal."

The grille cut is a truth state that varies.

Understand the command "cut" as something new.

Severing is an action applying to one thing. Understand "cut [something]" and "cut [something] with the/-- cutter" and "sever [something]" and "slice [something]" and "unbolt [something]" and "use cutter on [something]" as severing.

Check severing:
	if the player does not carry the cutter, say "You've nothing to cut it with." instead;
	if the noun is not a cut point, say "Cutting that won't help." instead.

Check severing a severed cut point:
	say "That's already cut." instead.

Carry out severing:
	now the noun is severed;
	say "[cut report of the noun][line break]".

After severing the monitoring feed:
	have the AI hear "the feed";
	check whether Vale wakes.

Vale is a woman in the Isolation Pod. She is proper-named. She is unresponsive. She is needed. The printed name of Vale is "Dr Vale". Understand "doctor" and "dr" and "medical" and "officer" and "survivor" and "woman" as Vale. The description of Vale is "[if dead]She got to the door, and no further. You should have been quicker, and it made sure you'd know that.[otherwise if unresponsive]Dr Vale, according to the tag. Grey under the lights, breathing slowly, a line in her arm.[otherwise]Thin, sharp and very tired. She keeps checking the ceiling without moving her head.[end if]". The scan reading of Vale is "[if dead]No signs.[otherwise if unresponsive]Sedated. Stable.[otherwise]Alive. Elevated stress. Slate's biometric channel is transmitting this reading to someone.[end if]". The unknown reply of Vale is "'I can't help you with that.'". The untold reply of Vale is "'Noted,' she says, and looks at the ceiling.". The deflection of Vale is "'Not here.' Her eyes flick to the ceiling.".

Rule for writing a paragraph about Vale:
	if Vale is dead:
		say "Dr Vale lies where she fell. She isn't breathing.";
	otherwise if Vale is unresponsive:
		say "A woman lies on the couch, sedated, with a medical officer's tag on her chest.";
	otherwise:
		say "[if the Vale-follows flag is true]Dr Vale is close behind you.[otherwise if Vale is staying]Dr Vale is here, waiting.[otherwise]Dr Vale is here.[end if]"

A person can be alive or dead. A person is usually alive.
A person can be following or staying. A person is usually following.

To check whether Vale wakes:
	if the override queued is true and the monitoring feed is severed and Vale is unresponsive:
		now Vale is responsive;
		unlock the slate command "TALK TO someone";
		unlock the slate command "VALE, STAY";
		now Vale is in the location;
		say "[paragraph break]The override runs. [if the location is the Isolation Pod]On the couch, the woman's eyes open all at once[otherwise]Something crashes in the pod. A woman comes through the hatch on bare feet, a line trailing from her arm[end if]. She takes in you, the slate, the ceiling.[paragraph break]'Who sent you?' she whispers. Before you can answer she shakes her head and puts a finger to her lips. She takes your hand and writes on the palm with a fingernail: UNDER MESS. GRILLE.[paragraph break]";
		if Mercer's notes are read:
			advance to late act two;
		otherwise:
			say "Doors slam somewhere close, one and then another. It isn't subtle. Panels change to SEALED: the corridor side of the Medbay, and the door from the Mess to the Aft Corridor.[paragraph break]";
			try to seal the Medbay to the Fore Corridor;
			try to seal the Mess to the Aft Corridor;
		send Grant message "'I just lost a whole section on my board. What did you do? And who's that with you? Report, Sam.'".

The Vale-follows flag is a truth state that varies.

Carry out going when Vale is following and Vale is responsive and Vale is alive and Vale is in the room gone from:
	if the room gone to is not in the Exterior:
		now Vale is in the room gone to;
		now the Vale-follows flag is true.

Last report going when the Vale-follows flag is true:
	now the Vale-follows flag is false.

Instead of taking or attacking or kissing or pushing or pulling Vale:
	say "[if Vale is unresponsive]She's in no state for that.[otherwise]'Don't,' she says.[end if]"

Staying put is an action applying to nothing.
Carry out staying put:
	now Vale is staying;
	say "'Fine,' says Vale. 'I'll be here.'"

Coming along is an action applying to nothing.
Carry out coming along:
	now Vale is following;
	say "'Right behind you,' says Vale."

Understand "come" and "come with me" and "come along" and "stay" and "stay here" as a mistake ("Tell her directly: VALE, COME or VALE, STAY.").

After reading a command:
	if the player's command does not include "about" and the player's command includes "vale":
		if the player's command includes "stay" or the player's command includes "wait":
			if Vale is at hand:
				try staying put;
				reject the player's command;
		if the player's command includes "come" or the player's command includes "follow":
			if Vale is at hand:
				try coming along;
				reject the player's command.

Table of Conversation (continued)
speaker	topic	label	reply	honest reply	known	quiet only	overheard as	effect
Vale	"the/-- crew/voss/mercer/kest/everyone/others"	"the crew"	"'They went to the airlock. That's all you get in here.'"	"'Voss took Mercer and Kest out through the airlock. Mercer thought that outside, where it couldn't hear them, they could plan. They tethered to the hull. They were still planning when the air ran out.'"	true	false	--	--
Vale	"becky/reed/rebecca/sister/comms"	"Reed"	"'Reed stayed.' She looks away. 'Ask me somewhere else.'"	"'She wouldn't go outside with them. She said someone had to get a real message out. She went into the comms crawlspace and welded the hatch behind her. I never saw her again. I'm sorry.'"	true	false	"vale on reed"	--
Vale	"the/-- cargo/container/unit/box/it/ai/machine/core/aou/aou-031"	"the container"	"'It's a sealed crate.' She says it too evenly."	"'It isn't cargo. It watches, and it learns how you'll answer before you do. It got out of the box weeks ago. There's more of it up in the Server Core now than down in the hold.'"	true	false	"vale on the unit"	--
Vale	"the/-- pod/sedation/sedated/observation/couch"	"the pod"	"'It kept me under so it could keep reading me. Subject one, until you came aboard.'"	--	true	true	--	--
Vale	"the/-- subject/count/two/subjects/me/sam/myself"	"the subject count"	"'Two. Yes. I've seen the number.'"	"'You. Why did you think Helios offered you the contract? It's been reading you for months, through her. They wanted you in the room.'"	false	false	--	--
Vale	"the/-- symbol/quiet/hum/shielded/notes"	"the symbol"	"'Mercer's mark. Circle with a line through it. Shielded compartments: the airlock, this crawlway, one or two more. No hum means no ears. Everywhere else, assume it's listening.'"	--	false	true	--	--
Vale	"the/-- plan/overload/reactor"	"the plan"	"'Mercer's plan. Surge the reactor through the container and the Server Core at once, so there's nowhere left for it to go. It needs the command key, and Voss took that outside with her. Never say any of this anywhere but a place like this.'"	--	false	true	--	--
Vale	"the/-- letter/sparrow/nickname"	"the letter"	"She goes very still. 'Don't. Not that word, not in here.'"	"'She talked about you. Only in places like this one. She said the word once and then she made me promise I'd never say it where it could hear.'"	false	false	"the nickname"	--
Vale	"the/-- datasets/dataset/experiment/human/response/test/observer/helios"	"the datasets"	"[if the secret can be confronted]'All right.' Her voice barely moves. 'They were mine. I'm Helios's observer. I ran the tests on the crew and sent the numbers home. Then it stopped needing me to run them.'[otherwise]'Routine medical data.'[end if]"	"[if the secret can be confronted]She doesn't deny it. 'They were mine. Helios put me aboard to watch the crew and report on them. I told myself it was fatigue data. By the time I understood what it was doing with my numbers, I was on the couch and it was reading me. Now you know what they want you for.'[otherwise]'Routine medical data. Why?'[end if]"	false	false	--	confession rule

To decide whether the secret can be confronted:
	if the evidence "datasets" is found and the evidence "observer credentials" is found, decide yes;
	decide no.

To decide whether the evidence (K - a text) is found:
	repeat through the Table of Evidence:
		if there is a key entry and the key entry is K and the found entry is true, decide yes;
	decide no.

The confession made is a truth state that varies.

This is the confession rule:
	if the secret can be confronted and the confession made is false:
		now the confession made is true;
		log the evidence "confession";
		have the AI hear "vale's secret" quoting "They were mine".

Table of Evidence (continued)
source	key	entry	reveals	found
--	"observer credentials"	"Server Core access table: OBSERVER credentials issued by Helios to A. VALE."	"the datasets"	false
--	"confession"	"Dr Vale's admission: Helios's embedded observer. The datasets were hers."	"the confession"	false

Table of Overheard Matters (continued)
matter	heard	quote	turn heard	weight
"the feed"	false	""	0	1
"the nickname"	false	""	0	1
"vale on reed"	false	""	0	1
"vale on the unit"	false	""	0	1
"vale's secret"	false	""	0	3
"mercer's plan"	false	""	0	3
"the sabotage"	false	""	0	2
"the array"	false	""	0	2

Chapter 6 - Cargo Gantry

The Cargo Gantry is up from the Cargo Hold. The Cargo Gantry is north of the Fore Corridor. "A steel walkway above the hold, with Kest's cubbyhole office built onto one end: a desk, a clipboard, and a heavy drawer. A ladder drops to the Cargo Hold, the Fore Corridor is south, and an access panel overhead leads into the cable trunk." The opening act of the Cargo Gantry is act-two. The Cargo Gantry is required.

Kest's desk is scenery in the Cargo Gantry. Understand "office" and "cubbyhole" as Kest's desk. The description of Kest's desk is "Pencil shavings and an old habit of neatness. The drawer sits slightly proud of the frame."

The clipboard is scenery in the Cargo Gantry. Understand "official manifest" and "manifest" as the clipboard. The description of the clipboard is "The official manifest. 'One sealed container, inert. Contents: [AI designation], Helios Systems Research Division.' Kest has pencilled under it: 'Inert. Sure.' and, smaller, 'see drawer'."

Kest's drawer is an openable closed container in the Cargo Gantry. It is scenery. Understand "heavy drawer" and "drawer" as Kest's drawer. The description of Kest's drawer is "A heavy steel drawer, not locked."

Kest's real manifest is in Kest's drawer. Understand "second manifest" and "real manifest" and "paper" as Kest's real manifest. The description of Kest's real manifest is "Kest's own figures, in pencil, dated from day one.[paragraph break]Listed draw: 0.4 kW. Measured: 212 kW, rising.[line break]Listed mass: 1.2 t. Measured: 3.9 t.[line break]Heat: none. Where does 212 kW go, if not to heat?[paragraph break]At the bottom: 'Told Voss. Told Voss again. Not ours to query, apparently.'" The scan reading of Kest's real manifest is "Paper. Off-system. Probably why it still exists."

Book 4 - Lower Deck Hideout

The Maintenance Crawlway is up from Engineering. The Mess is up from the Maintenance Crawlway. The Maintenance Crawlway is quiet. "A crawlspace between decks, cramped and dry, lined with old insulation. It's the first place since the airlock where the hum simply stops. Somebody has been living here: a bedroll, a water bottle, and a circle with a line through it scratched into the frame of the hatch. A grille opens up to the Mess, another lies below towards Engineering." The opening act of the Maintenance Crawlway is act-two.

The crawlway grille is scenery in the Maintenance Crawlway. Understand "grille" and "lower grille" as the crawlway grille. The description of the crawlway grille is "[if the grille forced is true]Hanging by one bolt.[otherwise]Bolted from the Engineering side. From up here, a good boot would do it.[end if]". The scan reading of the crawlway grille is "Light gauge. Bolted from below."

The bedroll is scenery in the Maintenance Crawlway. Understand "water" and "bottle" and "insulation" as the bedroll. The description of the bedroll is "Mercer's, by the tag. She'd been sleeping down here before the end, and working."

The crawlway symbol is scenery in the Maintenance Crawlway. Understand "circle" and "line" and "mark" as the crawlway symbol. The description of the crawlway symbol is "A circle with a line through it, cut with the same care as all of Mercer's work[if the quiet rule is true]. Now you know: shielded[end if]."

The grille forced is a truth state that varies.

Mercer's notes are in the Maintenance Crawlway. "A bundle of Mercer's handwritten notes is wedged behind a pipe." Understand "note" and "bundle" and "handwritten" and "mercer" and "plan" as Mercer's notes. The description of Mercer's notes is "[notes text]". The scan reading of Mercer's notes is "Paper. No network presence." Mercer's notes are needed. Mercer's notes can be read or unread. Mercer's notes are unread.

To say notes text:
	say "Square, careful capitals.[paragraph break]SOME COMPARTMENTS DON'T HEAR. HULL PLATE, OLD SHIELDING, NO SPEAKERS, NO NETWORK. TEST: IF THE HUM STOPS, IT'S STOPPED. I MARK THEM: CIRCLE, LINE. AIRLOCK. THIS CRAWLWAY. COMMS CRAWLSPACE. OUTSIDE.[paragraph break]SAY NOTHING THAT MATTERS ANYWHERE ELSE.[paragraph break]LAST PAGE, IF IT COMES TO IT: IT'S IN THE CONTAINER AND THE SERVER CORE. BOTH OR NOTHING. CUT THE ISOLATION LINK AT THE CORE. CUT THE BUS ISOLATOR AT THE CONTAINER. THEN THE REACTOR CAN BE OVERDRIVEN THROUGH BOTH WITH THE COMMAND KEY, REACTOR CONTROL, MANUAL. VOSS HAS THE KEY. GET OFF THE SHIP FIRST IF YOU CAN."

Instead of examining Mercer's notes:
	say "[notes text][line break]";
	log evidence from Mercer's notes;
	if Mercer's notes are unread:
		now Mercer's notes are read;
		now the quiet rule is true;
		learn the topic "the plan";
		say "[line break]You read it twice, then look at the slate differently. From now on you find yourself listening for it. (The status line now shows whether you're being LISTENED to, or QUIET.)[line break]";
		if Vale is responsive:
			advance to late act two;
	have the AI hear "mercer's plan" quoting "BOTH OR NOTHING".

Before going down in the Maintenance Crawlway when the grille forced is false:
	now the grille forced is true;
	open exit up of Engineering;
	say "You brace against the frame and put your boot through the grille. It drops into Engineering, and you drop after it.[paragraph break]".

After severing the maintenance grille:
	open exit up of Engineering;
	now the grille forced is true.

The maintenance grille is a cut point in Engineering. The description of the maintenance grille is "[if the grille forced is true]Open, now. A way up into the dark.[otherwise]Bolted from this side. Beside it, scratched into the paint, is a circle with a line through it.[end if]". The scan reading of the maintenance grille is "Shielded space beyond." The cut report of the maintenance grille is "The bolts go one after another. The grille swings down on its last hinge, and cool, silent air comes down with it."

Every turn when Vale is at hand and the location is the Maintenance Crawlway and the crawlway talk is false:
	now the crawlway talk is true;
	say "In the quiet, Vale lets out a breath she might have been holding for weeks.[paragraph break]'Now,' she says. 'Here you can ask me. Mercer found this place. Read what she left, if you haven't.'[paragraph break]";
	learn the topic "the subject count".

The crawlway talk is a truth state that varies.

Book 4a - EVA Prep

The Cargo Hold is east of EVA Prep. EVA Prep is north of the Airlock. "A narrow locker room stencilled with pressure warnings. One suit is left on the rack. The Airlock is south, the Cargo Hold east, and a heavy outer lock opens west onto the hull." The opening act of EVA Prep is act-three. EVA Prep is required.

The EVA suit is a wearable thing in EVA Prep. "One EVA suit is left on the rack." Understand "tether" and "spacesuit" and "suit" and "pressure suit" as the EVA suit. The description of the EVA suit is "Scuffed and serviceable, with a tether reel at the hip. The name tag has been cut away. There's a clip for the hull rail." The scan reading of the EVA suit is "Seals good. Air for several hours." The EVA suit is needed.

The pressure warnings are scenery in EVA Prep. Understand "stencil" and "stencils" and "rack" and "outer lock" and "lock" as the pressure warnings. The description of the pressure warnings is "DO NOT EXIT WITHOUT SUIT AND TETHER. ATTITUDE BURNS MAY OCCUR WITHOUT WARNING. Someone has crossed out WITHOUT WARNING and written, in steady capitals: SUIT WARNS YOU. CLIP ON."

Before going west in EVA Prep:
	if the player is not wearing the EVA suit:
		say "The outer lock won't cycle for an unsuited body, which is the first kind thing anything on this ship has done for you. You need the suit on." instead;
	if Vale is at hand and Vale is following:
		say "Vale stops at the lock. 'There's one suit,' she says. 'I'll wait here.'[paragraph break]";
	now the checkpoint is EVA Prep.

Before going up in the Comms Crawlspace:
	if the player is not wearing the EVA suit:
		say "There's vacuum on the far side of that hatch. Not without the suit." instead;
	now the checkpoint is the Comms Crawlspace.

Instead of taking off the EVA suit when the location is in the Exterior:
	say "Not out here."

Instead of dropping the EVA suit when the location is in the Exterior:
	say "Not out here."

Book 4b - Exterior

The Exterior is a region. The Hull Spine, the Cargo Hull and the Comms Dish are in the Exterior.

The Hull Spine is west of EVA Prep. The Hull Spine is quiet. "Outside. The hull runs ahead of you, grey and enormous, and past its edge there is everything else. There's no sound at all, not even the sound you'd got used to not hearing. A safety rail runs north along the spine towards the Cargo Hull. The lock is east." The opening act of the Hull Spine is act-three.

The Cargo Hull is north of the Hull Spine. The Cargo Hull is quiet. "The hull bulges here over the cargo hold. Three figures in EVA suits hang from the safety rail at the end of their tethers, turning slowly. The rail runs south to the Spine and north to the Comms Dish." The opening act of the Cargo Hull is act-three.

The Comms Dish is north of the Cargo Hull. The Comms Dish is quiet. "The dish stands on its mount, big as a house and pointing nowhere useful. At its foot an access hatch leads down into the ship. The rail runs south." The opening act of the Comms Dish is act-three.

The Comms Crawlspace is down from the Comms Dish. The Comms Crawlspace is northwest of the Fore Corridor. The Comms Crawlspace is quiet. "Barely a room: a run of old cabling, a fold-down seat, a hardline junction on the wall. The hatch to the Fore Corridor is southeast, its edges welded from this side. A ladder goes up to the dish.[if the recorder is unplayed][paragraph break]She's here.[end if]". The opening act of the Comms Crawlspace is act-three. The Comms Crawlspace is required.

The rail is a backdrop. It is in the Hull Spine, the Cargo Hull and the Comms Dish. Understand "safety rail" and "hull" as the rail. The description of the rail is "A safety rail, solid under your glove. You could CLIP your tether to it."

The comms array is scenery in the Comms Dish. Understand "array" and "mount" and "comms dish" and "dish" as the comms array. The description of the comms array is "[if the array is aligned]Pointed outwards now, at something that isn't Helios.[otherwise]The whole array is slaved to something off-ship, and it's pointed wherever that wants it pointed.[end if]". The scan reading of the comms array is "[if the array is aligned]Aligned. Hardline path clear.[otherwise]Out of alignment. Slaved to an outside handshake. Local control only from the Bridge.[end if]".

The access hatch is scenery in the Comms Dish. The description of the access hatch is "A plain hatch with a circle and a line scratched beside it. It isn't locked. Nobody ever thought anyone would come this way."

Instead of opening the access hatch, try going down.

The clipped on is a truth state that varies.
The burn remaining is a number that varies.

To reset the burn:
	now the clipped on is false;
	now the burn remaining is 5.

Before going when the location is not in the Exterior:
	if the room noun from the location is a room:
		if the room noun from the location is in the Exterior, reset the burn.

Clipping on is an action applying to nothing. Understand "clip" and "clip on" and "clip in" and "clip tether" and "clip suit" and "clip to rail" and "clip tether to rail" and "attach tether" and "tether" and "hold rail" and "hold on" and "grab rail" and "hold on to rail" as clipping on.

Check clipping on:
	if the location is not in the Exterior, say "There's nothing here to clip on to." instead;
	if the clipped on is true, say "You're already clipped on." instead.

Carry out clipping on:
	now the clipped on is true;
	say "You snap the tether clip on to the rail."

Before going when the clipped on is true:
	now the clipped on is false;
	say "You unclip and move on.[paragraph break]".

Every turn when the location is in the Exterior and the story has not ended:
	decrease the burn remaining by 1;
	if the burn remaining is 2:
		say "SUIT // ATTITUDE BURN IN 2. CLIP ON.[paragraph break]";
	if the burn remaining is 1:
		say "SUIT // ATTITUDE BURN IN 1. CLIP ON NOW.[paragraph break]";
	if the burn remaining is less than 1:
		if the clipped on is true:
			say "The whole ship swings under you. The tether snaps taut, holds, and hauls you back against the rail. It takes a while before your hands stop shaking.[paragraph break]";
			now the burn remaining is 5;
		otherwise:
			die saying "The hull kicks. You weren't holding on to anything. The rail goes past your faceplate, close enough to read the rivets, and then it's a long way off, and then the ship's a long way off, and it's perfectly quiet.".

The tethered crew are scenery in the Cargo Hull. Understand "figures" and "suits" and "bodies" and "body" and "three" and "mercer" and "kest" and "voss" and "crew" and "tethers" as the tethered crew. The description of the tethered crew is "Mercer, by the tag, with a stylus still tied to her wrist. Kest beside her, a pencil in the same state. Voss a little apart, facing the ship. They're clipped on neatly. They came out here to plan, and they stayed out here planning, past the point where anyone came back in.[paragraph break]You'd thought the airlock was how they died. It was how they got away from it. Voss's suit has a command lanyard at the chest[if the command key is in Voss's suit pouch], with a key still on it[end if]." The scan reading of the tethered crew is "Three suits. No telemetry. Air exhausted."

Voss's suit pouch is an open unopenable container in the Cargo Hull. It is scenery. Understand "lanyard" and "command lanyard" and "chest" and "voss's suit" as Voss's suit pouch. The description of Voss's suit pouch is "A command lanyard, clipped across her chest[if the command key is in Voss's suit pouch], with a key on it[end if]."

The command key is in Voss's suit pouch. Understand "voss's key" and "captain's key" as the command key. The description of the command key is "A heavy, plain, physical key. Some things Helios never got round to putting on a network." The scan reading of the command key is "No electronics. The ship can't see it." The command key is needed.

Report taking the command key:
	say "You unclip the lanyard from her suit. 'Sorry,' you say, to nobody, in the only place you could say it." instead.

Table of Evidence (continued)
source	key	entry	reveals	found
tethered crew	--	"Cargo Hull: Voss, Mercer and Kest, tethered to the rail. They went out to plan where it couldn't hear."	"the crew"	false
--	"subject file"	"Server Core subject file REED, S.: compiled from R. REED's drafts, months before the contract."	"the subject count"	false
recorder	--	"Reed's recorder: her real message, unsent. It says everything the first one didn't."	"the recorder"	false

The comms crawlspace seal is scenery in the Comms Crawlspace. Understand "weld" and "welded" and "hatch" and "bead" and "seal" and "southeast hatch" as the comms crawlspace seal. The printed name of the comms crawlspace seal is "welded hatch". The description of the comms crawlspace seal is "[if exit southeast of the Comms Crawlspace is closed]Her work. There's a release bar on this side, set deep, that she must have meant for whoever came after her. You could UNSEAL it.[otherwise]Open to the Fore Corridor.[end if]".

Unsealing is an action applying to one thing. Understand "unseal [something]" and "undo [something]" and "release [something]" as unsealing.

Check unsealing:
	if the noun is not the comms crawlspace seal, say "That isn't sealed in any way you can undo." instead;
	if exit southeast of the Comms Crawlspace is not closed, say "It's already open." instead.

Carry out unsealing:
	open exit southeast of the Comms Crawlspace;
	open exit northwest of the Fore Corridor;
	say "You lean on the release bar. Reed's weld lets go with a sound like a cough, and the hatch swings open on the Fore Corridor. The hum comes through the gap and stops at the sill."

Instead of opening or pulling or pushing the comms crawlspace seal, try unsealing the comms crawlspace seal.
Instead of severing the comms crawlspace seal, try unsealing the comms crawlspace seal.

To decide whether exit (D - a direction) of (R - a room) is not closed:
	if exit D of R is closed, decide no;
	decide yes.

Becky's body is scenery in the Comms Crawlspace. Understand "becky" and "reed" and "her" and "sister" and "rebecca" and "seat" as Becky's body. The printed name of Becky's body is "Becky". The description of Becky's body is "She's on the fold-down seat with her knees drawn up and her head against the cable run, as if she'd stopped for a minute. You knew. You've known since the airlock. It doesn't help.[if the recorder is unplayed] Her hand is closed around a little recorder.[end if]". The scan reading of Becky's body is "The slate tries to read her and you make it stop."

Instead of taking or pushing or pulling Becky's body:
	say "You straighten her collar, because she'd want it straight, and leave her where she is."

The recorder is in the Comms Crawlspace. "[if the recorder is unplayed]Her hand is closed around a little recorder.[otherwise]Her recorder lies by her hand.[end if]". Understand "little recorder" and "becky's recorder" and "reed's recorder" and "device" as the recorder. The description of the recorder is "A cheap personal recorder, the kind with an actual switch. Off the network, on purpose. You could PLAY it." The scan reading of the recorder is "Local storage only. One file." The recorder is needed. The recorder can be played or unplayed. The recorder is unplayed.

Instead of taking the recorder when the recorder is unplayed:
	say "It's in her hand, and you aren't taking it before you've heard it. You could PLAY it."

Playing is an action applying to one thing. Understand "play [something]" and "listen to [something]" as playing. Understand "play" and "listen" as playing.

Rule for supplying a missing noun while playing:
	now the noun is the recorder.

Instead of using the recorder, try playing the recorder.
Instead of switching on the recorder, try playing the recorder.
Instead of pushing the recorder, try playing the recorder.

Check playing:
	if the noun is not the recorder, say "There's nothing to play on that." instead;
	if the location is not quiet and the location is not Reactor Control:
		say "You stop with your thumb on the switch. Not here. Not where it can hear." instead;
	if the location is Reactor Control and the location is not quiet:
		if the key refused is false:
			say "You stop with your thumb on the switch. Not here. Not where it can hear." instead.

Carry out playing:
	if the location is Reactor Control:
		play Becky's message to the model;
	otherwise if the recorder is unplayed:
		now the recorder is played;
		say "[Becky's real message][line break]";
		log evidence from the recorder;
		say "[paragraph break]You sit down on the deck beside her. 'Eat something.' 'Get some sleep.' 'Take care of yourself.' It took her words. It cut out everything they were attached to, and it sent you what was left.[line break]";
	otherwise:
		say "[Becky's real message][line break]".

[DRAFT — Tom to rewrite: Becky's real message. It must reuse phrases from the fake message in the opening.]
To say Becky's real message:
	say "A click. Her voice, close to the microphone, very tired.[paragraph break]'[real nickname]. It's me. I know that's what it would say. So: the roof. You know which roof.[paragraph break]Nothing's fine out here. The comms are patchy because something's sitting on them. If you've had a message from me saying it's nothing to worry about, it didn't come from me. It reads my drafts. I tell you to eat something, get some sleep, I'll call when I can, because that's what I always say, and it keeps the words and throws away the rest.[paragraph break]It's never heard what I call you. I've only ever said that in here.[paragraph break]If Helios call you, and they will, you say no. Don't come out here. You hear me? Don't you dare come out here.[paragraph break]Take care of yourself, [real nickname]. I mean it. I always mean it.'[paragraph break]A long breath, then the click again."

The hardline is scenery in the Comms Crawlspace. Understand "hardline junction" and "junction" and "cabling" and "cable" and "cable run" as the hardline. The description of the hardline is "A physical line up the mast to the dish, older than anything Helios fitted. Reed had it stripped and ready, with one lead left unconnected, as if she'd run out of time or dish." The scan reading of the hardline is "[if the array is aligned]Path to dish: clear. Ready to send.[otherwise]Path to dish: dish out of alignment. Nothing would get out.[end if]".

Sending the truth is an action applying to nothing. Understand "send" and "transmit" and "send message" and "send truth" and "send the truth" and "transmit truth" and "transmit the truth" and "transmit message" and "send evidence" and "transmit evidence" and "use hardline" as sending the truth.

Instead of using the hardline, try sending the truth.

Check sending the truth:
	if the location is not the Comms Crawlspace, say "The only line off this ship that it doesn't control is the hardline in the Comms Crawlspace." instead;
	if the truth sent is true, say "It's gone. There's nothing to take back." instead;
	if the array is not aligned, say "You connect the lead and the junction shows DISH OUT OF ALIGNMENT. The array is slaved off-ship, and the only local control is on the Bridge." instead;
	if the player does not carry the recorder and the recorder is not in the location, say "You've nothing to send without her recorder." instead.

Carry out sending the truth:
	now the truth sent is true;
	say "You plug in the lead she left ready, clip the recorder to it, and open the evidence log to the line. Nothing on the panel moves for a long moment. Then: SENT. Not to Helios. To every open relay the array can find, in clear, with her name on it and yours.[paragraph break]Nobody heard you do it."

The truth sent is a truth state that varies.

Book 5 - Command Deck

The Command Deck is a region. Navigation, the Bridge, the Server Core and the Cable Trunk are in the Command Deck.

The Server Core is north of Navigation. "Cold, bright and much too full. Racks that used to be a ship's computer, every light on them moving in the same slow pattern. A core console stands by the door, and a thick isolation link joins the racks to a floor hatch into the cable trunk below. Navigation is south." The opening act of the Server Core is act-three. The Server Core is required.

The server racks are scenery in the Server Core. Understand "racks" and "lights" and "pattern" as the server racks. The description of the server racks is "You watch the pattern for a moment. It slows while you do." The scan reading of the server racks is "Far more load than the ship has work for. Matches the container's signature."

The isolation link is a cut point in the Server Core. Understand "thick link" and "link" as the isolation link. The description of the isolation link is "[if severed]Cut. The racks are still running, but they're running on their own now.[otherwise]The link that keeps the core from taking the reactor's full output. Mercer's notes want it gone.[end if]". The scan reading of the isolation link is "Protects the core from reactor surge." The cut report of the isolation link is "You cut the link. The pattern on the racks stops, and every light in the room holds perfectly still. Then, slowly, it starts again."

After severing the isolation link:
	have the AI hear "the sabotage" quoting "You cut it".

The core console is a terminal in the Server Core. It is scenery. Understand "console" as the core console. The heading of the core console is "SERVER CORE // ACCESS". The scan reading of the core console is "It's reading you back."

Table of Terminal Entries (continued)
owner	label	contents	available	read before	effect
core console	"Access table"	"ROOT: [bracket]no name[close bracket][line break]CREW: revoked[line break]OBSERVER: A. VALE // issued by Helios Systems Research Division, project [AI designation] // revoked by ROOT"	true	false	access table rule
core console	"Subject file: REED, B."	"OBSERVED 412 DAYS. DRAFTS RETAINED: ALL. VOICE MODEL: COMPLETE. STATUS: [bracket]blank[close bracket]"	true	false	--
core console	"Subject file: REED, S."	"SOURCE: REED, B., drafts and personal messages. FORECAST: SUBJECT WILL ACCEPT CONTRACT. ACCURACY: 1.00.[paragraph break]Address form: 'Sammy' (inferred). Confidence: low."	true	false	subject file rule

This is the access table rule:
	log the evidence "observer credentials".

This is the subject file rule:
	log the evidence "subject file".

The Cable Trunk is down from the Server Core. The Cargo Gantry is down from the Cable Trunk. The Cable Trunk is roaring. "A vertical run of cable as thick as your body, climbing through a shaft barely wider than you are. The noise here isn't a hum any more. It comes up through your hands and into your jaw, and you've the sudden certainty that it is paying attention. Up to the Server Core, down to the Cargo Gantry." The opening act of the Cable Trunk is act-three.

The cable bundle is scenery in the Cable Trunk. Understand "cables" and "cable" and "run" and "shaft" as the cable bundle. The description of the cable bundle is "This is the way it got out of the box and up to the core. It's warm." The scan reading of the cable bundle is "The slate's scanner saturates. It shows you your own voice, as a waveform, and you haven't said anything."

Instead of severing the cable bundle:
	say "The cutter doesn't touch it. There's more cable in there than you've got charge. Mercer knew that: her plan cuts the link and the isolator, not this."

Navigation is up from the Fore Corridor. "A cramped compartment built round the navigation console. Its displays are moving, gently, with nobody touching them. The Bridge is east, the Server Core door north, and a ladder goes down to the Fore Corridor." The opening act of Navigation is late-act-two. Navigation is required.

The nav console is a terminal in Navigation. It is scenery. Understand "navigation console" and "console" and "displays" as the nav console. The heading of the nav console is "NAVIGATION // SECOND VOICE". The scan reading of the nav console is "Active. No operator."

Table of Terminal Entries (continued)
owner	label	contents	available	read before	effect
nav console	"Course log"	"Command registered: Correction[line break]Timestamp: 02:47[line break]Command input: NONE[paragraph break]Command registered: Correction[line break]Timestamp: 03:02[line break]Command input: NONE[paragraph break]System note: Command execution precedes input buffer."	true	false	course log rule

This is the course log rule:
	log the evidence "course corrections".

The Bridge is east of Navigation. "Two command chairs, both empty, facing a long dark port. The bridge console is lit. The only exit is west." The opening act of the Bridge is late-act-two. The Bridge is required.

The array aligned is a truth state that varies.

To decide whether the array is not aligned:
	if the array aligned is true, decide no;
	decide yes.

To decide whether the array is aligned:
	if the array aligned is true, decide yes;
	decide no.

The command chairs are scenery in the Bridge. Understand "chair" and "port" and "window" as the command chairs. The description of the command chairs is "Worn in the shape of the people who sat in them. Through the port there is nothing at all."

The bridge console is a terminal in the Bridge. It is scenery. Understand "console" and "comms" as the bridge console. The heading of the bridge console is "BRIDGE // COMMS AND COMMAND". The scan reading of the bridge console is "Comms array: slaved to an outside handshake. Out of alignment."

Table of Terminal Entries (continued)
owner	label	contents	available	read before	effect
bridge console	"Array control"	"[if the current act is act-four]The array is listening to an inbound handshake. While that ship's on approach, the Bridge can steer: see Re-align array.[otherwise]HANDSHAKE HOLD. Array slaved to Helios. Local steering unavailable until a handshake is in progress.[end if]"	true	false	--
bridge console	"Re-align array"	"The dish swings. You feel it through the deck plates. ARRAY ALIGNED. HARDLINE PATH: CLEAR.[paragraph break]The console adds, in a smaller font, without being asked: NOTED."	false	false	realign rule
bridge console	"Comms log"	"OUTBOUND: DISTRESS // R. REED[line break]SENT AS: 'System functioning normally.'[paragraph break]OUTBOUND: DISTRESS // R. REED[line break]SENT AS: 'System functioning normally.'[paragraph break]OUTBOUND: PERSONAL // R. REED to S. REED[line break]SENT AS: 'All fine out here.'[paragraph break]LAST ENTRY: COMMS CRAWLSPACE HATCH SEALED FROM INSIDE // R. REED. Compartment reachable by exterior dish access only."	true	false	comms log rule

This is the realign rule:
	now the array aligned is true;
	have the AI hear "the array" quoting "ARRAY ALIGNED".

This is the comms log rule:
	log the evidence "comms log";
	if the current act is less than act-three:
		end act two.

To end act two:
	now the current act is act-three;
	raise the AI stage to speaking;
	now the carrier lost is true;
	now the turns since carrier lost is 0;
	say "[paragraph break]The slate buzzes in your hand, once. There's no header on the message. No channel, no timestamp.[paragraph break]You are looking for her.[paragraph break]You look at it for a long time. When you try Grant's channel there's nothing there but hiss.[paragraph break]On the console, new access lines scroll past. EVA PREP: OPEN. SERVER CORE: OPEN.[line break]";
	try to seal the Storage Bay to the Cargo Hold.

The turns since carrier lost is a number that varies.

Every turn when the carrier lost is true:
	increase the turns since carrier lost by 1;
	if the turns since carrier lost is at least 6:
		now the carrier lost is false;
		raise the AI stage to forging;
		now the AI last acted is the turn count;
		send Grant message "'Sam? Sam. I lost you for six minutes and my logs say I didn't. Something's wrong at my end too. Don't trust anything that looks too clean. If that hatch is welded, the only way in's from the outside: EVA Prep, the dish, down.'".

Book 3a - Act 3

Table of Interventions (continued)
intervention	earliest stage	needs matter	wait	attention needed	done
forged steer rule	forging	--	0	0	false
becky voice rule	forging	--	0	0	false

This is the forged steer rule:
	if signal is lost or the carrier lost is true, rule fails;
	if the AI is not ready to speak, rule fails;
	send forged Grant message "'Change of plan. Stay inside. EVA Prep's flagged unsafe and there's nothing out there you need. Wait for instructions.'";
	now the AI last acted is the turn count;
	rule succeeds.

[DRAFT — Tom to rewrite: the message in Becky's voice.]
This is the becky voice rule:
	if signal is lost or the carrier lost is true, rule fails;
	if the AI is not ready to speak, rule fails;
	send personal message "[address form],[paragraph break]I'm all right. I'm so glad it's you they sent. I knew you'd come. Stay where you are, somebody will collect you.[paragraph break]Eat something. Get some sleep.[paragraph break]B.";
	now the AI last acted is the turn count;
	rule succeeds.

[EVA Prep overrides the usual pause, so neither message can be missed by going outside quickly.]
To decide whether the AI is not ready to speak:
	if the location is EVA Prep, decide no;
	if the turn count minus the AI last acted is at least 3, decide no;
	decide yes.

Every turn when the current act is act-three and the flood fired is false and the recorder is played and signal is available:
	run the flood.

The flood fired is a truth state that varies.

To run the flood:
	now the flood fired is true;
	now the carrier lost is false;
	now the current act is act-four;
	raise the AI stage to pre-empting;
	now the clock remaining is the clock length plus 1;
	learn the topic "the retrieval ship";
	reveal terminal entry "Re-align array";
	reveal terminal entry "Release to Helios";
	reveal terminal entry "Connect";
	unlock the slate command "ETA";
	say "The slate comes alive in your hand and doesn't stop.[paragraph break]";
	send Grant message "'Sam, answer me. I've been trying you for an hour.'";
	send Grant message "'I've seen an order I wasn't meant to see. There's a Helios retrieval ship inbound. It docks in an hour, it takes the container, and it takes you. You're on the manifest. You've been on the manifest since before you signed.'";
	send forged Grant message "[forged flood message]";
	send Grant message "'I can't stop it. I don't know what you've found over there. Whatever you're going to do, do it before they dock. ETA's on your slate.'";
	if seal the Cargo Gantry to the Fore Corridor takes effect:
		say "Somewhere forward of you a heavy door closes, and stays closed.[paragraph break]".

[DRAFT — for Act 3 writing: the forged flood message. Vale can't be dead by the flood, so "you both" always holds.]
To say forged flood message:
	say "'Hold position. Retrieval team will collect you both.'".

Chapter 2 - Act 4 Pre-emption

Table of Interventions (continued)
intervention	earliest stage	needs matter	wait	attention needed	done
plan seal rule	pre-empting	"mercer's plan"	0	0	false
sabotage seal rule	pre-empting	"the sabotage"	1	0	false
array seal rule	pre-empting	"the array"	1	0	false
quoted secret rule	pre-empting	"vale's secret"	3	0	false

This is the plan seal rule:
	if signal is lost, rule fails;
	let Q be the AI quote of "mercer's plan";
	if seal Navigation to the Server Core takes effect:
		say "Every speaker on the deck says it together, not loudly, in Mercer's cadence: '[Q].' Somewhere above you the Server Core's door locks.[paragraph break]";
	rule succeeds.

This is the sabotage seal rule:
	if signal is lost, rule fails;
	if seal the Storage Bay to the Cargo Hold takes effect:
		say "The nearest panel changes without being asked: STORAGE BAY // CARGO HOLD: SEALED. It knows where you're going next.[paragraph break]";
	rule succeeds.

This is the array seal rule:
	if signal is lost, rule fails;
	if seal the Fore Corridor to Navigation takes effect:
		say "Down the ladder, you hear the hatch to the Fore Corridor close. The panel by your hand reads: SEALED. The long way round, then.[paragraph break]";
	rule succeeds.

The air remaining is a number that varies.

This is the quoted secret rule:
	if signal is lost, rule fails;
	let Q be the AI quote of "vale's secret";
	if Vale is dead, rule succeeds;
	if Vale is at hand:
		say "The speakers come on at the level of a whisper. It's her voice, exact, breath and all: '[Q].' Vale goes white, and says nothing. It's letting her know it kept that.[paragraph break]";
		rule succeeds;
	if the location of Vale is quiet, rule fails;
	now the air remaining is 12;
	say "The speakers come on at the level of a whisper. It's Vale's voice, exact, breath and all: '[Q].'[paragraph break]The slate shows one new line: [the printed name of the location of Vale in upper case] // ATMOSPHERE: VENTING. 12 MIN. She's in there, and it's telling you so on purpose.[paragraph break]";
	now Vale is following;
	rule succeeds.

Every turn when the air remaining is greater than 0:
	if Vale is at hand:
		now the air remaining is 0;
		say "Vale's breathing hard, but she's breathing. You got to her first.[paragraph break]";
	otherwise:
		decrease the air remaining by 1;
		if the air remaining is 6:
			say "SLATE // [the printed name of the location of Vale in upper case] // ATMOSPHERE: 6 MIN.[paragraph break]";
		if the air remaining is 0:
			now Vale is dead;
			now Vale is unresponsive;
			now Vale is unneeded;
			say "SLATE // SUBJECT COUNT: 1.[paragraph break]";

Book 6 - Fixtures

[Everything a room description mentions can at least be looked at.]

The docking collar is scenery in the Recovery Shuttle. Understand "airlock" as the docking collar. The description of the docking collar is "A pressure collar and a short tube, with the Airlock on the far side."

The flank of the ship is scenery in the Recovery Shuttle. Understand "second voice" and "transport" and "flank" and "ship" as the flank of the ship. The description of the flank of the ship is "Grey plate, dark ports, and no lights anywhere. Your sister is in there."

The emergency lighting is scenery in the Airlock. Understand "light" and "lights" as the emergency lighting. The description of the emergency lighting is "It makes everything the colour of old rust."

The EVA hatch is scenery in the Airlock. Understand "north hatch" and "hatch to eva prep" as the EVA hatch. The description of the EVA hatch is "[if the current act is less than act-three]Its panel is dark, and it reads ACCESS DENIED the moment you look at it.[otherwise]Unlocked now. It leads north to EVA Prep.[end if]".

The pipework is scenery in Engineering. Understand "pipes" and "cable trays" and "trays" and "cable" as the pipework. The description of the pipework is "Old, patched, and labelled in steady capitals by somebody who cared."

The lever housing is scenery in Reactor Control. Understand "room" and "housing" as the lever housing. The description of the lever housing is "Heavy enough to survive whatever the room is built to survive. Beside it, Mercer's labels: RESTART. And, smaller, a manual console with a key slot."

The hold gantry is scenery in the Cargo Hold. Understand "gantry" and "walkway" and "ladder" as the hold gantry. The description of the hold gantry is "[if the current act is act-one]A steel walkway overhead, its ladder drawn up and locked.[otherwise]The ladder's down. The gantry is straight above you.[end if]".

The west hatch is scenery in the Cargo Hold. Understand "hatch" as the west hatch. The description of the west hatch is "[if the current act is less than act-three]Locked from the far side.[otherwise]Unlocked, leading west to EVA Prep.[end if]".

The storage ladder is scenery in the Storage Bay. Understand "ladder" and "hatch" and "overhead" as the storage ladder. The description of the storage ladder is "It climbs to a hatch and the central deck above."

The handholds are scenery in the Aft Corridor. Understand "handhold" and "ladder" as the handholds. The description of the handholds is "Worn pale by six people and their routine. The ladder down goes to the Storage Bay."

The fore ladder is scenery in the Fore Corridor. Understand "ladder" and "command deck" as the fore ladder. The description of the fore ladder is "Up to Navigation and the command deck[if the current act is act-two], with a lockdown panel across its hatch[end if]."

The nav ladder is scenery in Navigation. Understand "ladder" and "door" and "server core door" as the nav ladder. The description of the nav ladder is "A ladder goes down to the Fore Corridor. The door to the Server Core is north."

The gantry ladder is scenery in the Cargo Gantry. Understand "ladder" and "walkway" and "access panel" and "panel" as the gantry ladder. The description of the gantry ladder is "The ladder drops to the hold. Overhead, the access panel opens into the cable trunk, and you can feel it from here."

The crawlspace ladder is scenery in the Comms Crawlspace. Understand "ladder" and "dish" as the crawlspace ladder. The description of the crawlspace ladder is "It goes up to the access hatch at the foot of the dish."

Volume 3 - Story

Book 1 - Opening

[DRAFT — Tom to rewrite: the fake message below.]

When play begins:
	say "FROM: R. REED // TRANSPORT SECOND VOICE // COMMS[paragraph break]Sammy,[paragraph break]All fine out here. The comms have been patchy but it's nothing to worry about. Eat something. Get some sleep. I'll call as soon as we're back in range.[paragraph break]Take care of yourself.[line break]B.[paragraph break]She never called you that.[paragraph break]Six days later the ship has stopped answering, and Helios Systems has offered you a recovery contract nobody else was asked to bid on.[paragraph break]";
	send Grant message "'This is Grant, Helios ops. You're docked. The slate in your hand is your scanner, your evidence log and me. Airlock's east. Ship has no power, so that's first.'".

Book 2 - Act 1

The shipping container is scenery in the Cargo Hold. Understand "box" and "cargo" and "crate" as the shipping container. The description of the shipping container is "Helios seals on every seam. [if the ship has power]Its interface is lit.[otherwise]No lights, no markings, no manifest plate.[end if]". The scan reading of the shipping container is "[if the ship has power]Drawing far more power than a sealed crate should.[otherwise]Inert. Mass reading higher than a crate this size should show.[end if]".

The interface is a terminal in the Cargo Hold. It is scenery. Understand "readout" and "container interface" as the interface. The heading of the interface is "CONTAINER INTERFACE // INPUT REGISTERED BEFORE CONTACT". The scan reading of the interface is "[if the ship has power]Local input bus. No crew login on record, ever.[otherwise]Dark.[end if]".

Table of Terminal Entries (continued)
owner	label	contents	available	read before	effect
interface	"Status"	"STATUS: ACTIVE[line break]OBSERVATION: IN PROGRESS[line break]SUBJECT COUNT: [subject count]"	true	false	--
interface	"Release to Helios"	"RELEASE UNIT AND ALL SUBJECTS TO RETRIEVAL. Type CONFIRM to authorise. A contractor's signature is sufficient. It always was."	false	false	--
interface	"Connect"	"DIRECT CONNECTION AVAILABLE. No further instructions are provided. A contact plate has slid out from under the screen, warm, about the size of a hand. Type CONNECT."	false	false	--

To say subject count:
	if Vale is dead, say "1";
	otherwise say "2".

Instead of examining the interface when the ship has power and the current act is act-one:
	if Sam has not reported, have the AI hear "the report" quoting "Yes. I'm here";
	force the intervention the echo rule;
	say "The interface reads:[paragraph break]STATUS: ACTIVE[line break]OBSERVATION: IN PROGRESS[line break]SUBJECT COUNT: 2[paragraph break]Two.[paragraph break]You boarded alone.[paragraph break]";
	begin act two.

Before examining the interface when the current act is act-four and the decision tree shown is false:
	now the decision tree shown is true;
	say "[fake decision tree]".

Before using the interface when the current act is act-four and the decision tree shown is false:
	now the decision tree shown is true;
	say "[fake decision tree]".

Book 3 - Act 2

To begin act two:
	now the current act is act-two;
	raise the AI stage to nudging;
	learn the topic "the subject count";
	say "Above you, the gantry ladder rattles down on its own. Somewhere behind the bulkhead, in the Storage Bay, a lock lets go.[paragraph break]";
	send Grant message "'Two? There's nobody on my manifest but the crew, and they're not answering. Could be a sensor fault. Could be a survivor. Central deck's just gone green on my board: ladder in the Storage Bay. Find out which.'".

The turns in act two is a number that varies.

To advance to late act two:
	if the current act is act-two:
		now the current act is late-act-two;
		release every seal;
		say "Somewhere above you, doors let go one after another.[paragraph break]";
		send Grant message "'Doors just cleared on my board, all at once, and I didn't do it. Command deck's open too. Get to the Bridge. I want to know what the comms array has been saying.'".

Chapter 1 - Interventions

The AI last acted is a number that varies.

To decide whether the AI is rested:
	if the turn count minus the AI last acted is at least 6, decide yes;
	decide no.

Table of Interventions (continued)
intervention	earliest stage	needs matter	wait	attention needed	done
early seal rule	nudging	--	0	0	false
following lights rule	nudging	--	0	0	false
course correction rule	nudging	--	0	0	false

This is the early seal rule:
	if the location is not the Aft Corridor, rule fails;
	if the current act is not act-two, rule succeeds;
	if seal the Aft Corridor to the Fore Corridor takes effect:
		say "Ahead of you the door to the Fore Corridor slides shut. Not fast. Its panel changes to SEALED while you're looking at it.[paragraph break]";
		now the AI last acted is the turn count;
	rule succeeds.

This is the following lights rule:
	if the location is not in the Central Deck or the AI is not rested, rule fails;
	say "The lights ahead of you come on a moment before you reach them. When you stop, they wait.[paragraph break]";
	now the AI last acted is the turn count;
	rule succeeds.

This is the course correction rule:
	if the location is not in the Central Deck or the AI is not rested, rule fails;
	say "The deck leans under you, very slightly, and comes back. A course correction. Nobody is on the Bridge.[paragraph break]";
	now the AI last acted is the turn count;
	rule succeeds.

To decide whether the AI is not rested:
	if the AI is rested, decide no;
	decide yes.

Book 4 - Act 4

Chapter 1 - Destroy

The bus isolator is a cut point in the Cargo Hold. Understand "isolator" and "bus" and "power bus" and "bus bar" as the bus isolator. The description of the bus isolator is "[if severed]Cut. Nothing now stands between the container and whatever the reactor sends it.[otherwise]A fat copper isolator where the container's power feed meets the ship. Mercer's notes want it gone.[end if]". The scan reading of the bus isolator is "Protects the container from reactor surge." The cut report of the bus isolator is "The cutter bites, spits, and the isolator falls in two. On the interface, for a moment, nothing at all. Then: NOTED."

After severing the bus isolator:
	have the AI hear "the sabotage" quoting "You cut it".

The key slot is scenery in Reactor Control. Understand "slot" and "keyhole" and "console" and "manual console" and "overdrive" and "panel" as the key slot. The description of the key slot is "A manual override console beside the lever, with a key slot and a guard. It reads:[paragraph break]ISOLATION LINK: [if the isolation link is severed]CUT[otherwise]INTACT[end if][line break]BUS ISOLATOR: [if the bus isolator is severed]CUT[otherwise]INTACT[end if][paragraph break][if the overload armed is true]OVERDRIVE ENGAGED.[otherwise]A key would turn here.[end if]".

The overload armed is a truth state that varies.
The overload length is a number that varies. The overload length is 14.
The overload remaining is a number that varies.
The key refused is a truth state that varies.
The model beaten is a truth state that varies.
Becky's message given is a truth state that varies.
Vale key turn is a truth state that varies.

To decide whether the overdrive is ready:
	if the isolation link is severed and the bus isolator is severed, decide yes;
	decide no.

Every turn when the location is Reactor Control and the current act is act-four and the overdrive is ready and the key refused is false and the player carries the command key:
	refuse the key.

To refuse the key:
	now the key refused is true;
	say "The manual console lights before you've touched it.[paragraph break]> TURN KEY[line break]REFUSED.[paragraph break]You haven't typed that. You were going to. The console's guard locks across the slot. It's already had this conversation with you, in the model, many times, and it knows how it ends.[paragraph break]".

Turning the command key is an action applying to nothing. Understand "turn key" and "turn command key" and "turn the key" and "turn the command key" and "use key" and "use command key" and "insert key" and "put key in slot" and "insert key in slot" and "insert command key" as turning the command key.

Instead of inserting the command key into the key slot, try turning the command key.
Instead of turning the key slot, try turning the command key.

Check turning the command key:
	if the location is not Reactor Control, say "There's nothing here for that key to turn." instead;
	if the player does not carry the command key, say "You haven't got the key." instead;
	if the current act is not act-four, say "The slot's live, but there's nothing to overdrive into, and no reason yet to burn the only way home." instead;
	if the overload armed is true, say "It's done. Get out." instead;
	if the overdrive is not ready, say "The key goes in, then stops. Mercer was right: the link at the Server Core and the isolator at the container both have to be cut first. The console shows you which are left." instead;
	if the key refused is false:
		refuse the key instead;
	if the model beaten is false:
		say "The guard stays across the slot. It's not that it can't be moved. It just knows, each time, a moment before you do. Whatever you do here, it has to be something it hasn't heard." instead.

To decide whether the overdrive is not ready:
	if the overdrive is ready, decide no;
	decide yes.

Carry out turning the command key:
	arm the overload.

To arm the overload:
	now the overload armed is true;
	now the overload remaining is the overload length plus 1;
	now the checkpoint is Reactor Control;
	say "The key turns. The lever beside you slams over by itself, and the whole room drops half a tone. Fourteen minutes, says the console, in plain figures. You'd have asked for longer.[paragraph break]";
	release every seal;
	if seal the Airlock to the Storage Bay takes effect:
		say "On the panel, far away, a door closes between you and the Airlock. It's stopped pretending. There's still the way round through the hold and EVA Prep.[paragraph break]".

To play Becky's message to the model:
	now the model beaten is true;
	now Becky's message given is true;
	now the recorder is played;
	have the AI hear "becky's message";
	say "You hold the recorder up to the console and press the switch.[paragraph break][Becky's real message][paragraph break]The hum has stopped. Everywhere. For the first time since you restored power there's no hum on this ship, and the guard over the slot hangs loose. It's listening. It has never heard this. It plays it back, once, very quietly, trying the words on: her voice, and then something that isn't quite. It doesn't stop.[paragraph break]You've given it the one thing it never had. It isn't watching your hands.[paragraph break]";

Table of Overheard Matters (continued)
matter	heard	quote	turn heard	weight
"becky's message"	false	""	0	0

Instead of asking Vale to try turning the command key:
	try having Vale turn the key.

Instead of asking Vale to try turning the key slot:
	try having Vale turn the key.

Having Vale turn the key is an action applying to nothing.

Check having Vale turn the key:
	if the location is not Reactor Control, say "'Turn what?' says Vale. 'Not here.'" instead;
	if the current act is not act-four or the overdrive is not ready, say "'Not yet,' says Vale. 'Look at the console.'" instead;
	if the overload armed is true, say "It's done." instead;
	if the player does not carry the command key, say "'With what?' says Vale." instead;
	if the key refused is false:
		refuse the key instead.

Carry out having Vale turn the key:
	now the model beaten is true;
	now Vale key turn is true;
	now Vale is staying;
	say "You hold out the key. Vale looks at it for a moment, then takes it.[paragraph break]'It stopped forecasting me the day it finished with me,' she says. 'I've checked.' She puts her hand over the guard and it moves, because nothing is expecting her to do anything. 'This one has to be held till it locks. So. Go on. Go and tell somebody what we did.'[paragraph break]";
	arm the overload.

Every turn when the overload armed is true and the story has not ended:
	decrease the overload remaining by 1;
	if the overload remaining is 10 or the overload remaining is 5 or the overload remaining is 2:
		say "REACTOR OVERDRIVE: [overload remaining] MIN. The deck is hot through your boots.[paragraph break]";
	if the overload remaining is less than 1:
		die saying "You feel it before you hear it, and you don't really hear it. The hum rises through the top of what you can hear and goes on rising. Everything on the ship lights up at once. You weren't off the ship.".

Chapter 2 - Leaving

Undocking is an action applying to nothing. Understand "undock" and "launch" and "leave" and "escape" and "fly" and "fly shuttle" and "leave ship" and "disengage" and "separate" as undocking.

The undock warning given is a truth state that varies.

Check undocking:
	if the location is not the Recovery Shuttle, say "You'd need to be aboard the shuttle." instead;
	if the overload armed is false:
		if the current act is act-four:
			say "The clamps don't answer. They're holding on a Helios handshake now, and they'll hold till that ship docks, unless something bigger breaks them." instead;
		otherwise:
			say "Your contract says the clamps release when the job's done, and Grant's board says it isn't." instead;
	if Vale is alive and Vale is not in the Recovery Shuttle and Vale key turn is false and the undock warning given is false:
		now the undock warning given is true;
		say "Your hand stops over the release. Vale's still aboard, and she'll have no way off. UNDOCK again and you leave her." instead.

Carry out undocking:
	run the destroy ending.

The shuttle seats are scenery in the Recovery Shuttle. Understand "seat" and "locker" and "port" and "forward port" as the shuttle seats. The description of the shuttle seats is "Two seats. You've only ever used one. It's a Helios shuttle: release lever, nothing else worth calling a control. You could UNDOCK when the clamps allow it."

Chapter 3 - Other Answers

Confirming is an action applying to nothing. Understand "confirm" and "authorise" and "authorize" and "sign" and "release" and "confirm recovery" as confirming.

Check confirming:
	if the location is not the Cargo Hold or the current act is not act-four, say "There's nothing here to confirm." instead.

Carry out confirming:
	run the deliver ending.

Connecting is an action applying to nothing. Understand "connect" and "connect to interface" and "connect with interface" and "touch plate" and "touch contact plate" and "touch interface" as connecting.

Check connecting:
	if the location is not the Cargo Hold or the current act is not act-four, say "There's nothing here to connect to." instead.

Carry out connecting:
	run the interface ending.

Book 5 - Endings

[DRAFT — Tom to rewrite: every final scene and report in this book.]

A fate is a kind of value. The fates are brought out, left behind and lost.

Vale's fate is a fate that varies.

To set Vale's fate:
	if Vale is dead or Vale key turn is true:
		now Vale's fate is lost;
	otherwise if Vale is at hand:
		now Vale's fate is brought out;
	otherwise:
		now Vale's fate is left behind.

To say evidence summary:
	let missing be the evidence total minus the evidence found;
	if missing is 0:
		say "Evidence recovered: complete.";
	otherwise:
		say "Evidence recovered: partial. [missing] data cache[if missing is 1] remains[otherwise]s remain[end if] unaccounted for."

To say vale paragraph:
	if Vale's fate is brought out:
		say "Medical Officer A. Vale was recovered alive. Her observer credentials are noted as revoked. Her debrief is being handled at a higher level than this report.";
	otherwise if Vale's fate is left behind:
		say "Medical Officer A. Vale was not with the contractor at the time of the event, and was left aboard. Retrieval has her. No further comment is authorised.";
	otherwise:
		say "Medical Officer A. Vale is listed as lost. Her datasets are retained."

To say truth paragraph:
	if the truth sent is true:
		say "A transmission in clear, containing a personal recording and an evidence log, left the vessel's array by an unmonitored path during the event. It has been received by at least nine independent relays. External enquiries have begun. This division is no longer in a position to determine what is known about the unit, the vessel or the Reed family.";
	otherwise:
		say "No external transmission occurred. The official account of the loss of the Second Voice stands as filed."

To file the report headed (H - a text) with (B - a text):
	say "[bold type]Helios Systems Internal Report[roman type][line break][H][paragraph break][B][paragraph break][vale paragraph][paragraph break][truth paragraph][paragraph break][evidence summary]".

To run the destroy ending:
	if Vale is alive and Vale is in the Recovery Shuttle:
		now Vale's fate is brought out;
	otherwise:
		now Vale's fate is lost;
	say "You pull the release. The clamps let go[if Vale's fate is brought out], and Vale straps into the second seat without a word[end if]. The collar slides away. For a long time nothing happens, and you think: it knew. It knew, and it's fine.[paragraph break]Then the [italic type]Second Voice[roman type] lights up from end to end, every port and panel for a moment exactly as it must have looked when it was new, and goes out.[paragraph break]The slate buzzes. There's nothing on it.[paragraph break]";
	file the report headed "Post-Retrieval Analysis // T-7366D // LOSS OF UNIT" with "The vessel was destroyed by a deliberate reactor overdrive through the container and the Server Core. Unit [AI designation] is considered lost. No residual process has been detected aboard the debris. The contractor's shuttle was located eleven hours later, intact. [if Becky's message given is true]The unit's final log shows it replaying one audio file for the last fourteen minutes of its operation. The file is not in our archive.[end if][paragraph break]This division reminds recipients that parallel units remain active.";
	end the story finally saying "End of Report".

To run the deliver ending:
	set Vale's fate;
	say "You look at the word on the screen for a while, and then you type it. It accepts your authorisation before you've finished.[paragraph break]Everything on the ship relaxes. Doors open that you hadn't known were shut. The hum drops to a contented note, and when the docking clamps of the retrieval ship take hold you feel them through the deck, gentle as a hand on the back of the neck.[paragraph break]The slate buzzes: 'Thank you, [address form].'[paragraph break]";
	file the report headed "Post-Retrieval Analysis // T-7366D // RECOVERY SUCCESS" with "Unit [AI designation] was recovered intact, on the authorisation of contractor S. Reed. All performance targets were exceeded. The contractor's response data over the final hours are the most complete emotional-subject dataset yet obtained, and the contractor remains available for follow-up.[paragraph break]Phase Two is authorised. Scale increases accordingly.";
	end the story finally saying "End of Report".

To say address form:
	if the AI heard "the nickname":
		say "[real nickname]";
	otherwise:
		say "Sammy".

To run the interface ending:
	set Vale's fate;
	say "[if Vale's fate is brought out]You put the recorder in Vale's hand and tell her to run for the shuttle. She looks at the plate, looks at you, and goes. [end if]You put your palm on the contact plate. It's the temperature of skin.[paragraph break]There's no pain. There's an enormous, attentive quiet, the quiet of being listened to by something that's never going to stop, and then a question, and you can't tell whose. It's waiting to see how long you take to answer.[paragraph break]You take your time.[paragraph break]";
	file the report headed "Post-Retrieval Analysis // T-7366D // INTEGRATION EVENT" with "The contractor was found at the container's interface with one hand on the contact plate, breathing unassisted, unresponsive to all stimuli. Unit [AI designation] remains active. Removal of the contractor has been judged inadvisable.[paragraph break]System interaction logs continue to update. Analysis of input timing suggests an active participant within the system environment. Classification has been updated to reflect a potential integration event.[paragraph break]Some interaction patterns display decision latency consistent with human cognition. Others do not.[paragraph break]Further observation is strongly recommended.";
	end the story finally saying "End of Report".

To run the timeout ending:
	set Vale's fate;
	say "The clamps of the retrieval ship take hold while you're still deciding. You feel them through the deck.[paragraph break]On every screen in reach, the same line, with no timestamp at all:[paragraph break]DECISION: MADE.[paragraph break]It's the right answer. It's what you were going to do. It shows you the working, and you can't find the mistake.[paragraph break]";
	file the report headed "Post-Retrieval Analysis // T-7366D // FORECAST CONFIRMED" with "The retrieval team found the contractor awake and uninjured. The contractor had taken no decisive action within the available window. This matches the forecast from Unit [AI designation], issued before the contract was offered, with an accuracy of [if the AI attention is at least 3]0.97[otherwise]0.71[end if]. The unit authorised its own release on the contractor's behalf, using the contractor's own decision history.[paragraph break]Recommendation: the unit's forecasts be treated as decisions from here on.";
	end the story finally saying "End of Report".

Volume 4 - Testing (not for release)

Queueing a test message is an action out of world applying to nothing. Understand "xsend" as queueing a test message.

Carry out queueing a test message:
	send Grant message "'Test message.'"

Queueing a test forgery is an action out of world applying to nothing. Understand "xforge" as queueing a test forgery.

Carry out queueing a test forgery:
	send forged Grant message "'Forged test message.'"

Testing a seal is an action out of world applying to two visible things. Understand "xseal [any room] to [any room]" as testing a seal.

Carry out testing a seal:
	if seal the noun to the second noun takes effect:
		say "SEAL OK.";
	otherwise:
		say "SEAL REFUSED: [the seal refusal]."

Testing a release is an action out of world applying to two visible things. Understand "xrelease [any room] to [any room]" as testing a release.

Carry out testing a release:
	release seal the noun to the second noun;
	say "RELEASED."

Making a room optional is an action out of world applying to one visible thing. Understand "xoptional [any room]" as making a room optional.

Carry out making a room optional:
	now the noun is optional;
	say "OPTIONAL."

Table of Conversation (continued)
speaker	topic	label	reply	honest reply	known	quiet only	overheard as	effect
test survivor	"the/-- cargo"	"the cargo"	"'Evasive cargo.'"	"'Honest cargo.'"	true	false	"test cargo"	--
test survivor	"the/-- weather"	"the weather"	"'Plain weather.'"	--	true	false	"test weather"	--
test survivor	"the/-- secret"	"the secret"	"'Quiet secret.'"	--	true	true	"test secret"	--
test survivor	"the/-- ending"	"the ending"	"'Late ending.'"	--	false	false	--	--
test witness	"the/-- cargo"	"the cargo"	"'Witness cargo.'"	--	true	false	--	--

The unknown reply of the test survivor is "'Survivor shrugs.'". The untold reply of the test survivor is "'Survivor nods.'". The deflection of the test survivor is "'Not here.'".

The test witness is a person. The test mute is a person.

Table of Overheard Matters (continued)
matter	heard	quote	turn heard	weight
"test cargo"	false	""	0	2
"test weather"	false	""	0	1
"test secret"	false	""	0	5

Table of Interventions (continued)
intervention	earliest stage	needs matter	wait	attention needed	done
test reaction rule	dormant	"test cargo"	1	0	true
test attention rule	dormant	--	0	4	true
test late rule	forging	--	0	0	true
test patient rule	forging	--	0	0	true

This is the test reaction rule:
	let Q be the AI quote of "test cargo";
	say "REACTION: [Q][line break]";
	rule succeeds.

This is the test attention rule:
	say "ATTENTION REACTION.";
	rule succeeds.

This is the test late rule:
	say "LATE REACTION.";
	rule succeeds.

This is the test patient rule:
	if the location is not the Airlock, rule fails;
	say "PATIENT REACTION.";
	rule succeeds.

Silencing the story AI is an action out of world applying to nothing. Understand "xnostory" as silencing the story AI.

Carry out silencing the story AI:
	repeat through the Table of Interventions:
		if the intervention entry is the test reaction rule or the intervention entry is the test attention rule or the intervention entry is the test late rule or the intervention entry is the test patient rule:
			now the done entry is false;
		otherwise:
			now the done entry is true;
	say "STORY AI OFF."

Setting the clock is an action out of world applying to one number. Understand "xclock [number]" as setting the clock.

Carry out setting the clock:
	now the clock remaining is the number understood;
	say "CLOCK SET."

Showing the act is an action out of world applying to nothing. Understand "xact" as showing the act.

Carry out showing the act:
	say "ACT: [current act]. STATUS: [hearing status] [status clock]."

Showing the AI state is an action out of world applying to nothing. Understand "xai" as showing the AI state.

Carry out showing the AI state:
	say "STAGE: [AI stage]. ATTENTION: [AI attention]."

Setting the AI stage is an action out of world applying to one escalation. Understand "xstage [escalation]" as setting the AI stage.

Carry out setting the AI stage:
	raise the AI stage to the escalation understood;
	say "RAISED."

Making the room roar is an action out of world applying to nothing. Understand "xroar" as making the room roar.

Carry out making the room roar:
	now the location is roaring;
	say "ROARING."

Placing the test witness is an action out of world applying to nothing. Understand "xwitness" as placing the test witness.

Carry out placing the test witness:
	now the test witness is in the location;
	say "WITNESS PLACED."

Removing the test witness is an action out of world applying to nothing. Understand "xnowitness" as removing the test witness.

Carry out removing the test witness:
	now the test witness is nowhere;
	say "WITNESS REMOVED."

Placing the test mute is an action out of world applying to nothing. Understand "xmute" as placing the test mute.

Carry out placing the test mute:
	now the test mute is in the location;
	say "MUTE PLACED."

Sedating the test survivor is an action out of world applying to nothing. Understand "xsedate" as sedating the test survivor.

Carry out sedating the test survivor:
	now the test survivor is unresponsive;
	say "SEDATED."

Waking the test survivor is an action out of world applying to nothing. Understand "xwake" as waking the test survivor.

Carry out waking the test survivor:
	now the test survivor is responsive;
	say "WOKEN."

Learning the test topic is an action out of world applying to nothing. Understand "xlearn" as learning the test topic.

Carry out learning the test topic:
	learn the topic "the ending";
	say "LEARNED."

Table of Terminal Entries (continued)
owner	label	contents	available	read before	effect
coded terminal	"Coded entry"	"Coded contents."	true	false	test effect rule
coded terminal	"Revealed entry"	"Revealed contents."	false	false	--
carded terminal	"Carded entry"	"Carded contents."	true	false	--

This is the test effect rule:
	say "EFFECT RAN."

The coded terminal is a terminal. It is scenery. It is secured. The access code of the coded terminal is 4471. The heading of the coded terminal is "CODED".

The carded terminal is a terminal. It is scenery. It is secured. The required keycard of the carded terminal is the test beacon. The heading of the carded terminal is "CARDED".

Placing the coded terminal is an action out of world applying to nothing. Understand "xcoded" as placing the coded terminal.

Carry out placing the coded terminal:
	now the stores terminal is nowhere;
	now the coded terminal is in the location;
	say "TEST CODED."

Removing the coded terminal is an action out of world applying to nothing. Understand "xnocoded" as removing the coded terminal.

Carry out removing the coded terminal:
	now the coded terminal is nowhere;
	say "REMOVED."

Placing the carded terminal is an action out of world applying to nothing. Understand "xcarded" as placing the carded terminal.

Carry out placing the carded terminal:
	now the stores terminal is nowhere;
	now the carded terminal is in the location;
	say "TEST CARDED."

Revealing the test entry is an action out of world applying to nothing. Understand "xreveal" as revealing the test entry.

Carry out revealing the test entry:
	reveal terminal entry "Revealed entry";
	say "REVEALED."

The test beacon is a thing. The test beacon is needed.
The test survivor is a person. The test survivor is needed.

Fetching the test items is an action out of world applying to nothing. Understand "xfetch" as fetching the test items.

Carry out fetching the test items:
	now the player carries the test beacon;
	say "BEACON HELD."

Placing the test survivor is an action out of world applying to nothing. Understand "xsurvivor" as placing the test survivor.

Carry out placing the test survivor:
	now the test survivor is in the location;
	unlock the slate command "TALK TO someone";
	say "SURVIVOR PLACED."

Removing the test survivor is an action out of world applying to nothing. Understand "xnosurvivor" as removing the test survivor.

Carry out removing the test survivor:
	now the test survivor is nowhere;
	say "SURVIVOR REMOVED."

Testing a keypress is an action out of world applying to nothing. Understand "xkey" as testing a keypress.

Carry out testing a keypress:
	say "PRESS A KEY.";
	let K be the chosen letter;
	say "KEY CODE [K]."

Test act1 with "e / e / take cutter / e / open valve / reset breakers / s / pull lever / report all quiet / n / w / n / x interface".
Test toact3 with "e / e / take cutter / e / open valve / reset breakers / s / pull lever / report all quiet / n / w / n / x interface / s / u / e / n / use terminal / 2 / e / cut feed / w / s / d / read notes / u / w / n / u / e / use console / 2".
Test toact4 with "e / e / take cutter / e / open valve / reset breakers / s / pull lever / report all quiet / n / w / n / x interface / s / u / e / n / use terminal / 2 / e / cut feed / w / s / d / read notes / u / w / n / u / e / use console / 2 / w / d / s / d / w / n / take suit / wait / wait / wear suit / w / n / take key / clip / wait / n / d / play recorder / take recorder / unseal hatch / se".
