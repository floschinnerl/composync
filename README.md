# composync

we're a students' project from the department [Cross Disciplinary Strategies](https://cdslab.uni-ak.ac.at/) at the [University of Applied Arts Vienna](https://dieangewandte.at/en)

we're currently looking for coding support! If you're into affective computing, music and visualisation and would like to contribute, we'd be happy to hear from you! Skills in Python, Raspberry Pi, OpenCV, node.js, vue.js (full stack web interface), SuperCollider or similar tools used for reading sensors, making music and visuals would be great.
We can offer no money but the experience to work in an interdisciplinary project, combining scientific research, artistic expression and applied software development! For this kind of collaboration, we believe in flat hierarchies and continuous exchange between all project members. This means that we are open for contributions to the concept both in scientific and artistic ways from all members of the team.

get in contact if you're interested --> [florian.schinnerl@gmail.com](mailto:florian.schinnerl@gmail.com) !



### mission statement
> Our mission is to foster emotional learning  
> and exploration through the use of atmospheres,  
> composed of sound and visuals.  
> We are doing this using affective computing  
> as well as user generated input to feed an algorithm  
> which composes said atmospheres as well as to gather information  
> on how different atmospheres are emotionally received.  



- [Demonstration of a possible outcome #1](https://drive.google.com/file/d/1qsGrb66ct0ONlUSFjWOeFnfcEFqe4Znt/view?usp=sharing)
- [Demonstration of a possible outcome #2](https://drive.google.com/file/d/1rXKl0z76dJZ1PkthcH-ekKCIah-3jmfS/view?usp=sharing)



### research questions
1) How can emotions be expressed and influenced through
 a) Colours?
 b) Music?
2) How can physiological body responses be measured and mapped in a multi-dimensional emotional model?
3) In emotional learning, which role play(s)
 a) Colours?
 b) Music?
 c) Affective computing?

### goals for setup
#### setup abstract
![composync setup](https://github.com/floschinnerl/composync/blob/main/composync-loop.gif)
#### tech setup
![composync tech setup](https://github.com/floschinnerl/composync/blob/main/tech-illustration.gif)
 

## getting started
### pre-requisits
you must have node.js and vue.js installed, as well as supercollider
- [tutorial for installing node.js](https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs/development_environment#installing_node)
- to install vue.js, type ```$ npm install vue```
- [download supercollider](https://supercollider.github.io/download)

### setup
1) start node server
  - on terminal in sc-slider/scr type ```node api.js```
2) start vue website
  - on terminal in sc-slider type ```npm run serve```
3) run supercollider script
  - open the .scd file in supercollider
  - run the first block by pressing cmd+enter at the opening or closing bracket 
  - run the second block by pressing cmd+enter at the opening or closing bracket 
4) open the website at http://localhost:8080/
  - move ball around
  - hear the music changing

