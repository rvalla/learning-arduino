import processing.serial.*;

Serial thePort;            //The serial port
int lineNumber = 0;        //A number to move the data along the horizontal axis
int distance = 0;          //The distance measured by the sensor
float mappedDistance = 0;  //Mapping the distance to height within the window
color colorA = color(0);   //The colors
color colorB = color(255);
float angle = 0;
float angleT = TWO_PI/720;
boolean turn = false;

void setup(){
    size(800,800);
    background(0);
    frameRate(24); //Related to delay on Arduino Uno (40 miliseconds)
    thePort = new Serial(this, Serial.list()[0], 9600);
    thePort.clear();
}

void draw(){
    while (thePort.available() > 0) {
        try {
            JSONObject data = parseJSONObject(thePort.readString()); //Updating the data
            distance = data.getInt("d");
            mappedDistance = getMappedDistance(distance); //Mapping the new distance
            updateColors(distance);
        } catch (Exception e) {
            println("Can't get an int from the data.");
        }
    }
    if (turn == false){
        strokeWeight(1);
        stroke(colorA);
        line(lineNumber, 0, lineNumber, mappedDistance);
        stroke(colorB);
        line(lineNumber, mappedDistance, lineNumber, height);
        lineNumber = (lineNumber + 1) % width; //Moving to the right
    } else {
        strokeWeight(3);
        pushMatrix();
        translate(width/2, height/2);
        rotate(angle);
        line(0,0,0,mappedDistance);
        popMatrix();
        angle += angleT;
    }
}

float getMappedDistance(int d){
    return map(d,0,1000,0,height);
}

void updateColors(int d){
    int r = int(map(d, 0, 2000, 0, 255));
    int g = int(map(d, 0, 2000, 255, 0));
    int b = int(map(d, 0, 2000, 50, 155));
    colorA = color(255-r,255-g,255-b);
    colorB = color(r,g,b);
}

void keyPressed(){
    if (key == 'e'){
        background(0);
    } else if (key == 'm') {
        if (turn == true){
            turn = false;
        } else {
            turn = true;
        }
    }
}
