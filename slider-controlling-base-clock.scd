
//first run this: move cursor before the first bracket and hit cmd+enter
(~listener = {|msg, time, replyAddr, recvPort|
	if (msg[0].asString.contains("/hello/from/oscjs"), {
		// Log all received messages to the console.
		("Message received on port" + recvPort + "from " + replyAddr.ip + ":" + replyAddr.port + ":" + msg).postln;
		msg[1].postln;
		msg[2].postln;
		i.bass.clock=msg[1];
		i.kick.clock=msg[2];
	});
};

thisProcess.addOSCRecvFunc(~listener);)


//then run this  move cursor before the round bracket in line 18 and press cmd+enter
(
s.options.memSize=2048*1024;
s.options.maxNodes=128*1024;
s.boot;
i=INSTRUMENT();

i = INSTRUMENT().play;


i.kick="kick";
i.kick.seq("1 0.3 0.75 2");


i.bass=i.synths.trance.choose;
i.bass.note = "C3 Db3   C4 C3  :1.5  Db3x2  :1/2   Bb2x2  ";
i.bass.clock=6;)


// to stop listener run this
thisProcess.removeOSCRecvFunc(~listener);

// to stop sound run this:
(
i.bass.stop;
i.kick.stop;
i.hihat.stop;
)

(
i=INSTRUMENT().play;

i.bass=i.synths.trance.choose;


i.bass.note("0 2 3 7");
i.bass.note("C D Eb G");

i.bass.octave=4;
i.bass.octave=3;
i.bass.octave=5;
)

(
i=INSTRUMENT().play;
i.kick.seq("1x4 :0.5 1x8 :0.25 1x16 :0.125 1x32");
)


(


i = INSTRUMENT().play;

i.drums = (
	kick: 'kick',
	hihat: 'hihat',
	clap: 'clap'
);

i.drums.kick.seq("1");
i.drums.hihat.seq(" 1").speed(2);
i.drums.clap.seq(" 1");

i.drums.clock = 1.5;


)

