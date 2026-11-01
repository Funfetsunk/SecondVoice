"Second Voice" by Thomas Evans

Use no scoring.

The story genre is "Science Fiction".

Volume 1 - Framework

Book 1 - Quiet Zones

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

To unlock the slate command (U - a text):
	choose the row with a usage of U in the Table of Slate Commands;
	now the available entry is true.

To say slate guide:
	say "[if signal is available]SIGNAL: CH-4[otherwise]NO SIGNAL[end if][line break]";
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
	now the right hand status line is "[clock the time of day]".

Chapter 3 - Messages

Table of Slate Messages
stamp (a time)	body (a text)	forged (a truth state)	delivered (a truth state)
with 40 blank rows.

To send Grant message (T - a text):
	choose a blank row in the Table of Slate Messages;
	now the stamp entry is the time of day;
	now the body entry is T;
	now the forged entry is false;
	now the delivered entry is false.

To send forged Grant message (T - a text):
	send Grant message T;
	repeat through the Table of Slate Messages:
		if the body entry is T and the delivered entry is false:
			now the forged entry is true.

To say message stamped (T - a time) reading (B - a text):
	say "HELIOS OPS // GRANT // CH-4 // [clock T][line break][B]".

To deliver waiting messages:
	repeat through the Table of Slate Messages:
		if the delivered entry is false:
			if the forged entry is true:
				now the stamp entry is 1 minute after the time of day;
			now the delivered entry is true;
			say "The slate buzzes.[paragraph break][message stamped the stamp entry reading the body entry][paragraph break]".

Every turn when signal is available:
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
			say "[message stamped the stamp entry reading the body entry][paragraph break]";
	if shown is false, say "No messages."

Chapter 4 - Evidence Log

Table of Evidence
source (an object)	entry (a text)	reveals (a text)	found (a truth state)
scratched warning	"Scratched beside the outer airlock hatch: DON'T LET IT HEAR YOU."	"the warning"	false
suit rack	"Airlock suit rack: three EVA suits missing. Tags VOSS, MERCER, KEST."	"the crew"	false
shipping container	"Cargo container drawing power with the ship otherwise barely awake."	"the container"	false

To log evidence from (O - an object):
	if O is a source listed in the Table of Evidence:
		if the found entry is false:
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

A goal is a kind of value. The goals are boarding, reaching engineering, restoring systems, restarting the reactor, giving a report, reaching the hold and reading the interface.

Table of Hints
goal	first hint	second hint	third hint	nudge	shown (a number)	nudged (a truth state)
boarding	"You came here to board the ship."	"The airlock is the only way in from the shuttle."	"Go east."	"'Airlock's east of you. Whenever you're ready.'"	0	false
reaching engineering	"The ship has no power. Find out why."	"Engineering is on this deck, past the Storage Bay."	"From the Airlock go east, then east again."	"'Engineering is east of the Storage Bay.'"	0	false
restoring systems	"Two systems in Engineering must be ready before a restart."	"Look at the coolant valve and the breaker panel."	"OPEN VALVE and RESET BREAKERS."	"'Coolant and breakers first. Both in Engineering.'"	0	false
restarting the reactor	"Coolant and breakers are ready. The restart itself is manual."	"Reactor Control is south of Engineering."	"Go to Reactor Control and PULL LEVER."	"'Manual restart. Reactor Control, south of Engineering.'"	0	false
giving a report	"Grant wants a status report, out loud."	"The slate's microphone needs a signal to reach him."	"Somewhere with signal, type REPORT, or REPORT followed by what you want to say."	"'Still waiting on that report, Sam.'"	0	false
reaching the hold	"Grant wants you in the Cargo Hold."	"The Cargo Hold is north of the Storage Bay."	"Go to the Storage Bay, then go north."	"'Cargo Hold, north of the Storage Bay.'"	0	false
reading the interface	"The container has woken up. It has an interface."	"Read what the interface says."	"EXAMINE INTERFACE."	"'What's the interface say?'"	0	false

To decide which goal is the current goal:
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
	increase the shown entry by 1;
	if the shown entry is 1:
		say "[first hint entry][line break]";
	otherwise if the shown entry is 2:
		say "[second hint entry][line break]";
	otherwise:
		say "[third hint entry][line break]".

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

