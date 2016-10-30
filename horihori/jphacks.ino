/*
   debug mode settings
*/
//#define DEBUG_MODE
#undef DEBUG_MODE

/* 6D sensor settings
   mpu9150の方をaz, gy,gz を反転させる
   RIGHT: green MPU9150 option 0
   LEFT: blue MPU9250 option 1
*/
#define HAND 1
#define ACC_LSB  16384 // LSB/g
#define GYRO_LSB  131 // LSB/(°/s)

#include "I2Cdev.h"
#include "MPU6050_6Axis_MotionApps20.h"
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
#include "Wire.h"
#endif

MPU6050 mpu;
int atsuryoku = 0;
int mage1 = 0;//小指
int mage2 = 0;//薬指
int mage3 = 0;//中指
int mage4 = 0;//人差し指
int mage5 = 0;//親指

// MPU control/status vars
bool dmpReady = false;  // set true if DMP init was successful
uint8_t mpuIntStatus;   // holds actual interrupt status byte from MPU
uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
uint16_t fifoCount;     // count of all bytes currently in FIFO
uint8_t fifoBuffer[64]; // FIFO storage buffer

volatile bool mpuInterrupt = false;     // indicates whether MPU interrupt pin has gone high
void dmpDataReady() {
  mpuInterrupt = true;
}

int16_t ax_row, ay_row, az_row;
int16_t gx_row, gy_row, gz_row;
float ax, ay, az;
float gx, gy, gz;

/*
   Adafruit settings
*/
#include <Adafruit_NeoPixel.h>
#define PIN 6
#define LED_NUM 19
#define FINGER_LED_NUM 7
#define CIRCLE_LED_NUM 12

Adafruit_NeoPixel strip = Adafruit_NeoPixel(LED_NUM, PIN, NEO_GRB + NEO_KHZ800);

