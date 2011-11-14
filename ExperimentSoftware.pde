PFont font;
import krister.Ess.*;

int participant = 1;

// ====================================
// PROGRAM FLOW
// Booleans to control the flow of the program from the introduction to the ratings (with breaks) to the end.
int phase = 0;
boolean startPhase = true;
boolean restPhase = false;
boolean playPhase = false;
boolean finishedPhase = false;

String CurrentDisplay;

// ====================================
// RATINGS

String[] results = new String[0]; // To store output ratings

rateButton[] ratebuttons = new rateButton[7];
String[] buttonLabels = {"1", "2", "3", "4", "5", "6", "7"};


// ====================================
// AUDIO
AudioChannel myChannel; // Load audio channel
boolean played = false;
PlayButton play;
String load;

// ====================================
// SEGMENT 
int clip;
int index = 0;
Random rgen = new Random();
int[] notes;

// Names for the blocks of stimuli to be used
String[] names = {"Piano, Low", "Piano, Mid", "Piano, High", "Mezzo-forte, Low", "Mezzo-forte, Mid", "Mezzo-forte, High", "Fortissimo, Low", "Fortissimo, Mid", "Fortissimo, High"};

// This array is the order of the blocks (or "sections") to be used. 
// Later, I shuffle them but they can be set in an order here
int[] sections = {0, 1, 2, 3, 4, 5, 6, 7, 8};

int sectionIndex = 0; // Initial section

// File  names of audio stimuli
int[][] files = {
  {241, 277, 313, 349, 385, 421, 457, 493, 529, 565, 34, 65, 85, 87, 89, 151, 186, 242, 278, 314, 350, 386, 422, 458, 494, 530, 566, 18, 48, 55, 82, 115, 155, 193, 243, 279, 315, 351, 387, 423, 459, 495, 531, 567, 33, 74, 145, 156, 192, 196, 213, 244, 280, 316, 352, 388, 424, 460, 496, 532, 568, 26, 35, 105, 131, 152, 157, 170}, //p,low
  {245, 281, 317, 353, 389, 425, 461, 497, 533, 569, 19, 50, 62, 104, 169, 190, 195, 246, 282, 318, 354, 390, 426, 462, 498, 534, 570, 10, 15, 32, 43, 144, 189, 209, 247, 283, 319, 355, 391, 427, 463, 499, 535, 571, 84, 103, 127, 139, 141, 162, 181, 248, 284, 320, 356, 392, 428, 464, 500, 536, 572, 47, 70, 72, 90, 109, 185, 214}, //p,mid
  {249, 285, 321, 357, 393, 429, 465, 501, 537, 54, 69, 93, 120, 183, 197, 250, 286, 322, 358, 394, 430, 466, 502, 538, 81, 99, 158, 167, 187, 200, 251, 287, 323, 359, 395, 431, 467, 503, 539, 12, 14, 25, 36, 97, 142, 252, 288, 324, 360, 396, 432, 468, 504, 540, 3, 6, 61, 148, 166, 174}, //p,high
  {253, 289, 325, 361, 397, 433, 469, 505, 541, 573, 11, 77, 79, 91, 98, 132, 217, 254, 290, 326, 362, 398, 434, 470, 506, 542, 574, 49, 59, 66, 175, 211, 212, 218, 255, 291, 327, 363, 399, 435, 471, 507, 543, 575, 45, 83, 95, 150, 179, 194, 219, 256, 292, 328, 364, 400, 436, 472, 508, 544, 576, 1, 2, 31, 112, 204, 215, 220}, //mf, low
  {257, 293, 329, 365, 401, 437, 473, 509, 545, 577, 37, 53, 76, 86, 107, 147, 221, 258, 294, 330, 366, 402, 438, 474, 510, 546, 578, 16, 60, 80, 129, 149, 202, 222, 259, 295, 331, 367, 403, 439, 475, 511, 547, 579, 30, 51, 134, 143, 172, 216, 223, 260, 296, 332, 368, 404, 440, 476, 512, 548, 580, 58, 73, 102, 124, 163, 176, 224}, //mf,mid
  {261, 297, 333, 369, 405, 441, 477, 513, 549, 9, 57, 111, 173, 199, 225, 262, 298, 334, 370, 406, 442, 478, 514, 550, 7, 78, 118, 133, 208, 226, 263, 299, 335, 371, 407, 443, 479, 515, 551, 106, 108, 146, 177, 198, 227, 264, 300, 336, 372, 408, 444, 480, 516, 552, 56, 63, 114, 123, 125, 228}, //mf, high
  {265, 301, 337, 373, 409, 445, 481, 517, 553, 581, 8, 22, 28, 52, 161, 203, 229, 266, 302, 338, 374, 410, 446, 482, 518, 554, 582, 23, 29, 41, 153, 160, 165, 230, 267, 303, 339, 375, 411, 447, 483, 519, 555, 583, 27, 71, 113, 168, 188, 207, 231, 268, 304, 340, 376, 412, 448, 484, 520, 556, 584, 21, 96, 101, 122, 130, 205, 232}, //ff,low
  {269, 305, 341, 377, 413, 449, 485, 521, 557, 585, 38, 44, 140, 154, 171, 184, 233, 270, 306, 342, 378, 414, 450, 486, 522, 558, 586, 20, 42, 100, 138, 180, 210, 234, 271, 307, 343, 379, 415, 451, 487, 523, 559, 587, 39, 110, 126, 159, 178, 191, 235, 272, 308, 344, 380, 416, 452, 488, 524, 560, 588, 4, 5, 40, 92, 94, 164, 236}, //ff,mid
  {273, 309, 345, 381, 417, 453, 489, 525, 561, 88, 117, 128, 201, 206, 237, 274, 310, 346, 382, 418, 454, 490, 526, 562, 17, 68, 75, 119, 137, 238, 275, 311, 347, 383, 419, 455, 491, 527, 563, 13, 24, 46, 116, 182, 239, 276, 312, 348, 384, 420, 456, 492, 528, 564, 64, 67, 121, 135, 136, 240}//ff,high
};


