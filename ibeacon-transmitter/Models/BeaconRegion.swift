//
//  BeaconRegion.swift
//  ibeacon-transmitter
//
//  Created by Oscar Silver on 2017-03-07.
//  Copyright © 2017 Snowlayer. All rights reserved.
//

import Foundation
import CoreLocation

private let defaultMinorValue: UInt16 = 1
private let defaultMajorValue: UInt16 = 1
private let defaultMeasuredPower: NSNumber = 127

class BeaconRegion: CLBeaconRegion {
    
    let uuid: UUID
    let minorValue: CLBeaconMinorValue
    let majorValue: CLBeaconMajorValue
    
    var advertisementData: [String: Any] {
        let peripheralData = self.peripheralData(withMeasuredPower: defaultMeasuredPower)
        return peripheralData.dictionaryWithValues(forKeys: peripheralData.allKeys as! [String])
    }
    
    init?(uuidString: String, minorValue: CLBeaconMinorValue = defaultMinorValue, majorValue: CLBeaconMajorValue = defaultMajorValue, identifier: String? = Bundle.main.bundleIdentifier) {
        guard
            let identifier = identifier,
            let uuid = UUID(uuidString: uuidString)
        else { return nil }
        self.uuid = uuid
        self.minorValue = minorValue
        self.majorValue = majorValue
        super.init(proximityUUID: uuid, major: majorValue, minor: minorValue, identifier: identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(neededByCompiler)
    }
}
