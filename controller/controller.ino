/* Wireless Joystick Tank Steering Robot Example
 * by: Alex Wende
 * SparkFun Electronics
 * date: 9/28/16
 * 
 * license: Creative Commons Attribution-ShareAlike 4.0 (CC BY-SA 4.0)
 * Do whatever you'd like with this code, use it for any purpose.
 * Please attribute and keep this license.
 * 
 * This is example code for the Wireless Joystick to control a robot
 * using XBee. Plug the first Xbee into the Wireless Joystick board,
 * and connect the second to the SparkFun Serial Motor Driver.
 * 
 * Moving the left and right joystick up and down will change the
 * speed and direction of motor 0 and motor 1. The left trigger will
 * reduce the maximum speed by 5%, while the right trigger button
 * will increase the maximum speed by 5%.
 * 
 * Connections to the motor driver is as follows:
 * XBee - Motor Driver
 *   5V - VCC
 *  GND - GND
 * DOUT - RX
 * 
 * Power the motor driver with no higher than 11V!
 */

#define L_TRIG 6        // Pin used for left trigger
#define R_TRIG 3        // Pin used for right trigger
#define L_JOYSTICK A3   // Pin used for left joystick
#define R_JOYSTICK A0   // Pin used for right joystick

int8_t speedLevel = 20; //Maximum speed (%) = speedLevel * 5 (units are percent)

void setup() {  
  Serial1.begin(9600); // Start serial communication with XBee at 9600 baud
  delay(10);

  Serial1.print("W7001\r\n"); // Set the bit in enable register 0x70 to 0x01

  pinMode(L_TRIG,INPUT_PULLUP); // Enable pullup resistor for left trigger
  pinMode(R_TRIG,INPUT_PULLUP); // Enable pullup resistor for right trigger
}

void loop() {
  int16_t leftStick, rightStick;    // We'll store the the analog joystick values here
  char buf0[10],buf1[10]; // character buffers used to set motor speeds

  // Reduce top speed
  if(digitalRead(L_TRIG) == 0)
  {
    speedLevel -= 2;
    if(speedLevel < 2) speedLevel = 2;
    while(digitalRead(L_TRIG) == 0)
    {
      delay(2);
    }
  }
  // Increase top speed
  if(digitalRead(R_TRIG) == 0)
  {
    speedLevel += 2;
    if(speedLevel > 20) speedLevel = 20;
    while(digitalRead(R_TRIG) == 0)
    {
      delay(2);
    }
  }

  // Read joysticks
  // Convert analog value range to motor speeds (in %)
  leftStick = (5-(analogRead(L_JOYSTICK)/93))*speedLevel;
  rightStick = (5-(analogRead(R_JOYSTICK)/93))*speedLevel;

  // Build motor 0 buffer
  if(leftStick > 0)
  {
    sprintf(buf0,"M0F%d\r\n",leftStick);
  }
  else
  {
    sprintf(buf0,"M0R%d\r\n",abs(leftStick));
  }

  // Build motor 1 buffer
  if(rightStick > 0)
  {
    sprintf(buf1,"M1F%d\r\n",rightStick);
  }
  else
  {
    sprintf(buf1,"M1R%d\r\n",abs(rightStick));
  }

  // Send motor speeds
  delay(5);
  Serial1.print(buf0);
  delay(5);
  Serial1.print(buf1);
}
