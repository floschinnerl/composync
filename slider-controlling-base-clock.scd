(
~listener = {|msg, time, replyAddr, recvPort|
	if (msg[0].asString.contains("/hello/from/oscjs"), {
		// Log all received messages to the console.
		("Message received on port" + recvPort + "from " + replyAddr.ip + ":" + replyAddr.port + ":" + msg).postln;
		msg[0].postln;
		i.bass.clock=msg[1];
	});
};

thisProcess.addOSCRecvFunc(~listener);
)

thisProcess.removeOSCRecvFunc(~listener);


s.boot;
i=INSTRUMENT();

i = INSTRUMENT().play;


i.kick="kick";
i.kick.seq("1 0.3 0.75 2");


i.bass=i.synths.trance.choose;
i.bass.note = "C3 Db3   C4 C3  :1.5  Db3x2  :1/2   Bb2x2  ";
i.bass.clock=6;
	i.bass.stop;
	i.kick.stop;

//demo to send to the localhost Server
(

var n, id;


//loopback address is 127.0.0.1- try substituting the IP address of another user's machine

n=NetAddr("127.0.0.1", 57110); //57110 is the port number; this is the standard number used by the Server


id=s.nextNodeID;

n.sendMsg("s_new",\default,id,0,0);   //sendMsg works out the correct OSC message for you


SystemClock.sched(1.0,{n.sendMsg("n_free",id); });

)

(

// register to receive a trigger message

o = OSCFunc({ arg msg,time,address,receivedPort;


"received trigger!".postln;

Post << msg <<nl;

}, //Function

'/tr',	//OSC message address name,

s.addr //NetAddr (where the message will arrive from). Leave this nil if you want to allow it to come from anywhere (for example, if another application is sending from a variable or unknown port)

);


//send a trigger message whenever the impulse fires (once every 2 seconds)

{SendTrig.ar(Impulse.ar(0.5))}.play;

)




//keep it running and now run these lines:

(

p= OSCFunc({ arg time,responder,msg;


"new reaction!".postln;

Post << time <<nl;


},'/tr',s.addr);

)


//remove the OSCFunc instances
(o.free;
p.free;)

