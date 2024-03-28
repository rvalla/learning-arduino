import processing.serial.*;

Serial thePort;            //The serial port
int lineNumber = 0;        //A number to move the data along the horizontal axis
int distance = 0;          //The distance measured by the sensor
float mappedDistance = 0;  //Mapping the distance to height within the window
color colorA = color(0);   //The colors
color colorB = color(255);

void setup(){
    size(800,800);
    background(255);
    strokeWeight(1);
    frameRate(24); //Related to delay on Arduino Uno (40 miliseconds)
    thePort = new Serial(this, Serial.list()[0], 9600); 
}

void draw(){
    while (thePort.available() > 0) {
        distance = int(thePort.readString());         //Updating the distance
        mappedDistance = getMappedDistance(distance); //Mapping the new distance
    }
    stroke(colorA);
    line(lineNumber, 0, lineNumber, mappedDistance);
    stroke(colorB);
    line(lineNumber, mappedDistance, lineNumber, height);
    lineNumber = (lineNumber + 1) % width; //Moving to the right
}

float getMappedDistance(int d){
    return map(d,0,50,0,height);
}
