/*
 Name:		VisualMicro.ino
 Created:	6/1/2019 8:49:35 AM
 Author:	gojimmypi
*/
#ifndef LED_BUILTIN
#define LED_BUILTIN 5
#endif // !LED_BUILTIN

// the setup function runs once when you press reset or power the board
void setup() {
	// initialize digital pin LED_BUILTIN as an output.
	pinMode(LED_BUILTIN, OUTPUT); // LED_BUILTIN = 5, this is D22 on the ULX3S
	Serial.begin(115200);
}

// the loop function runs over and over again until power down or reset
void loop() {
	Serial.print("Hello world! Blink on port = ");
	Serial.println(LED_BUILTIN);
	digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
	delay(1000);                       // wait for a second
	digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
	delay(1000);
}
