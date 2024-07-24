void writeColor() {
    // Send the information to Arduino
    String colorInfo = currentColorIndex[0] + "," + currentColorIndex[1] + "," + currentColorIndex[2];
    myPort.write(colorInfo);
}