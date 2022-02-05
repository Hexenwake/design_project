#include <Arduino.h>
#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <BLEScan.h>
#include <BLEAdvertisedDevice.h>

//-----------------------BLUETOOTH------------------------------//
#define SERVICE_UUID        "2bab07de-6bdf-11ec-90d6-0242ac120003"
#define CHARACTERISTIC_UUID "0dc1f31b-1388-4557-99cd-4bcacaa792bd"

BLEScan* scan;


void setup() {
  Serial.begin(115200);  
  Bluetooth_Initialize();
}

void loop() {
}


void Bluetooth_Initialize(){
  BLEDevice::init("HB_beacon_01");
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
