const int t = 2;         //Pin to trigger the sensor
const int e = 3;         //Pin to get the echo
int count = 0;               //Number of sent messages
float soundSpeed = 0.343; //Speed of sound (mm/us)
 
void setup() {
  Serial.begin(9600);           //We start the serial port
  pinMode(t, OUTPUT);           //Setting pin as output
  pinMode(e, INPUT);            //Setting pin as input
  digitalWrite(t, LOW);         //Starting t with 0
}
 
void loop(){
 
  long time;     //The time the echo needs to reach the sensor
  float distance; //The distance to the object in cm
 
  digitalWrite(t, HIGH);
  delayMicroseconds(10); //A pulse of 10us
  digitalWrite(t, LOW);
  
  time = pulseIn(e, HIGH); //Measuring the with of the pulse
  distance = time * soundSpeed / 2;      //Getting the distance to the object

  Serial.flush();
  Serial.println(formatMessage("SR04", count, distance));  //Serial comunications
  count += 1;

  delay(80);
}

String formatMessage(String sensor, int c, int d){
  String msg = "{\"s\":\"" + sensor + "\",";
  msg += "\"id\":" + String(count) + ",";
  msg += "\"d\":" + String(d) + "}";
  return msg;
}