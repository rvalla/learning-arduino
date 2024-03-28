const int t = 2;  //Pin to trigger the sensor
const int e = 3;  //Pin to get the echo
 
void setup() {
  Serial.begin(9600);           //We start the serial port
  pinMode(t, OUTPUT);           //Setting pin as output
  pinMode(e, INPUT);            //Setting pin as input
  digitalWrite(t, LOW);         //Starting t with 0
}
 
void loop(){
 
  long time;     //The time the echo needs to reach the sensor
  long distance; //The distance to the object in cm
 
  digitalWrite(t, HIGH);
  delayMicroseconds(10); //A pulse of 10us
  digitalWrite(t, LOW);
  
  time = pulseIn(e, HIGH); //Measuring the with of the pulse
  distance = time/59;      //Getting the distance to the object

  Serial.print(distance);  //Serial comunications

  delay(40);
}
