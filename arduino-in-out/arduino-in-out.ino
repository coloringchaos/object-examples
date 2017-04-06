int sensor1;
int sensor2;

char val;
int ledPin = 11;

void setup() {
  Serial.begin(9600);

  //send something to start out
  //when we start, send something to processing
  Serial.println("0");
  pinMode(ledPin, OUTPUT);
}

void loop() {
  //send data only when it is requested
  if (Serial.available() > 0) {

    //read for LED
    val = Serial.read();


    //read incoming from processing
    char input = Serial.read();

    //then send our data
    sensor1 = analogRead(A0);
    sensor2 = analogRead(A1);
    Serial.print(sensor1);
    Serial.print(",");
    Serial.println(sensor2);
  }

  //LED STUFF
  //interpret incoming values (will be from processing)
  if (val == '1') {
    digitalWrite(ledPin, HIGH);
  }
  if (val == '0') {
    digitalWrite(ledPin, LOW);
  }
}


