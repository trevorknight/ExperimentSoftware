void mousePressed() {
  for (int i = 0; i < ratebuttons.length; i++) {
    if (ratebuttons[i].pressed() && played && myChannel.state==Ess.STOPPED) {
      results = append(results, nf(clip, 3) + ", " + nf(i+1, 1));
      saveStrings("results" + sections[sectionIndex] + ".txt", results);
      played = false;
      if (index+1 < notes.length) {
        index++;
        loadNewSound();
      } else {
        if (sectionIndex + 1 == sections.length) {
          finishedPhase = true;
          playPhase = false;
        } else {
          playPhase = false;
          restPhase = true;
        }
      }
    }
  }
  if ((play.contains(mouseX, mouseY)) && (playPhase)) {
    if (myChannel.state==Ess.STOPPED) {
      myChannel.play(1);
      played = true;
    }
    else {
      myChannel.stop();
    }
  } 
}

void keyPressed() {
  if (key == ' ') {
    if (startPhase) {
      startPhase = false;
      playPhase = true;
    }
    if (restPhase) {
      restPhase = false;
      index = 0;
      sectionIndex++;
      notes = files[sections[sectionIndex]];
      loadNewSound();
      playPhase = true;
    }
    if (playPhase) {
      if (myChannel.state==Ess.STOPPED) {
        myChannel.play(1);
        played = true;
      } else {
        myChannel.stop();
      }
    }
  }
}

void loadNewSound() {
  clip = notes[index];
  println(clip + " " + sections[sectionIndex]);
  load = str(clip) + ".wav";
  myChannel.loadSound(load);
//  myChannel = new AudioChannel(load);
}

