i = INSTRUMENT().play;

// creates a dictionary inside **i.synths**

// access by name

i.kick="kick";
i.kick.seq("1");

// use the dictionary
i.kick='kick';

// replace sounds

i.kick='hihat';



// access by index
i.kick=i.synths.drums.kick[0];
i.kick=i.synths.drums.kick[1];

// index wraps around total synths number inside folder
i.kick=i.synths.drums.kick[99999];

// access randomly
i.kick=i.synths.drums.kick.choose;
i.kick=i.synths.drums.kick.choose;

i.kick=i.synths.drums.snare.choose;
i.kick=i.synths.drums.snare.choose;


// long vs short synth routes are equivalent:
i.synths.percussion.drums.kick[3] == i.synths.kick[3]

// each synth gets added to root folder
i.synths.bass.simpleBass == i.synths.simpleBass;