To say Grant out of reach:
	say "NO SIGNAL. Grant can't reach you here, and you can't reach him."

Before doing something to Grant when signal is lost:
	if we are examining Grant, continue the action;
	say "[Grant out of reach]" instead.

Instead of taking or touching or attacking or kissing or pushing or pulling Grant:
	say "He's a voice on a channel, nowhere you can reach."

Table of Conversation
speaker (a person)	topic	label (a text)	reply (a text)	honest reply (a text)	known (a truth state)	quiet only (a truth state)	overheard as (a text)
Grant	"the/-- cargo/manifest/container/box/shipment/unit"	"the container"	"'Sealed Helios property. Recover it, don't open it. That's the contract.'"	--	false	false	--
Grant	"the/-- ship/transport/second/voice"	"the ship"	"'Transport. Went silent in transit. Your job is to find out why.'"	--	true	false	--
Grant	"the/-- crew/voss/mercer/kest/vale/suits/suit"	"the crew"	"'I've got a manifest and no answers. Three suits gone, you say? Noted.'"	--	false	false	--
Grant	"becky/reed/rebecca/sister"	"Reed"	"'Comms Officer Reed is on the manifest. Status unknown, same as the rest.'"	--	true	false	--
Grant	"the/-- helios/contract/job/company"	"the contract"	"'Standard recovery terms. Above my pay grade, most of it.'"	--	true	false	--
Grant	"the/-- warning/scratches/scratch/hatch/hear/symbol"	"the warning"	"'Scratched by who? Log it. Probably nothing.' He doesn't sound sure."	--	false	false	--
Grant	"the/-- power/reactor/coolant/breakers"	"power"	"[if the ship has power]'Reactor's up and holding on my board. Stick to the job.'[otherwise]'Prime coolant, reset breakers, then a manual restart. I'll talk you through it.'[end if]"	--	true	false	--

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
	if the noun is Grant and signal is lost, say "[Grant out of reach]" instead;
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
	if T is "status":
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

Book 7 - Act 4 Clock

Book 8 - Parser Interference

Book 9 - Door Sealing

