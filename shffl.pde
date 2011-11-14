// Takes an array and shuffles it to return a permutation of the array.

int[] shffl(int[] tArray) {
  for (int i=0; i<tArray.length; i++) {
    int randomPosition = rgen.nextInt(tArray.length);
    int temp = tArray[i];
    tArray[i] = tArray[randomPosition];
    tArray[randomPosition] = temp;
  }
  return tArray;
}
