#include <Arduino.h>
#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <BLEScan.h>
#include <BLEAdvertisedDevice.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <math.h>

//Provide the token generation process info.
#include "addons/TokenHelper.h"
//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

//-----------------------BLUETOOTH------------------------------//
#define SERVICE_UUID        "2bab07de-6bdf-11ec-90d6-0242ac120003"
#define CHARACTERISTIC_UUID "0dc1f31b-1388-4557-99cd-4bcacaa792bd"

BLEScan* scan;

//---------------------------WIFI-------------------------------//
// Insert your network credentials
#define WIFI_SSID "hexenwake"
#define WIFI_PASSWORD "QbixHarold32"

//--------------------------FIREBASE----------------------------//
#define API_KEY "AIzaSyAENvOWt6_M8lG5rmfXIjaayiMTtngUhKM"
#define DATABASE_URL "https://fir-flutterlogin-bfc07-default-rtdb.asia-southeast1.firebasedatabase.app/" 

//Define Firebase Data object
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;


//-------------------Conditions-------------------//
//constants
const int output = 2;
const float M_Pwr = -74.5;
const float N = 1;
const int threshold = 400;

unsigned long sendDataPrevMillis = 0;
int count = 0;
float d_dis = 0;
float m_dis = 0;
float rssi = 0;
String my_str;

//beacon variables
int inzone=0;
float b_m_dis = 0;


bool signupOK = false;

//------------------Pin config--------------------//
const int buzzer_pin = 13;
const int pulse = 32;

//--------------------SETUP-----------------------//
void setup() {
  Serial.begin(115200);
  
  pinMode(buzzer_pin, OUTPUT);
  pinMode(pulse, INPUT);
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  activate_wifi_hand_band();
  Initialize_firebase();

  Serial.print("Getting hand band 1 distance..");
  if(Firebase.RTDB.getFloat(&fbdo, "/hand_band/hand band 1/distance")){
      my_str = fbdo.stringData();
      my_str.remove(0, 1);     
      my_str.remove(3, 1);
      d_dis = my_str.toFloat();
      Serial.print("default distance set to: ");
      Serial.println(d_dis);
  }
  WiFi.disconnect(true);
  delay(500);
  Bluetooth_Initialize();
}



void loop() {
  for(int i=0; i<100; i++){
    handband_scanning();
  }
  digitalWrite(buzzer_pin, LOW);

  BLEDevice::deinit(true);
  delay(500);

  activate_wifi_hand_band();
  Initialize_firebase();

  
  if (Firebase.RTDB.setInt(&fbdo, "hand_band_beacon/Hand_Band_01/inzone", inzone)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    
  esp_restart();
}


void Bluetooth_Initialize(){
  BLEDevice::init("Hand_Band_01");
  BLEServer *pServer = BLEDevice::createServer();
  BLEService *pService = pServer->createService(SERVICE_UUID);
  BLECharacteristic *pCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID,BLECharacteristic::PROPERTY_READ |BLECharacteristic::PROPERTY_WRITE);

  pService->start();
  // BLEAdvertising *pAdvertising = pServer->getAdvertising();  // this still is working for backward compatibility
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(true);
  BLEDevice::startAdvertising();
}



void activate_wifi_hand_band(){
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(300);
  }

  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
}


void handband_scanning(){
  Serial.println("Start Scanning ");
  scan = BLEDevice::getScan();
  scan -> setActiveScan(true);
  
  BLEScanResults results = scan -> start(1);
  for(int i=0; i<results.getCount(); i++)
  {
    BLEAdvertisedDevice device = results.getDevice(i);
    String sensorName = results.getDevice(i).getName().c_str();
    String str = "Hand_Band";
    String str_beacon = "HB_beacon";
    
    if(sensorName.startsWith(str)){
      rssi = device.getRSSI();
      Serial.print("RSSI: ");
      Serial.println(rssi);
      m_dis = cal_dis(rssi);
      Serial.print("measured distance: ");
      Serial.println(m_dis);
    }

    if(sensorName.startsWith(str_beacon)){
      rssi = device.getRSSI();
      Serial.print("RSSI: ");
      Serial.println(rssi);
      b_m_dis = cal_dis(rssi);
      Serial.print("measured beacon distance: ");
      Serial.println(b_m_dis);
    }

    if(b_m_dis <= 5 && b_m_dis != 0 ){
      inzone = 1;
    }else{
      inzone = 0;
    }
    
    if(m_dis <= d_dis && m_dis !=0){
      digitalWrite(buzzer_pin, HIGH);
    }else{
      digitalWrite(buzzer_pin, LOW);
    }

    if(m_dis == 0){
      Serial.print("No Hand_band nearby");
    }else if(b_m_dis == 0){
      Serial.print("No Beacon is nearby");
    }  
  }//for(int i=0; i<results.getCount(); i++)
  scan -> clearResults();
  delay(50);
}

void Initialize_firebase(){
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  
  if (Firebase.signUp(&config, &auth, "", "")) {
    Serial.println("ok");
    signupOK = true;
  }
  else {
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  Serial.println("------------------------------------");
  Serial.println("Connected...");
}

//
float cal_dis(float x){
  float cal_d;
  cal_d = pow(10,(M_Pwr - x)/(10*N));
  return cal_d;
}
