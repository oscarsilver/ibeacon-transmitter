//
//  BeaconBroadcaster.swift
//  ibeacon-transmitter
//
//  Created by Oscar Silver on 2017-03-07.
//  Copyright © 2017 Snowlayer. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreLocation

protocol BeaconBroadcasterProtocol {
    func startBroadcasting()
    func stopBroadcasting()
}

class BeaconBroadcaster: NSObject {
    
    fileprivate var shouldBroadcast: Bool = false
    fileprivate var peripheralManager: CBPeripheralManager!
    
    //MARK: Initialization
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: DispatchQueue.global())
        assert(peripheralManager != nil)
    }
}

//MARK: BeaconBroadcasterProtocol
extension BeaconBroadcaster: BeaconBroadcasterProtocol {
    func startBroadcasting() {
        var isAdvertising = peripheralManager.isAdvertising
        
        if isAdvertising {
            peripheralManager.stopAdvertising()
            isAdvertising = false
        }
        
        guard let region = BeaconRegion(uuidString: "df74a209-78e5-469e-bbe9-db806f76dd07") else { return }
        peripheralManager.startAdvertising(region.advertisementData)
    }
    
    func stopBroadcasting() {
        peripheralManager.stopAdvertising()
    }
}

//MARK: CBPeripheralManagerDelegate
extension BeaconBroadcaster: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn && shouldBroadcast {
            startBroadcasting()
        } else {
            stopBroadcasting()
        }
    }
}