(
i=INSTRUMENT().play;
c = 1.5;
// i.kick=i.synths.kick[2]; <-- good one!

//i.kick=i.synths.rhodes2; <-- nice lead
i.kick=i.synths.kick.kickDeep; // <-- good one
i.hats=i.synths.hihatdist;
i.hats.amp=0.1;
//i.kick=i.synths.kick.kickDamp;  // <-- nice too

//i.kick=i.synths.kick.kick_808;
i.kick.clock=c;
i.hats.clock=c;
d.postln;

d[0] = ["1        1       ","    1        1   "];
d[1] = ["1    1    1    1   ","   1   1     1   1 "];
d[2] = ["1   1 1   1    1 1   ","  1    1    1    1 "];
d[3] = ["1   1 1  1  1   1 1   ","  1   1  1   1   1 1 "];

d[0];

/*
i.kick.seq(d[0].asString);
i.hats.seq(d[0].asString);
*/
/*
i.kick[0].seq("1        1       ");
i.hats[0].seq("    1        1   ");
i.kick[1].seq("1    1    1    1   "):
i.hats[1].seq("   1   1     1   1 ");
i.kick[2].seq("1   1 1   1    1 1   ");
i.hats[2].seq("  1    1    1    1 ");
i.kick[3].seq("1   1 1  1  1   1 1   ");
i.hats[3].seq("  1   1  1   1   1 1 ");
*/

//i.kick[1].seq("1xx   1xxx ").speed(1);
//i.kick[2].seq("1   1xx   1x2   1x4 ").speed(1);


/*

)

(
i=INSTRUMENT().play;
*/
i.piano=i.synths.piano;

i.voices=(
		v1:i.synths.piano[\rhodey_sc],
		v2:i.synths.piano[\rhodey_sc],
		v3:i.synths.piano[\rhodey_sc],
		v4:i.synths.piano[\rhodey_sc]
	);

i.voices.clock=c*4;
i.voices.amp=0.1;

/*i.piano.amp=4;
i.piano.clock=2;
i.piano.note("0 7 9 5");*/
z = ["","","",""];

c=[C(0,\M).chord,C(7,\M).chord,C(9,\m).chord,C(5,\M).chord];

//most basic one (1/5)
p[0] = [
	c[0]," ", " "," "," "," "," "," ",
	c[1]," ", " "," "," "," "," "," ",
	c[2]," ", " "," "," "," "," "," ",
	c[3]," ", " "," "," "," "," "];


// little bit more complex (2/5)
p[1] = [
	c[0]," ", " "," "," ",c[0]," "," ",
	c[1]," ", " "," "," ",c[1]," "," ",
	c[2]," ", " "," "," ",c[2]," "," ",
	c[3]," ", " "," "," ",c[1]," "];



// 3/5 complex
p[2] = [
	c[0]," ", " "," "," ",c[0]," ",c[0],
	c[1]," ", " "," "," ",c[1]," ",c[1],
	c[2]," ", " "," "," ",c[2]," ",c[2],
	c[3]," ", " "," "," ",c[3]," ",c[1]];

p[3] = [
	c[0]," ", " ",c[0]," ",c[0]," ",c[0],
	c[1]," ", " ",c[1]," ",c[1]," ",c[1],
	c[2]," ", " ",c[2]," ",c[2]," ",c[2],
	c[3]," ", " ",c[3]," ",c[3]," ",c[1]];

p[4] = [
//  1   ,   ,   ,   ,2  ,   ,    ,   ,3   ,   ,   ,   ,4  ,    ,    ,
	c[0]," "," "," "," "," ",c[0]," "," ", " ",c[0]," "," ", " ",c[1]," ",
	" "," ",c[1]," "," "," ",c[1]," ",c[1]," ", " "," ",c[1]," "," "," ",
	c[2]," "," "," "," "," ", " ",c[2], " "," "," ", " ",c[2]," "," ", " "," ",c[3]," ",
	" "," "," ",c[3]," "," "," "," ",c[3]," "," ",c[3]," "," ", " "," ",c[1]," "," "," "];

s = { arg p; var q = ["","","",""];
p[4].do(
	{arg item, i;
			item.isString.postln;
			if(item.isString, {[1,2,3,4].do({arg test, b;
				q[b] = q[b] ++ " ";})} ,
			{item.do({arg jtem, a;
					q[a] = q[a] ++ jtem.asString ++ if(i<(p.size-1)," ","")})})
}); q};
z = s.value(p);

z[0].postln;
z[1].postln;
z[2].postln;
z[3].postln;

i.voices.v1.note(z[0]);
i.voices.v2.note(z[1]);
i.voices.v3.note(z[2]);
i.voices.v4.note(z[3]);
/*
i.voices.v1.note("0  7  9  5 ");
i.voices.v2.note("4  11  12  9 ");
i.voices.v3.note("7  14  16  12 ");
i.voices.v4.note("12  19  21  17 ");
*/
)
(
	n = " ";
	n= [" ", " ", " ", " "];
	n.do({arg bbb, b;
		(b + ":" +bbb.asString).postln;})
)
List[ 1, 2, 3, 4, 5 ].scramble.postln;
i.synths.browse;
(
i=INSTRUMENT().play;
i.piano=i.synths.piano;

	i.piano.seq([
		C(0,\m),
		C(1,\M,0,[16]),
].asString);

	i.notes[1].chord([
		C(0,\m),
		C(3,\sus2),
		C(2,\dim),
		C(7,\M)
	]).speed(1/2).do(3);


)



SynthDescLib.global.browse;


(
	i=INSTRUMENT().play;

	i.piano=i.synths.piano[1];
i.piano.chord([C(0,\m), C(3,\sus2), C(2,\dim), C(7,\M)]).random().mirror.speed(2);
    /*i.piano.chord([
		C(0,\m),
		C(3,\sus2),
		C(2,\dim),
		C(7,\M)
	]).speed(1/2).do(3); */
	i.piano.octave=4;

i.piano.seq(\chord, "C(0,\m), C(3,\sus2)").do(3).speed(2);
)


