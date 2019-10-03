/*
 * Inspired by the Arduino IDE "debounce" sketch.
 */
const int buttons[5] = {A0,A1,A2,A3,9};
int buttonState[5] = {LOW,LOW,LOW,LOW,LOW};
int lastButtonState[5] = {LOW,LOW,LOW,LOW,LOW};

// the last time the output pin was toggled
unsigned long lastDebounceTime[4] = {0,0,0,0};
unsigned long debounceDelay = 50;

void setup()
{

  Serial.begin(57600);

  for (int i=0; i<5; i++)
  {
    pinMode(buttons[i], INPUT);
  }
}

void loop()
{
  debounce_cmd(0, "w 4 1", spiderCmd);
  debounce_cmd(1, "w 1 1", spiderCmd);
  debounce_cmd(2, "w 3 1", spiderCmd);
  debounce_cmd(3, "w 2 1", spiderCmd);
  debounce_cmd(4, "", gdsCmd);

}

// Execute some function when a button is pressed. This function
// has some built in delays to handle 
void debounce_cmd(int button, char cmd[50], void (*cmdFcn)(char*))
{
  // read the state of the switch into a local variable:
  int reading = digitalRead(buttons[button]);

  // check to see if you just pressed the button
  // (i.e. the input went from LOW to HIGH), and you've waited long enough
  // since the last press to ignore any noise:

  // If the switch changed, due to noise or pressing:
  if (reading != lastButtonState[button])
  {
    // reset the debouncing timer
    lastDebounceTime[button] = millis();
  }

  if ((millis() - lastDebounceTime[button]) > debounceDelay)
  {
    // whatever the reading is at, it's been there for longer than the debounce
    // delay, so take it as the actual current state:

    // if the button state has changed:
    if (reading != buttonState[button])
    {
      buttonState[button] = reading;

      // only toggle the LED if the new button state is HIGH
      if (buttonState[button] == HIGH)
      {
        cmdFcn(cmd);
      }
    }
  }
  // save the reading. Next time through the loop, it'll be the lastButtonState:
  lastButtonState[button] = reading;
}

void spiderCmd(char* cmd)
{
  Serial.println(cmd);
}

int gds_state = 1;
void gdsCmd(char* cmd)
{
  switch (gds_state)
  {
    case 0:
      spiderCmd("w 21 0");
      gds_state++;
      break;
    case 1:
      spiderCmd("w 21 1");
      gds_state++;
      break;
    case 2:
      spiderCmd("w 21 0");
      gds_state++;
      break;
    case 3:
      spiderCmd("w 21 2");
    default:
      gds_state= 0;
      break;
  }
}
