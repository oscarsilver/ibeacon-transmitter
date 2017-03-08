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
    weak var delegate: BroadcasterDelegate? { get set }
}

protocol BroadcasterDelegate: class {
    func transmissionStopped()
    func transmissionStarted()
    func transmissionFailed()
}

class Broadcaster: NSObject {
    fileprivate var currentRegion: BeaconRegion? = nil
    fileprivate lazy var peripheralManager: CBPeripheralManager? = CBPeripheralManager(delegate: self, queue: DispatchQueue.global())
    weak var delegate: BroadcasterDelegate?
}

//MARK: BeaconBroadcasterProtocol
extension Broadcaster: BroadcasterProtocol {
    func startBeacon(withUUID uuidString: String, localName: String) {
        guard let region = BeaconRegion(uuidString: uuidString, localName: localName) else { return }
        currentRegion = region
        
        if let peripheralManager = peripheralManager, peripheralManager.isOn {
            startAdvertising(region: region)
        } else {
            delegate?.transmissionFailed()
        }
    }
    
    func stopBeacon() {
        currentRegion = nil
        stopAdvertising()
    }
}

//MARK: CBPeripheralManagerDelegate
extension Broadcaster: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if let region = currentRegion, peripheral.isOn {
            startAdvertising(region: region)
        } else {
            stopAdvertising()
        }
    }
}

//MARK: Private Methods
private extension Broadcaster {
    func startAdvertising(region: BeaconRegion) {
        peripheralManager?.startAdvertising(region.advertisementData)
        delegate?.transmissionStarted()
    }
    
    func stopAdvertising() {
        peripheralManager?.stopAdvertising()
        delegate?.transmissionStopped()
    }
}
