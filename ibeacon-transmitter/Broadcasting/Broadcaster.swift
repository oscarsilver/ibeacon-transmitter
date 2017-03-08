//
//  Broadcaster.swift
//  ibeacon-transmitter
//
//  Created by Oscar Silver on 2017-03-07.
//  Copyright © 2017 Snowlayer. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreLocation

protocol BroadcasterProtocol {
    func startBeacon(withUUID uuidString: String, localName: String)
    func stopBeacon()
    
    var delegate: BroadcasterDelegate? { get set }
}

protocol BroadcasterDelegate {
    func transmissionStopped()
    func transmissionStarted()
    func transmissionFailed()
}

class Broadcaster: NSObject {
    fileprivate var shouldBroadcast: Bool = false
    fileprivate var currentRegion: BeaconRegion? = nil
    fileprivate var peripheralManager: CBPeripheralManager!
    
    var delegate: BroadcasterDelegate?
    
    //MARK: Initialization
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: DispatchQueue.global())
        assert(peripheralManager != nil)
    }
}

//MARK: BeaconBroadcasterProtocol
extension Broadcaster: BroadcasterProtocol {
    func startBeacon(withUUID uuidString: String, localName: String) {
        guard let region = BeaconRegion(uuidString: uuidString, localName: localName) else { return }
        currentRegion = region
        shouldBroadcast = true
        
        if peripheralManager.state == .poweredOn {
            startAdvertising(region: region)
        } else {
            delegate?.transmissionFailed()
        }
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
        delegate?.transmissionStarted()
    }
    
    func stopAdvertising() {
        peripheralManager.stopAdvertising()
        delegate?.transmissionStopped()
    }
}