/*
   color settings
*/
int circle_led_index = 0;
int finger_led_index = 0;
int ble_colors[LED_NUM][3] = {
  {255, 0, 0},
  {255, 0, 0},
  {0, 255, 0},
  {0, 255, 0},
  {0, 0, 255},
  {0, 0, 255},
  {255, 0, 0},
  {255, 0, 0},
  {0, 255, 0},
  {0, 255, 0},
  {0, 0, 255},
  {0, 0, 255},
  {255, 0, 0},
  {255, 0, 0},
  {0, 255, 0},
  {0, 255, 0},
  {0, 0, 255},
  {0, 0, 255},
  {255, 255, 255},
};
//int f_atsu_colors[LED_NUM][3] = {
//  {255, 255, 0},
//  {255, 255, 0},
//  {255, 0, 255},
//  {255, 0, 255},
//  {0, 255, 255},
//  {0, 255, 255},
//  {255, 0, 0},
//  {255, 0, 0},
//  {0, 0, 255},
//  {0, 0, 255},
//  {255, 0, 0},
//  {255, 0, 0},
//  {255, 255, 255},
//  {255, 255, 255},
//  {255, 200, 200},
//  {255, 200, 200},
//  {200, 200, 255},
//  {200, 200, 255},
//};
// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
uint32_t Wheel(byte WheelPos)
{
  WheelPos = 255 - WheelPos;
  if (WheelPos < 85)
  {
    return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  else if (WheelPos < 170)
  {
    WheelPos -= 85;
    return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  else
  {
    WheelPos -= 170;
    return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
  }
}
/*
   BLE settings
*/
int rsvData = 0;

/*
   timer settings
*/
#include "MsTimer2.h"
//16000000/256*0.5
//OCR1 = 31250

long previousMillis = 0;
unsigned long currentMillis;

bool sensor_interrupt_flag = false;

int timer_count_master = 0;
int timer_count = 0;

int circle_interval_time = 5;
int finger_interval_time = 5;

void led_timer() {
  if (rsvData == 1) {
    if (timer_count == (255)) {
      timer_count = 0;
    }
    if (sensor_interrupt_flag == false) {
      strip.setBrightness(20);
      for (int i = 0; i < strip.numPixels(); i++) {
        strip.setPixelColor(i, Wheel((i + timer_count) & 255));
      }
    }
  }
  else if (rsvData == 2) {
    if (timer_count == LED_NUM) {
      timer_count = 0;
    }
    if (sensor_interrupt_flag == false) {
      for (int i = 0; i < LED_NUM; i++) {
        int j = i + timer_count;
        if (j >=  LED_NUM) {
          j -= LED_NUM;
        }
        strip.setPixelColor(i, ble_colors[j][0], ble_colors[j][1], ble_colors[j][2]);
      }
      strip.setBrightness(20);
    }
  }
  else if (rsvData == 3) {
    if (timer_count >= 10) {
      timer_count = 0;
    }
    if (sensor_interrupt_flag == false) {
      // 色
      for (int i = 0; i < LED_NUM; i++) {
        if (i < 12) {
          strip.setPixelColor(i, 255, 255, 0);

        }
        else {
          strip.setPixelColor(i, 0, 0, 255);
        }
      }
      // 光らせるか
      if (timer_count < 3) {
        strip.setBrightness(255);
      }
      else if (timer_count < 10) {
        strip.setBrightness(0);
      }
    }
  }
  strip.show();
  timer_count++;
  timer_count_master++;
  if (timer_count_master == 100) {
    timer_count_master = 0;
  }
  if ((timer_count_master % finger_interval_time) == 0) {
    finger_led_index++;
  }
  if ((timer_count_master % circle_interval_time) == 0) {
    circle_led_index++;
  }
  if (finger_led_index == FINGER_LED_NUM) {
    finger_led_index = 0;
  }
  if (circle_led_index == CIRCLE_LED_NUM) {
    circle_led_index = 0;
  }
#ifdef DEBUG_MODE
  //  Serial.print("quat\t");
  //  Serial.print(ax_row);
  //  Serial.print("\t");
  //  Serial.print(ay_row);
  //  Serial.print("\t");
  //  Serial.print(az_row);
  //  Serial.print("\t");
  //  Serial.print(gx_row);
  //  Serial.print("\t");
  //  Serial.print(gy_row);
  //  Serial.print("\t");
  //  Serial.print(gz_row);
  //  Serial.print("\n");
  Serial.print(atsuryoku);
  Serial.print("\t");
  Serial.print(mage1);
  Serial.print("\t");
  Serial.print(mage2);
  Serial.print("\t");
  Serial.print(mage3);
  Serial.print("\t");
  Serial.print(mage4);
  Serial.print("\t");
  Serial.print(mage5);
  Serial.print("\n");
#else
  //BLEで送ってるところ
  Serial.write(HAND); // 右0 左1
  Serial.write(1); // 右0 左1
  Serial.write(2); // 右0 左1
  Serial.write(3); // 右0 左1
  Serial.write(4); // 右0 左1
  Serial.write(5); // 右0 左1
  //  Serial.write(ax_row);
  //  Serial.write(ay_row);
  //  Serial.write(az_row);
  //  Serial.write(gx_row);
  //  Serial.write(gy_row);
  //  Serial.write(gz_row);
  //  Serial.write(atsuryoku);
  //  Serial.write(mage1);
  //  Serial.write(mage2);
  //  Serial.write(mage3);
  //  Serial.write(mage4);
  //  Serial.write(mage5);
#endif

}

void setup() {
  // Adafruit
  strip.begin();
  // join I2C bus
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
  Wire.begin();
  TWBR = 24; // 400kHz I2C clock (200kHz if CPU is 8MHz)
#elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
  Fastwire::setup(400, true);
#endif

  // initialize serial port
#ifdef DEBUG_MODE
  Serial.begin(115200);
  while (!Serial);
#else
  Serial.begin(9600);
#endif

  // mpu
  mpu.initialize();
  while (Serial.available());
  devStatus = mpu.dmpInitialize();

  // supply my own gyro offsets here, scaled for min sensitivity
  mpu.setXGyroOffset(0);
  mpu.setYGyroOffset(0);
  mpu.setZGyroOffset(0);

  if (devStatus == 0) {
    mpu.setDMPEnabled(true);
    attachInterrupt(0, dmpDataReady, RISING);
    mpuIntStatus = mpu.getIntStatus();
    dmpReady = true;
    packetSize = mpu.dmpGetFIFOPacketSize();
  } else {
    // ERROR!
    // 1 = initial memory load failed
    // 2 = DMP configuration updates failed
    // (if it's going to break, usually the code will be 1)
    //        Serial.print(F("DMP Initialization failed (code "));
    //        Serial.print(devStatus);
    //        Serial.println(F(")"));
  }
  strip.show();

  // timer
  MsTimer2::set(10, led_timer);
  MsTimer2::start();
}



// ================================================================
// ===                    MAIN PROGRAM LOOP                     ===
// ================================================================
void loop() {
  // if programming failed, don't try to do anything
  if (!dmpReady) {
    return;
  }
  // wait for MPU interrupt or extra packet(s) available
  while (!mpuInterrupt && fifoCount < packetSize) {
  }
  // reset interrupt flag and get INT_STATUS byte
  mpuInterrupt = false;
  mpuIntStatus = mpu.getIntStatus();
  // get current FIFO count
  fifoCount = mpu.getFIFOCount();
  // check for overflow (this should never happen unless our code is too inefficient)
  if ((mpuIntStatus & 0x10) || fifoCount == 1024) {
    // reset so we can continue cleanly
    mpu.resetFIFO();
    //        Serial.println(F("FIFO overflow!"));
    // otherwise, check for DMP data ready interrupt (this should happen frequently)
  } else if (mpuIntStatus & 0x02) {
    // wait for correct available data length, should be a VERY short wait
    while (fifoCount < packetSize) {
      fifoCount = mpu.getFIFOCount();
    }
    // read a packet from FIFO
    mpu.getFIFOBytes(fifoBuffer, packetSize);
    // track FIFO count here in case there is > 1 packet available
    // (this lets us immediately read more without waiting for an interrupt)
    fifoCount -= packetSize;
    mpu.getMotion6(&ax_row, &ay_row, &az_row, &gx_row, &gy_row, &gz_row);
    if (HAND == 1) {
      az_row = -az_row;
      gy_row = -gy_row;
      gz_row = -gz_row;
    }
    //    ax = float(ax_row) / ACC_LSB;
    //    ay = float(ay_row) / ACC_LSB;
    //    az = float(az_row) / ACC_LSB;
    //    gx = float(gx_row) / GYRO_LSB;
    //    gy = float(gy_row) / GYRO_LSB;
    //    gz = float(gz_row) / GYRO_LSB;
    atsuryoku = analogRead(A0);
    mage1 = analogRead(A1);//小指
    mage2 = analogRead(A2);//薬指
    mage3 = analogRead(A3);//中指
    mage4 = analogRead(A6);//人差し指
    mage5 = analogRead(A7);//親指

    // BLE Reading
    if (Serial.available() > 0) {
      rsvData = Serial.read();
      timer_count = 0;
    }
    if (atsuryoku < 250) {
      circle_interval_time = 5;
      finger_interval_time = 5;
      sensor_interrupt_flag = true;
      for (int i = 0; i < CIRCLE_LED_NUM; i++) {
        if (i == circle_led_index) {
          strip.setPixelColor(i, 255, 255, 255);
        }
        else {
          strip.setPixelColor(i, 0, 0, 0);
        }
      }
      for (int i = 0; i < FINGER_LED_NUM; i++) {
        if (i == finger_led_index) {
          strip.setPixelColor(CIRCLE_LED_NUM + i, 255, 255, 255);
        }
        else {
          strip.setPixelColor(CIRCLE_LED_NUM + i, 0, 0, 0);
        }
      }
      strip.setBrightness(200);
      strip.show();
    }
    else if (mage5 > 400) {
      circle_interval_time = 5;
      finger_interval_time = 5;
      sensor_interrupt_flag = true;
      for (int i = 0; i < CIRCLE_LED_NUM; i++) {
        if (i == circle_led_index) {
          strip.setPixelColor(i, 0, 0, 255);
        }
        else {
          strip.setPixelColor(i, 0, 0, 0);
        }
      }
      for (int i = 0; i < FINGER_LED_NUM; i++) {
        if (i == finger_led_index) {
          strip.setPixelColor(CIRCLE_LED_NUM + i, 0, 0, 255);
        }
        else {
          strip.setPixelColor(CIRCLE_LED_NUM + i, 0, 0, 0);
        }
      }
      strip.setBrightness(255);
      strip.show();
    }
    else if (mage4 > 400) {
      circle_interval_time = 1;
      finger_interval_time = 3;
      sensor_interrupt_flag = true;
      for (int i = 0; i < CIRCLE_LED_NUM; i++) {
        if (i == circle_led_index) {
          strip.setPixelColor(i, 255, 0, 0);
        }
        else {
          strip.setPixelColor(i, 0, 0, 0);
        }
      }
      for (int i = 0; i < FINGER_LED_NUM; i++) {
        if (i == finger_led_index) {
          strip.setPixelColor(CIRCLE_LED_NUM + i, 0, 0, 255);
        }
        else {
          strip.setPixelColor(CIRCLE_LED_NUM + i, 0, 0, 0);
        }
      }
      strip.setBrightness(255);
      strip.show();
    }
    
    else if (mage3 > 400) {
      circle_interval_time = 1;
      finger_interval_time = 3;
      sensor_interrupt_flag = true;
      for (int i = 0; i < CIRCLE_LED_NUM; i++) {
        if (i == circle_led_index) {
          strip.setPixelColor(i, 255, 0, 0);
        }
        else {
          strip.setPixelColor(i, 0, 0, 0);
        }
      }
      for (int i = 0; i < FINGER_LED_NUM; i++) {
        if (i == finger_led_index) {
          strip.setPixelColor(LED_NUM - 1 - i, 0, 0, 255);
        }
        else {
          strip.setPixelColor(LED_NUM - 1 - i, 0, 0, 0);
        }
      }
      strip.setBrightness(255);
      strip.show();
    }
    else if (rsvData != 0) {
      sensor_interrupt_flag = false;
    }
    else {
      sensor_interrupt_flag = false;
      strip.setBrightness(0);
      strip.show();
    }
  }
}
