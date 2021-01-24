<template>
    <div class="wrapper">
        <br/>
        <div id="position"> 
          <h4 class="heartrate">&lt;3 60 </h4>
          <h3 class="vl">Intensity</h3>
          <h3 class="hl">Complexity</h3>
          <button class="mood">mood</button>
        </div>
    </div>
</template>

<script>
import Nexus from "nexusui";
export default {
    name: 'App',
    data() {
        return {
      connection: null,
      x: 0,
      y: 0,
      heartrate: 60
    }
    },
    methods: {
      sendMessage: function(message) {
      console.log(this.connection);
      this.connection.send(message);
    },
    positionChange: function(p) {
      this.x = Math.round(p.x*10);
      this.y = Math.round(p.y*10);
      console.log("x: "+this.x+", y: "+this.y)
      this.sendMessage(JSON.stringify([this.x, this.y]));
    }

    },
    mounted () {
      this.dial = new Nexus.Position('#position',{
      'size': [screen.width,screen.height],
      'mode': 'absolute',  // "absolute" or "relative"
      'x': 0.5,  // initial x value
      'minX': 0,
      'maxX': 1,
      'stepX': 0,
      'y': 0.5,  // initial y value
      'minY': 0,
      'maxY': 1,
      'stepY': 0
    })
    this.dial.on('change',this.positionChange)  // doesn't work like this...
    },
    created: function() {
    console.log("Starting connection to WebSocket Server")
    //this.connection = new WebSocket("ws://localhost:9898/")
    console.log("ip: "+ window.location.hostname)
    this.connection = new WebSocket("ws://"+window.location.hostname+":9898/") // <-- for beyond-localhost

    this.connection.onmessage = function(event) {
      console.log(event);
    }

    this.connection.onopen = function(event) {
      console.log(event)
      console.log("Successfully connected to the OSC websocket server...")
    }
      }
} 


</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

#position {
  position: fixed;
    top: 50%;
    left: 50%;
    -webkit-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    z-index: 10;
}

.vl {
  z-index: 20;
  font-family: Arial, Helvetica, sans-serif;
  position: fixed;
  top: 43%;
  left: 1%;
  writing-mode: vertical-rl;
}

.hl {
   z-index: 20;
  font-family: Arial, Helvetica, sans-serif;
  position: fixed;
  bottom: 8%;
  left: 47%;
}

.heartrate {
  z-index: 21;
  font-family: Arial, Helvetica, sans-serif;
  position: fixed;
  top: 5%;
  right: 2%;
}

.mood {
  z-index: 21;
  font-family: Arial, Helvetica, sans-serif;
  position: fixed;
  top: 10%;
  right: 1%;
  padding: 10px 20px;
  font-size: 15px;
  color: #2bb;
  background-color:#fff;
  border: 0px;
  border-radius: 10px;
  width: max-content;
  transition: 0.25s ease;
}
.mood:hover {
    color: #fff;
    background-color: #2bb;
  }

</style>

