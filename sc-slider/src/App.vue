<template>
    <div class="wrapper">
        <br/>
        <div id="position"> 
          <h3 class="vl">Intensity</h3>
          <h3 class="hl">Complexity</h3>
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
      y: 0
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
    this.connection = new WebSocket("ws://localhost:9898/")

    this.connection.onmessage = function(event) {
      console.log(event);
    }

    this.connection.onopen = function(event) {
      console.log(event)
      console.log("Successfully connected to the OSC websocket server...")
    }
      }
} 

/* MIT License

RoundSlider Copyright (c) 2020 Soundar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. */
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
</style>

