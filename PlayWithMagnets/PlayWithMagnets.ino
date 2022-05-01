/*
 * Copyright Robert L. Read, 2022
 * PlayWithMagnets
 * A program to manipulate digital pins to contol tranistors to gate power 
 * to magnets
 * Released by Public Invention under GNU Affero License
 */

// The simplest thing is to have a single "on" period for each magnet
// and then oscillate through the magnets
const long DURATION_ON_MS = 800;


const int NUM_MAGNETS = 4;
int MAGNET_PIN[NUM_MAGNETS];

// This the TOTAL period of an ascending cycle and then a descending cycle.
const long HALF_PERIOD_MS = NUM_MAGNETS * DURATION_ON_MS;
const long PERIOD_MS = 2 * HALF_PERIOD_MS;

void init_pins() {
 // for(int i = 0; i < NUM_MAGNETS; i++) {
 int i;
  i = 0;
  MAGNET_PIN[i] = 2+1;
  pinMode(MAGNET_PIN[i], OUTPUT);
  digitalWrite(MAGNET_PIN[i],LOW);

  i = 1;
  MAGNET_PIN[i] = 2+3;
  pinMode(MAGNET_PIN[i], OUTPUT);
  digitalWrite(MAGNET_PIN[i],LOW);

  i = 2;
  MAGNET_PIN[i] = 2+2;
  pinMode(MAGNET_PIN[i], OUTPUT);
  digitalWrite(MAGNET_PIN[i],LOW);

  i = 3;
  MAGNET_PIN[i] = 2+0;
  pinMode(MAGNET_PIN[i], OUTPUT);
  digitalWrite(MAGNET_PIN[i],LOW);
 // }
}

void setup() {
  // put your setup code here, to run once:
  init_pins();
  Serial.begin(9600);
  delay(1000);
  
}

// At first I'm just going to turn the magnet on with a duty cycle
// to see if I can jiggle the ferrofluid and keep the coils cool

void set_mag_as_radio_button(int mag) {
  for(int i = 0; i < NUM_MAGNETS; i++) {
    int val = (i == mag) ? HIGH : LOW;
    Serial.print(i);
    Serial.print(" : ");
    Serial.println(val);
    Serial.println(MAGNET_PIN[i]);
     digitalWrite(MAGNET_PIN[i],(i == mag) ? HIGH : LOW);
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(DURATION_ON_MS / 2);
  long ms = millis();
  int lms = (ms % PERIOD_MS);

  // We want to turn the magnets on in ascending order and then descending order.
  // Perhaps the easiest way to do this is test the current time modulo the number
  // times the period times two to determine first if we are descending or ascending,
  // and then which magnet we are on.
  int magnet_order;
  if (lms < (HALF_PERIOD_MS)) { // ascending
    magnet_order = lms / DURATION_ON_MS;   
  } else { // descending
    lms = lms - HALF_PERIOD_MS;
    magnet_order = (NUM_MAGNETS - 1) - (lms / DURATION_ON_MS);
  }
  Serial.print("magnet on:");
  Serial.println(magnet_order);
  set_mag_as_radio_button(magnet_order);
}
