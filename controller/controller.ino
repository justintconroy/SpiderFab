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

#define L_STICK 5   // Pin used for left joystick button
#define L_HORZ A2   // Pin used for left joystick horizontal
#define L_VERT A3   // Pin used for left joystick vertical

#define R_STICK 5   // Pin used for right joystick button
#define R_HORZ A1   // Pin used for right joystick horizontal
#define R_VERT A0   // Pin used for right joystick vertical

int8_t speedLevel = 20; //Maximum speed (%) = speedLevel * 5 (units are percent)

void setup() {
  Serial1.begin(9600); // Start serial communication with XBee at 9600 baud
  delay(10);

  Serial1.print("W7001\r\n"); // Set the bit in enable register 0x70 to 0x01

  pinMode(L_TRIG,INPUT_PULLUP); // Enable pullup resistor for left trigger
  pinMode(R_TRIG,INPUT_PULLUP); // Enable pullup resistor for right trigger
  pinMode(L_STICK,INPUT_PULLUP); // Enable pullup resistor for left stick
  pinMode(R_STICK,INPUT_PULLUP); // Enable pullup resistor for right stick
}

void loop() {
  int16_t leftStickVert, rightStickVert;    // We'll store the the analog joystick values here
  int16_t leftStickHorz, rightStickHorz;
  char buf0[10],buf1[10]; // character buffers used to set motor speeds

  // Read joysticks
  // Convert analog value range to motor speeds (in %)
  leftStickVert = (5-(analogRead(L_VERT)/93))*speedLevel;
  leftStickHorz = (5-(analogRead(L_HORZ)/93))*speedLevel;
  rightStickVert = (5-(analogRead(R_VERT)/93))*speedLevel;
  rightStickHorz = (5-(analogRead(R_HORZ)/93))*speedLevel;

  // Build motor 0 buffer
  if(leftStickVert > 90)
  {
    sprintf(buf0,"w 2 1\r\n");
  }
  else if (leftStickVert < -90)
  {
    sprintf(buf0,"w 1 1\r\n");
  }
  else
  {
    sprintf(buf0,"");
    //sprintf(buf0,"LV: %d\n", leftStickVert);
  }

  // Build motor 1 buffer
  if(leftStickHorz > 90)
  {
    sprintf(buf1,"w 3 1\r\n");
  }
  else if (leftStickHorz < -90)
  {
    sprintf(buf1,"w 4 1\r\n");
  }
  else
  {
    //sprintf(buf1,"LH: %d\n", leftStickHorz);
    sprintf(buf1,"");
  }

  // Send motor speeds
  delay(5);
  Serial1.print(buf0);
  delay(5);
  Serial1.print(buf1);
}
