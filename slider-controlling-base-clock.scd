
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
(s.boot;
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
(i.bass.stop;
i.kick.stop;)