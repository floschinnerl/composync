//first run this: move cursor before the first bracket and hit cmd+enter
(~listener = {|msg, time, replyAddr, recvPort|
	if (msg[0].asString.contains("/hello/from/oscjs"), {
		// Log all received messages to the console.
		("Message received on port" + recvPort + "from " + replyAddr.ip + ":" + replyAddr.port + ":" + msg).postln;
		//msg[1].postln;
		//msg[2].postln;
		//i.bass.clock=msg[1];
		//i.kick.clock=msg[2];
		x=(msg[1]/2).floor;
		y=(msg[2]/2).floor;
		("x: "+x).postln;
		("y: "+y).postln;
		z = s.value(p);

		z[0].postln;
		z[1].postln;
		z[2].postln;
		z[3].postln;
		i.voices.clear;
		i.voices.v1.note(z[0]);
		i.voices.v2.note(z[1]);
		i.voices.v3.note(z[2]);
		i.voices.v4.note(z[3]);
		if(x==4, {i.voices.clock=c*4;"double time".postln;},{i.voices.clock=c*2;"half time".postln;});

		"new listener06".postln;
		("d[y]: "+d[y]).postln;
		i.kick.seq(d[y][0].asString);
		i.hats.seq(d[y][1].asString);
	});
};

thisProcess.addOSCRecvFunc(~listener);)

//then run this – move cursor before the round bracket in line 20 and press cmd+enter

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
thisProcess.stop;
// to stop sound run this:
(
i.bass.stop;
i.kick.stop;
i.hihat.stop;
)
c
i.kick.clock=c*4;

(
i=INSTRUMENT().play;
c = 1.5;
x = 3;
y = 7;
// i.kick=i.synths.kick[2]; <-- good one!

//i.kick=i.synths.rhodes2; <-- nice lead
i.kick=i.synths.kick.kickDeep; // <-- good one
i.hats=i.synths.hihatdist;
i.hats.amp=0.1;
//i.kick=i.synths.kick.kickDamp;  // <-- nice too

//i.kick=i.synths.kick.kick_808;
i.kick.clock=c*4;
i.hats.clock=c*4;

d=d.add(["1        1       ","    1        1   "]);
d.extend(2,["1    1    1    1   ","   1   1     1   1 "]);
d.extend(3,["1   1 1   1    1 1   ","  1    1    1    1 "]);
d.extend(4,["1   1 1  1  1   1 1   ","  1   1  1   1     1"]);
d.extend(5,["1      1  1    1  1        1  1    1   ","    1      1        1        1    1 "]);
d.extend(6,["1      1 1 1 1 1    1    1    1  1    1   ","    1        1        1      1    1 "]);
d.extend(7,["1      1 1 1 1 1    1    1    1 1  1    1  ","    1        1        1    1    1   1"]);
d.extend(8,["1   1   1   1   1    1      1 1  1    1  "," 1   1   1   1    1      1    1    1   1"]);
d.do({arg temp, p;
	("p: "+ p).postln;
	("temp: "+temp).postln;
	temp[0].postln;
	temp[1].postln;});

d[y][0].asString.postln;
d[y][1].asString.postln;
i.kick.seq(d[y][0].asString);
i.hats.seq(d[y][1].asString);



)/*

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

i.voices.clock=c*2;
("clock initialized: "++i.voices.clock).postln;
i.voices.amp=0.1;

z = ["","","",""];

h=[C(0,\M).chord,C(7,\M).chord,C(9,\m).chord,C(5,\M).chord];
p=Array.new(0);
//most basic one (1/5)
p = p.add([
	h[0]," ", " "," "," "," "," "," ",
	h[1]," ", " "," "," "," "," "," "," ",
	h[2]," ", " "," "," "," "," "," "," ",
	h[3]," ", " "," "," "," "," "," "]);

p.size.postln;
// little bit more complex (2/5)
p = p.add([
	h[0]," ", " "," "," ",h[0]," "," "," ",
	h[1]," ", " "," "," "," ",h[1]," "," "," ",
	h[2]," ", " "," "," "," ",h[2]," "," "," ",
	h[3]," ", " "," "," "," ",h[1]," "," "]);


p.size.postln;

// 3/5 complex
p= p.add([
	h[0]," ", " "," "," ",h[0]," "," ",h[0]," ",
	h[1]," ", " "," "," "," ",h[1]," "," ",h[1]," ",
	h[2]," ", " "," "," "," ",h[2]," "," ",h[2]," ",
	h[3]," ", " "," "," "," ",h[3]," "," ",h[1]]," ");
p.size.postln;

p = p.add([
	h[0]," ", " ",h[0]," ",h[0]," "," ",h[0]," ",
	h[1]," ", " "," ",h[1]," "," ",h[1]," "," ",h[1]," ",
	h[2]," ", " "," ",h[2]," "," ",h[2]," "," ",h[2]," ",
	h[3]," ", " "," ",h[3]," "," ",h[3]," "," ",h[1]]," ");
p.size.postln;

p = p.add([
//  1   ,   ,   ,   ,2  ,   ,    ,   ,3   ,   ,   ,   ,4  ,    ,    ,
	h[0]," "," "," "," "," ",h[0]," "," ", " "," ",h[0]," "," ", " "," ",h[1]," ",
	" "," "," ",h[1]," "," "," "," ",h[1]," "," ",h[1]," "," ", " "," ",h[1]," "," "," "," ",
	h[2]," "," "," "," "," ", " ",h[2], " "," "," ", " ",h[2]," "," ", " "," ",h[3]," ",
	" "," "," ",h[3]," "," "," "," ",h[3]," "," ",h[3]," "," ", " "," ",h[1]," "," "," "]);
("p.size: " + p.size).postln;
("x: "+ x).postln;
s = { arg p; var q = ["","","",""];
	p[x].size.postln;
p[x].do(
	{arg item, i;
			//item.isString.postln;
			if(item.isString, {[1,2,3,4].do({arg test, b;
				q[b] = q[b] ++ " ";/*("i/b: " ++ i ++ "/" ++ b).postln;q.size.postln;*/})} ,
			{item.do({arg jtem, a;
					q[a] = q[a] ++ jtem.asString ++ if(i<(p.size-1)," ","");
				/*("i/a: " ++ i ++ "/" ++ a).postln; q.size.postln;*/
			})});
			//item.postln;
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