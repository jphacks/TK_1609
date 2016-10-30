//
//  ViewController.swift
//  jphacks
//
//  Created by Shinnosuke Komiya on 2016/10/29.
//  Copyright © 2016年 DesignCat Inc. All rights reserved.
//

import Cocoa
import Alamofire

class ViewController: NSViewController, BLEDeviceClassDelegate {


    var bleBaseClass: BLEBaseClass?
    var Device: BLEDeviceClass?
    @IBOutlet var scanBtn: NSButton?
    
    var leftOrRight: Int = 0
    var pressureSensor: Int = 0
    var bendThumb: Int = 0
    var bendIndex: Int = 0
    var bendMiddle: Int = 0
    var bendRing: Int = 0
    var bendPinkie: Int = 0
    var accelX: Int = 0
    var accelY: Int = 0
    var accelZ: Int = 0
    var gyroX: Int = 0
    var gyroY: Int = 0
    var gyroZ: Int = 0
    
    var parameters:Parameters = [:]
    var arguments = [Any]()
    var timer: Timer? = nil
    
    let oscClient = F53OSCClient.init()
    var csvData=[[String]]()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oscClient.host = "http://127.0.0.1"
        oscClient.port = 7890

        initBle()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func initBle() {
        //初期化
        bleBaseClass = BLEBaseClass()
        print("initialize BLE", terminator: "")
        bleBaseClass?.scanDevices(nil)
        //connectBle()
    }

    func connectBle() {
        
        //接続
        Device = bleBaseClass?.connectService(UUID_VSP_SERVICE_BLESerial2)
        if((Device) != nil) {
            print("connected!", terminator: "")
            bleBaseClass?.scanStop() //スキャンを停止
            Device?.delegate = self
            
            let tx: CBCharacteristic = Device!.getCharacteristic(UUID_VSP_SERVICE_BLESerial2, characteristic: UUID_TX_BLESerial2)
            if tx != NSNull() {
                print(tx)
                Device?.notifyRequest(tx)
                print("connect succeed", terminator: "")
            }
        } else {
            print("connect refused", terminator: "")
//            let alert: UIAlertController = UIAlertController(title: "connect refused", message: "please retry", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
//                (action: UIAlertAction) -> Void in
//                self.connectBle()
//            }))
//            super.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func stopBle() {
        if((Device) != nil) {
            bleBaseClass?.disconnectService(UUID_VSP_SERVICE_BLESerial2)
            bleBaseClass?.scanDevices(nil)
            print("stopped ble", terminator: "")
            leftOrRight = 0
            pressureSensor = 0
            bendThumb = 0
            bendIndex = 0
            bendMiddle = 0
            bendRing = 0
            bendPinkie = 0
            accelX = 0
            accelY = 0
            accelZ = 0
            gyroX = 0
            gyroY = 0
            gyroZ = 0
            
            Device = nil
        }
    }

    //------------------------------------------------------------------------------------------
    //	readもしくはindicateもしくはnotifyにてキャラクタリスティックの値を読み込んだ時に呼ばれる
    //------------------------------------------------------------------------------------------
    @objc(didUpdateValueForCharacteristic:Characteristic:) func didUpdateValue(forCharacteristic device: BLEDeviceClass!, characteristic: CBCharacteristic!) {
        //if (device == Device)	{
        //	キャラクタリスティックを扱う為のクラスを取得し
        //	通知されたキャラクタリスティックと比較し同じであれば
        //	bufに結果を格納
        print("didUpdateValue")
        
        //iPhone->Device
        let rx: CBCharacteristic = Device!.getCharacteristic(UUID_VSP_SERVICE_BLESerial2, characteristic: UUID_RX_BLESerial2)
        print(rx)
        if (characteristic == rx)	{
            //uint8_t*	buf = (uint8_t*)[characteristic.value bytes]; //bufに結果が入る
            //NSLog(@"value=%@",characteristic.value);
            return;
        }
        
        //Device->iPhone
        let tx:CBCharacteristic = Device!.getCharacteristic(UUID_VSP_SERVICE_BLESerial2, characteristic: UUID_TX_BLESerial2)
        if (characteristic == tx)	{
            
            //ここでBLEから配列を受け取る
            let buf = characteristic.value
            print(buf)
            
            

            print("left or right")
            leftOrRight = Int((buf?[0])!)
            print(leftOrRight)
            
            print("accelX:")
            accelX = Int((buf?[1])!)
            print(accelX)
            print("accelY:")
            accelY = Int((buf?[2])!)
            print(accelY)
            print("accelZ:")
            accelZ = Int((buf?[3])!)
            print(accelZ)
            
            print("gyroX:")
            gyroX = Int((buf?[4])!)
            print(gyroX)
            print("gyroY:")
            gyroY = Int((buf?[5])!)
            print(gyroY)
            print("gyroZ:")
            gyroZ = Int((buf?[6])!)
            print(gyroZ)
            
            print("pressure:")
            pressureSensor = Int((buf?[7])!)
            print(pressureSensor)
            
            print("bendPinkie:")
            bendPinkie = Int((buf?[8])!)
            print(bendPinkie)
            print("bendRing:")
            bendRing = Int((buf?[9])!)
            print(bendRing)
            print("bendMiddle:")
            bendMiddle = Int((buf?[10])!)
            print(bendMiddle)
            print("bendIndex:")
            bendIndex = Int((buf?[11])!)
            print(bendIndex)
            print("bendThumb:")
            bendThumb = Int((buf?[12])!)
            print(bendThumb)
            
            arguments = [leftOrRight, accelX, accelY, accelZ, gyroX, gyroY, gyroZ, pressureSensor, bendThumb, bendIndex, bendMiddle, bendRing, bendPinkie]
            
            parameters = ["leftOrRight" : leftOrRight,
                          "accelX" : accelX,
                          "accelY" : accelY,
                          "accelZ" : accelZ,
                          "gyroX" : gyroX,
                          "gyroY" : gyroY,
                          "gyroZ" : gyroZ,
                          "pressureSensor" :pressureSensor,
                          "bendThumb" :bendThumb,
                          "bendIndex" : bendIndex,
                          "bendMiddle" : bendMiddle,
                          "bendRing" : bendRing,
                          "bendPinkie" : bendPinkie
            ]
            
            
            return;
        }
    }
    
    
    func sendToOF() {
        
        
        
        
        
        //let message = F53OSCMessage(addressPattern: "/osc", arguments: arguments)
        //oscClient.send(message)
        //print("Sent '\(message)' to \(oscClient.host):\(oscClient.port)")
        
//        Alamofire.request("http://127.0.0.1:7890", method: .post, parameters: parameters, encoding:  URLEncoding.default)
//            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
//                
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//        }

    }
    @IBAction func connectBleBtn(sender: NSButton) {
    
        if (scanBtn?.title == "Scan") {
            connectBle()
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.sendToOF), userInfo: nil, repeats: true)
            scanBtn?.title = "Stop"
        } else {
            stopBle()
            timer?.invalidate()
            scanBtn?.title = "Scan"
        }
    }


}