i = INSTRUMENT().play;
i.melodies=(
	note1: i.synths.note.dist[0],
	note2: i.synths.note.dist[1]
);

i.melodies.note1.note("0 7  8");
i.melodies.note2.note("12  15 13");

i.melodies.octave=5;
i.melodies.octave=6;
i.melodies.octave=3;
i.melodies.octave=4;


(
i = INSTRUMENT().play;
p=ProxySpace.push(s);
~sound.play;
~sound = {|notes=#[60,65,67,72],gain=1| (SinOsc.ar(notes.midicps)*gain).tanh / 6 ! 2 };
//~sound = {|notes=#[60,65,67,72],gain=1| (Saw.ar(notes.midicps/2)*gain).tanh / 10 ! 2 };

i.notes=INSTRUMENT(~sound);
i.notes.seq(\gain,[3,1,13]).speed(1/2);
)

(
i = INSTRUMENT().play;
i.piano=i.synths.piano[1];
i.notes=INSTRUMENT(i.piano);

    i.notes[0].chord([C(0,\m),C(1,\M,0,[16]),]).speed(1/2).do(2);

	i.notes[1].chord([C(0,\m),C(3,\sus2),C(2,\dim),C(7,\M)]).speed(1/2).do(3);
i.notes.rm(\gain);
)



// playing sample (breath) ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

(
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/breath-drums_edit.wav");
// one loop segment
SynthDef(\oneLoop, { |out, bufnum, start, time, amp, rate = 1|
    var sig = PlayBuf.ar(1, bufnum,
        rate: rate * BufRateScale.kr(bufnum),
        startPos: start, loop: 0
    ),
    env = EnvGen.kr(Env.linen(0.01, time, 0.05, level: amp),
        doneAction: Done.freeSelf);
    Out.ar(out, (sig * env).dup);
}).add;
/*
SynthDef(\bell, { |out, accent = 0, amp = 0.1, decayScale = 1|
    var exc = PinkNoise.ar(amp)
    * Decay2.kr(Impulse.kr(0), 0.01, 0.05),
    sig = Klank.ar(`[
        { ExpRand(400, 1600) } ! 4,
        1 ! 4,
        { ExpRand(0.1, 0.4) } ! 4
    ], exc, freqscale: accent + 1, decayscale: decayScale);
    DetectSilence.ar(sig, doneAction: Done.freeSelf);
    Out.ar(out, sig.dup)
}).add;*/
)

SynthDef.removeAt(\bell, libname: 'global')

(
var start = 0.25, end = 4.75,
beatsInLoop = 8,
originalTempo = beatsInLoop / (end - start);

TempoClock.tempo = originalTempo;

p = Ptpar([
    0, Pbind(
        \instrument, \oneLoop,
        \bufnum, b,
        \amp, 0.4,
        \start, start * b.sampleRate,
        \dur, beatsInLoop,
        \time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
        \rate, Pfunc { thisThread.clock.tempo / originalTempo }
    )/*,
    0.5, Pn(
        Pfindur(4,
            Pbind(
                \instrument, \bell,
                \accent, Pseq([2, Pn(0, inf)], 1),
                \amp, Pseq([0.3, Pn(0.1, inf)], 1),
                \decayScale, Pseq([6, Pn(1, inf)], 1),
                \dur, Pwrand(#[0.25, 0.5, 0.75, 1], #[2, 3, 1, 1].normalizeSum, inf)
            )
        ),
    inf),
    0.5, Pbind(
        \instrument, \bell,
        \accent, -0.6,
        \amp, 0.2,
        \decayScale, 0.1,
        \dur, 1
    )*/
], 1).play;
)

// Ctrl/Cmd + .


