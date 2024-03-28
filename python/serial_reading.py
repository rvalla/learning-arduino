import serial
import json

the_port = "/dev/ttyUSB0" #Serial port of Arduino on Ubuntu
baud = 9600 #Arduino uno runs at 9600 baud
samples = 1000 #Limiting the number of iterations
data_count = 0 #Current data recieved

#A function to get a string with size relative to the distance
def getDataRepresentation(d):
    m = ""
    size = d // 10
    if size > 120:
        size = 120
    for i in range(size):
        m += "-"
    return m

arduino = serial.Serial(the_port, baud, timeout=1)
print("Connected to Arduino port: " + the_port, end="\n\n")

while data_count < samples:
    msg = arduino.readline().decode("utf-8") #The last two characters seem to be linebreaks
    try:
        the_data = json.loads(msg[:-2]) #We are receiving a json formated string
        print(getDataRepresentation(the_data["d"]), end="\n")
        data_count += 1
    except:
        pass