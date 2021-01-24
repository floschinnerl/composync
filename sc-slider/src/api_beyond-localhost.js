    // Node.js WebSocket server script
    const http = require('http');
    var osc = require("osc");
    const { networkInterfaces } = require('os');
    const WebSocketServer = require('websocket').server;
    const server = http.createServer();
    const nets = networkInterfaces();
    const results = Object.create(null); // Or just '{}', an empty object

    for (const name of Object.keys(nets)) {
        for (const net of nets[name]) {
            // Skip over non-IPv4 and internal (i.e. 127.0.0.1) addresses
            if (net.family === 'IPv4' && !net.internal) {
                if (!results[name]) {
                    results[name] = [];
                }
                results[name].push(net.address);
            }
        }
    }

    var udpPort = new osc.UDPPort({
        // This is the port we're listening on.
        localAddress: results["en0"].toString(),
        localPort: 9898,
    
        // This is where sclang is listening for OSC messages.
        remoteAddress: "127.0.0.1",
        remotePort: 57120,
        metadata: true
    });
    
    server.listen(9898);
    const wsServer = new WebSocketServer({
        httpServer: server
    });
    wsServer.on('request', function(request) {
        const connection = request.accept(null, request.origin);
        connection.on('message', function(message) {
          console.log('Received Message:',  message.utf8Data);
          sendOSC(message.utf8Data);
          connection.sendUTF('Hi this is WebSocket server!');
        });
        connection.on('close', function(reasonCode, description) {
            console.log('Client has disconnected.' + reasonCode + " " + description);
        });
    });


    // Open the socket.
udpPort.open();

function sendOSC(message) {
    console.log(message);
    //if(message != undefined) { 
    var m = JSON.parse(message);
    //var m = a.split("/");
    console.log(m);
    var msg = {
        address: "/hello/from/oscjs",
        args: [
            {
                type: "i",
                value: m[0]
            },
            {
                type: "i",
                value: m[1]
            }
        ]
    };

    console.log("Sending message", msg.address, msg.args, "to", udpPort.options.remoteAddress + ":" + udpPort.options.remotePort);
    udpPort.send(msg);
   // }
}