// ====================================
// SETUP
// ====================================
void setup() {
  size(460, 460);

  // Shuffle stimuli within blocks
  for (int i = 0; i < files.length; i++) {
    files[i] = shffl(files[i]);
  }

  // Shuffle the order of blocks
  sections = shffl(sections);

  // Set the current block
  notes = files[sections[sectionIndex]];

  font = loadFont("Georgia-32.vlw");
  textFont(font,20);

  //Ratings
  for (int i = 0; i < ratebuttons.length; i++) {
    ratebuttons[i] = new rateButton(35+i*65, height-35, 60, 60, buttonLabels[i]);
  }

  //Audio
  Ess.start(this);
  myChannel = new AudioChannel();
  myChannel.bufferSize(5000);
  loadNewSound();
  play = new PlayButton(width/2, (height-60)/2, 100);
}

void draw() {
  background(210);
  if (startPhase) {
    fill(0);
    textFont(font, 20);
    textAlign(CENTER);
    text("Trumpet tone quality experiment", width/2, 30);
    text("During the test, press [space] or click the button", width/2, 105);
    text("to play the sound.", width/2, 130);
    //    text("The first set of notes are all piano.",width/2,250);
    text("Press SPACE to start.", width/2, 350);
  }
  if (playPhase) {
    fill(0);
    textFont(font, 20);
    textAlign(CENTER);
    text(names[sections[sectionIndex]] + " " + (index+1) + " / " + notes.length, width/2, 20);
    text("Please wait for the sound to finish", width/2, 55);
    text("playing before rating.", width/2, 80);
    if (myChannel.state==Ess.STOPPED) {
      play.displayStopped(mouseX, mouseY);
    }
    else {
      play.displayPlaying(mouseX, mouseY);
    }

    fill(0);
    textAlign(LEFT);
    text("Worst", 0, height-70);
    textAlign(RIGHT);
    text("Best", width, height-70);
    for (int i = 0; i < ratebuttons.length; i++) {
      ratebuttons[i].display();
    }
  }

  if (restPhase) {
    fill(0);
    textFont(font, 20);
    textAlign(CENTER);
    text("Please take a break for a minute.", width/2, 150);
    text("Press SPACE to start.", width/2, 380);
  }

  if (finishedPhase) {
    fill(0);
    textFont(font, 20);
    textAlign(CENTER);
    text("The end!", width/2, 150);
  }
}

public void stop() {
  Ess.stop();
  super.stop();
}

