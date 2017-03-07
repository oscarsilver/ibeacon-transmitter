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

protocol BroadcasterProtocol {
    func startBeacon()
    func stopBeacon()
}

class Broadcaster: NSObject {
    
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
extension Broadcaster: BroadcasterProtocol {
    func startBeacon() {
        guard let region = BeaconRegion(uuidString: "df74a209-78e5-469e-bbe9-db806f76dd07") else { return }
        startAdvertising(forRegion: region)
    }
    
    func stopBeacon() {
        stopAdvertising()
    }
}

//MARK: CBPeripheralManagerDelegate
extension Broadcaster: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn && shouldBroadcast {
            startBeacon()
        } else {
            stopBeacon()
        }
    }
}

//MARK: Private Methods
private extension Broadcaster {
    func startAdvertising(forRegion region: BeaconRegion) {
        peripheralManager.startAdvertising(region.advertisementData)
    }
    
    func stopAdvertising() {
        peripheralManager.stopAdvertising()
    }
}
