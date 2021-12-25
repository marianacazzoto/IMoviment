int pinoSensor = 7;

void setup() {
  pinMode (pinoSensor, INPUT);
  Serial.begin(9600);  
}

void loop() {
  if(digitalRead(pinoSensor) == LOW) {
    Serial.println(1);
  }
  else {
    Serial.println(0);
  }
  delay(1000);
}
