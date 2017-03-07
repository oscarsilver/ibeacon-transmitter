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
    func startBeacon(withUUID uuidString: String)
    func stopBeacon()
}

class Broadcaster: NSObject {
    fileprivate var shouldBroadcast: Bool = false
    fileprivate var currentRegion: BeaconRegion? = nil
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
    func startBeacon(withUUID uuidString: String) {
        guard let region = BeaconRegion(uuidString: uuidString) else { return }
        currentRegion = region
        shouldBroadcast = true
        startAdvertising(region: region)
    }
    
    func stopBeacon() {
        currentRegion = nil
        shouldBroadcast = false
        stopAdvertising()
    }
}

//MARK: CBPeripheralManagerDelegate
extension Broadcaster: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if let region = currentRegion, peripheral.state == .poweredOn, shouldBroadcast {
            startAdvertising(region: region)
        } else {
            stopAdvertising()
        }
    }
}

//MARK: Private Methods
private extension Broadcaster {
    
    func startAdvertising(region: BeaconRegion) {
        peripheralManager.startAdvertising(region.advertisementData)
    }
    
    func stopAdvertising() {
        peripheralManager.stopAdvertising()
    }
}
