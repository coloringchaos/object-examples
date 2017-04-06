import processing.serial.*;

//instance of the serial library
Serial myPort;

float sensor1;
float sensor2;
float ballx;
float bally;

void setup() {
  size(600, 400);
  println(Serial.list());
  String portName = "/dev/tty.usbmodem14411"; 
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  background(230, 230, 250);
  noStroke();
  ballx = map(sensor1, 0, 1023, 15, width-15);
  bally = map(sensor2, 0, 909, 15, height-15);
  ellipse(ballx, bally, 30, 30);
}

void mouseClicked() {
  if (dist(mouseX, mouseY, ballx, bally) <= 15) {
    println("led on");
    myPort.write("1");
  }else{
    println("led off");
    myPort.write("0");
  }
}


//read data in this serial event!!!!
void serialEvent(Serial myPort) {
  String input = myPort.readStringUntil('\n');

  if (input != null) { //if we have data
    //remove any whitespace
    input = trim(input);

    //parse the data and save to an array
    //turn the values to intigers
    int[] sensors = int(split(input, ','));

    //set variables equal to values in the array
    //if there is content in our array
    if (sensors.length>1) {
      sensor1 = sensors[0];
      sensor2 = sensors[1];
    }
  }

  //send something back to arduino
  //let arduino know we received soemthing
  myPort.write('x');
}