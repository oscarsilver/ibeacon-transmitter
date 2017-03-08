//
//  CBPeripheralManager+isOn.swift
//  ibeacon-transmitter
//
//  Created by Oscar Silver on 2017-03-08.
//  Copyright © 2017 Snowlayer. All rights reserved.
//

import Foundation
import CoreBluetooth

extension CBPeripheralManager {
    var isOn: Bool {
        return state.isOn
    }
}