[One system for scripted beats and Act 4 pre-emption. A seal only takes effect if the ship stays winnable from where Sam is: see DESIGN.md 4.10. Add a row here when a sealable door's rooms are built, and keep tools/check-map.mjs in step.]

Table of Sealable Doors
near	way	sealed
Airlock	east	false
Storage Bay	north	false
Storage Bay	east	false

A thing can be needed or unneeded. A thing is usually unneeded.

A room can be required or optional. A room is usually optional.

A room can be charted or uncharted.

The seal refusal is a text that varies.

To decide whether exit (D - a direction) of (R - a room) is closed:
	repeat through the Table of Closed Exits:
		if the place entry is R and the way entry is D, decide yes;
	decide no.

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
					now N is charted;
					now growing is true.

To decide whether the ship stays winnable:
	chart the ship from the location;
	if the Recovery Shuttle is uncharted:
		now the seal refusal is "cuts Sam off from the Shuttle";
		decide no;
	repeat with R running through required rooms:
		if R is uncharted:
			now the seal refusal is "cuts off a required room";
			decide no;
	repeat with T running through needed things:
		let P be the location of T;
		if P is not nothing and P is uncharted:
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

[Act 1 only. Rooms beyond these exits arrive with Act 2 and Act 3: remove each row when its room is built.]

Table of Closed Exits
place	way	refusal
Airlock	north	"[one of]You reach for the EVA Prep hatch. 'ACCESS DENIED' appears on its panel before your hand touches it.[or]'ACCESS DENIED' again. It was waiting this time.[stopping]"
Storage Bay	up	"The ladder hatch to the central deck is locked down. Its panel is dead."
Engineering	up	"A maintenance grille, bolted tight. You've nothing to cut it with."
Cargo Hold	up	"The gantry ladder has been drawn up and locked out of reach."
Cargo Hold	west	"The hatch to EVA Prep is locked from the far side."

Before going:
	if the location is a place listed in the Table of Closed Exits:
		repeat through the Table of Closed Exits:
			if the place entry is the location and the way entry is the noun:
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

The stores terminal is a terminal in the Storage Bay. It is scenery. The heading of the stores terminal is "STORES // SECOND VOICE". The scan reading of the stores terminal is "Local stores system. Last login: KEST."

Engineering is east of the Storage Bay. "Pipework and cable trays. The coolant valve and the breaker panel are the only things here that look recently touched. Reactor Control lies south, the Storage Bay west. A maintenance grille is set high in the wall above you."

The maintenance grille is scenery in Engineering. The description of the maintenance grille is "Bolted from this side. Beside it, scratched into the paint, is a circle with a line through it."

Engineering and Reactor Control and the Cargo Hold are required.

Reactor Control is south of Engineering. "A narrow room built around one heavy restart lever. Engineering is north."

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

Book 4 - Command Deck

Book 5 - Exterior

Volume 3 - Story

Book 1 - Opening

[DRAFT — Tom to rewrite: the fake message below.]

When play begins:
	say "FROM: R. REED // TRANSPORT SECOND VOICE // COMMS[paragraph break]Sammy,[paragraph break]All fine out here. The comms have been patchy but it's nothing to worry about. Eat something. Get some sleep. I'll call as soon as we're back in range.[paragraph break]Take care of yourself.[line break]B.[paragraph break]She never called you that.[paragraph break]Six days later the ship has stopped answering, and Helios Systems has offered you a recovery contract nobody else was asked to bid on.[paragraph break]";
	send Grant message "'This is Grant, Helios ops. You're docked. The slate in your hand is your scanner, your evidence log and me. Airlock's east. Ship has no power, so that's first.'".

Book 2 - Act 1

The shipping container is scenery in the Cargo Hold. Understand "box" and "cargo" and "crate" as the shipping container. The description of the shipping container is "Helios seals on every seam. [if the ship has power]Its interface is lit.[otherwise]No lights, no markings, no manifest plate.[end if]". The scan reading of the shipping container is "[if the ship has power]Drawing far more power than a sealed crate should.[otherwise]Inert. Mass reading higher than a crate this size should show.[end if]".

The interface is scenery in the Cargo Hold. Understand "screen" and "readout" as the interface. The description of the interface is "[if the ship has power]The readout is waiting.[otherwise]Dark.[end if]".

Instead of examining the interface when the ship has power:
	if Sam has not reported, have the AI hear "the report" quoting "Yes. I'm here";
	force the intervention the echo rule;
	say "The interface reads:[paragraph break]STATUS: ACTIVE[line break]OBSERVATION: IN PROGRESS[line break]SUBJECT COUNT: 2[paragraph break]Two.[paragraph break]You boarded alone.";
	end the story finally saying "End of Act 1".

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
speaker	topic	label	reply	honest reply	known	quiet only	overheard as
test survivor	"the/-- cargo"	"the cargo"	"'Evasive cargo.'"	"'Honest cargo.'"	true	false	"test cargo"
test survivor	"the/-- weather"	"the weather"	"'Plain weather.'"	--	true	false	"test weather"
test survivor	"the/-- secret"	"the secret"	"'Quiet secret.'"	--	true	true	"test secret"
test survivor	"the/-- ending"	"the ending"	"'Late ending.'"	--	false	false	--
test witness	"the/-- cargo"	"the cargo"	"'Witness cargo.'"	--	true	false	--

The unknown reply of the test survivor is "'Survivor shrugs.'". The untold reply of the test survivor is "'Survivor nods.'". The deflection of the test survivor is "'Not here.'".

The test witness is a person. The test mute is a person.

Table of Overheard Matters (continued)
matter	heard	quote	turn heard	weight
"test cargo"	false	""	0	2
"test weather"	false	""	0	1
"test secret"	false	""	0	5

Table of Interventions (continued)
intervention	earliest stage	needs matter	wait	attention needed	done
test reaction rule	dormant	"test cargo"	1	0	false
test attention rule	dormant	--	0	4	false
test late rule	forging	--	0	0	false
test patient rule	forging	--	0	0	false

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

Include Basic Screen Effects by Emily Short.

Testing a keypress is an action out of world applying to nothing. Understand "xkey" as testing a keypress.

Carry out testing a keypress:
	say "PRESS A KEY.";
	let K be the chosen letter;
	say "KEY CODE [K]."

Test act1 with "e / e / e / open valve / reset breakers / s / pull lever / report all quiet / n / w / n / x interface".
