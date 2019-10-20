int option;
int led = 13;
 
void setup(){
  Serial.begin(9600);
  pinMode(led, OUTPUT); 
}
 
void loop(){
  if (Serial.available()>0){
    char option = Serial.read();
    if (option == '1')
    {
       digitalWrite(led, HIGH);
       delay(100);
    }
    if (option == '2')
    {
       digitalWrite(led, LOW);
       delay(100);
    }
  }
}
