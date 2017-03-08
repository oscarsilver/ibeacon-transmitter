//
//  CBManagerState+isOn.swift
//  ibeacon-transmitter
//
//  Created by Oscar Silver on 2017-03-08.
//  Copyright © 2017 Snowlayer. All rights reserved.
//

import Foundation
import CoreBluetooth

extension CBManagerState {
    var isOn: Bool {
        return self == .poweredOn
    }
}
