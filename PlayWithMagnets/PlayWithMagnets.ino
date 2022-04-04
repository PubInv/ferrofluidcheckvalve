/*
 * Copyright Robert L. Read, 2022
 * PlayWithMagnets
 * A program to manipulate digital pins to contol tranistors to gate power 
 * to magnets
 * Released by Public Invention under GNU Affero License
 */

const int MAGNET_ON_MS  = 1000;
const int MAGNET_OFF_MS = 1000;
const long PERIOD_MS = MAGNET_ON_MS + MAGNET_OFF_MS;

const int MAGNET_0_PIN = 8;

void setup() {
  // put your setup code here, to run once:
  pinMode (MAGNET_0_PIN, OUTPUT);
  Serial.begin(9600);
}

// At first I'm just going to turn the magnet on with a duty cycle
// to see if I can jiggle the ferrofluid and keep the coils cool

void loop() {
  // put your main code here, to run repeatedly:
  delay(50);
  long ms = millis();
  int lms = (ms % PERIOD_MS);
  int val = (lms < MAGNET_ON_MS) ? HIGH : LOW;
  Serial.println(lms);
  if (lms < MAGNET_ON_MS) {
    digitalWrite(MAGNET_0_PIN,HIGH);
    Serial.println("HIGH");
  } else {
    digitalWrite(MAGNET_0_PIN,LOW);
    Serial.println("LOW");
  }
}
