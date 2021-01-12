
//Quarks.install("https://github.com/shimpe/panola");
//LanguageConfig.includePaths

var extmidi = 1; // if set to 1, external synth will be used instead of internal synth
var variations = ();
var note, aspat, lhs, rhs, kick, lotom, cymb, perc01, hihat, hiwood, lowood;
var tc = TempoClock(126.0/60.0);
var rvol = 0.4, lvol = 0.5;
var lhs_pan, rhs_pan, lhs_notes, lhs_durations, rhs_notes, rhs_durations, l, r;
var transformers = (
		\safeReg : {
			| self, name, implementation, verbose=0 |
			var symbolicname = name.asSymbol;
			if (self.respondsTo(symbolicname)) {
				("Error! Registering" + "\\" ++ symbolicname + "would overwrite a member that exists already.").postln;
			} {
				if (self.keys.includes(symbolicname)) {
					("Error! Cannot register" + "\\" ++ symbolicname + "twice.").postln;
				} {
					if (verbose != 0) {
						("Registered" + "\\" ++ symbolicname ++ ".").postln;
					};
					self[symbolicname] = implementation;
				};
			};
	};);


if (MIDIClient.initialized.not) { MIDIClient.init; }; ~midiout = MIDIOut(0); ~midiout.connect(1);

lhs_pan = Panola("(g2_4 c3_2 b2_4 g2_1)*8");
rhs_pan = Panola("(b4_4 c5_4 b4_4 c5_8 d5_4.666 c5_4 b4_4 c5_4 b4_4 c5_4 b4_8 c5_4 g4_1 g4_8)*4");
//lhs_pan = Panola("(f2_8*3 f2_8*3 f2_8*2 g2_8*3 g2_8*3 e2_8 g2_8 a2_8*3 a2_8*3 a2_8*2 a2_8*2 a2_8 a2_8*2 a2_8 b2_8 c3_8)*4");
lhs_notes = lhs_pan.midinotePattern.asStream.all;
lhs_durations = (lhs_pan.durationPattern.asStream.all*4);
rhs_notes = rhs_pan.midinotePattern.asStream.all;
rhs_durations = (rhs_pan.durationPattern.asStream.all*4);
l = [lhs_notes, lhs_durations];
r = [rhs_notes, rhs_durations];

transformers.safeReg(\nop, {
		// transformers replace list of notes and durations with a new list of notes and durations
		| self, notes_durs |
		notes_durs;
	});
	transformers.safeReg(\spray, {
		| self, notes_durs, allowed_embellishments=nil |
		var newnotes = [], newdurs = [];
		var oldnotes = notes_durs[0];
		var olddurs = notes_durs[1];
		if (allowed_embellishments.isNil) {
			allowed_embellishments = [-12,0,12];
		};
		oldnotes.do {
			| note, idx |
			var no_of_new_notes = 7.rrand(1);
			no_of_new_notes.do {
				var helper = allowed_embellishments;
				var extendedhelper = helper;
				newnotes = newnotes ++ (note + extendedhelper.choose);
				newdurs = newdurs ++ (olddurs[idx] / no_of_new_notes);
			};
		};
		[newnotes, newdurs];
	});
	transformers.safeReg(\interpolate, {
		| self, notes_durs |
		var newnotes = [], newdurs = [];
		var oldnotes = notes_durs[0];
		var olddurs = notes_durs[1];
		oldnotes.doAdjacentPairs{
			| el1, el2, idx |
			var no_of_new_notes = 5.rrand(1);
			var interpolnotes = [];
			no_of_new_notes.do({
				|idx|
				var helper = idx.linlin(0, no_of_new_notes, el1, el2).asInteger;
				interpolnotes = interpolnotes ++ helper;
			});
			newnotes = newnotes ++ el1 ++ interpolnotes;
			newdurs = newdurs ++ ((olddurs[idx]/(interpolnotes.size+1))!(interpolnotes.size+1));
		};
		newnotes = newnotes ++ oldnotes.last;
		newdurs = newdurs ++ olddurs.last;
		[newnotes, newdurs];
	});
	transformers.safeReg(\inv, { // !! don't use \invert
		| self, notes_durs, around |
		var oldnotes;
		var olddurs;
		var newnotes;
		oldnotes = notes_durs[0];
		olddurs = notes_durs[1];
		newnotes = (oldnotes - around).neg + around;
		[newnotes, olddurs];
	});
	transformers.safeReg(\retrograde, {
		| self, notes_durs |
		[notes_durs[0].reverse, notes_durs[1]];
	});
	transformers.safeReg(\retrograde_all, {
		| self, notes_durs |
		[notes_durs[0].reverse, notes_durs[1].reverse];
	});
	transformers.safeReg(\invert_retrograde, {
		| self, notes_durs, around |
		self.retrograde(self.inv(notes_durs, around));
	});
	transformers.safeReg(\arp, {
		| self, notes_durs, octaves=#[0,1] |
		var newnotes = [], newdurs = [];
		var oldnotes = notes_durs[0];
		var olddurs = notes_durs[1];
		oldnotes.doAdjacentPairs {
			| el1, el2, idx |
			octaves.do {
				| octave, i |
				newnotes = newnotes ++ (el1 + (octave*12)) ++ (el2 + (octave*12));
				newdurs = newdurs ++ ((olddurs[idx]/(2*octaves.size))!2);
			};
		};
		newnotes = newnotes ++ oldnotes.last;
		newdurs = newdurs ++ olddurs.last;
		[newnotes, newdurs];
	});


