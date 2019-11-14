void setup() {
  Serial.begin(9600);
  

}

void loop() {
  int sensorValue1 = analogRead(A5); //A 4 5 6 7 
  int sensorValue2 = analogRead(A4); 
  int sensorValue3 = analogRead(A7); 
  int sensorValue4 = analogRead(A6); 
  Serial.print(sensorValue1);
  Serial.print(" ");
  Serial.print(sensorValue2);
  Serial.print(" ");
  Serial.print(sensorValue3);
  Serial.print(" ");
   Serial.println(sensorValue4);
  delay(50);
}þ