note = {
        |notename|
        Panola(notename).midinotePattern.asStream.first;
};

aspat = {
                | notes_durations, midi=0, midichan=0, volume=0.8 |
	              if (midi!=0) {
                        Pbind(
                                \type, \midi,
                                \midicmd, \noteOn,
                                \midiout, ~midiout,
                                \chan, midichan,
                                \midinote, Pseq(notes_durations[0], 1),
                                \dur, Pseq(notes_durations[1], 1),
                                \amp, Pseq([volume], inf),
                                \legato, Pseq([0.9], inf)
                        );
                } {
                        Pbind(
                                \instrument, \default,
                                \midinote, Pseq(notes_durations[0], 1),
                                \dur, Pseq(notes_durations[1], 1),
                                \amp, Pseq([volume], inf),
                                \legato, Pseq([0.9], inf)
                        );
                };
        };

lhs = aspat.(l, extmidi, 0, lvol);
rhs = aspat.(r, extmidi, 1, rvol);

kick = Pn(aspat.([[41,0,0,0],[1,1,1,1]], extmidi, 9, 0.5), 8);
// kick = Pn(aspat.([[41,0,0,41,41,41], [1,1,10.5,0.5,1]], extmidi, 9, 0.5), 2); //14 length

hihat = Pn(aspat.([[44,0,0,44,44],[1,1,1,0.5,0.5]], extmidi, 9, 0.5), 7); // 4 length

//lotom = Pn(aspat.([[0,43,43,43],[4,0.33,0.33,0.33]], extmidi, 9, 0.5), inf);

cymb = Pn(aspat.([[0,51,51,51,51],[1,1,0.5,0.5,0.5]], extmidi, 9, 0.5), 8); //3.5 length

hiwood = Pn(aspat.([[76,76,77,77,76,76,76,77,77,76,76,77,77,76,0],[0.5,0.5,0.5,0.25,0.5,0.5,0.25,0.5,0.5,0.5,0.5,0.5,0.25,0.5,1.75]], extmidi, 9, 0.5), 4); //14 length

variations = ();

variations[\1] = Ppar([kick, hihat, cymb]);
//variations[\2] = Ppar([kick, hihat,cymb, hiwood]);
variations[\2] = Ppar([lhs, hihat]);
variations[\3] = Ppar([lhs, rhs, hihat, kick, cymb]);
variations[\4] = Ppar([
	lhs, hihat, kick, cymb,
	aspat.(transformers.invert_retrograde(r), extmidi, 1, rvol)
]);

~player = Pspawner{
                |sp|
                sp.wait(thisThread.clock.elapsedBeats - thisThread.clock.beats); // allow logical time to catch up with physical time, see http://doc.sccode.org/Guides/ServerTiming.html
                sp.par(
                        Pseq([
			Pseq([variations[\4]], 1),
                                Pfunc { sp.suspendAll; }
                ], 1));
        }.play(tc);