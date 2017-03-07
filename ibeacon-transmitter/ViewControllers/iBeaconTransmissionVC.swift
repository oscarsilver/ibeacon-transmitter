//
//  iBeaconTransmissionVC.swift
//  ibeacon-transmitter
//
//  Created by Oscar Silver on 2017-03-07.
//  Copyright © 2017 Snowlayer. All rights reserved.
//

import UIKit
import Cartography

class iBeaconTransmissionVC: UIViewController {

    fileprivate lazy var transmissionSwitch: UISwitch = {
        let transmissionSwitch = UISwitch()
        transmissionSwitch.isOn = false
        transmissionSwitch.addTarget(self, action: #selector(transmissionSwitchToggled(_:)), for: .valueChanged)
        return transmissionSwitch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

//MARK: Selectors
extension iBeaconTransmissionVC {
    func transmissionSwitchToggled(_ transmissionSwitch: UISwitch) {
        toggleTransmission(shouldTransmit: transmissionSwitch.isOn)
    }
}

//MARK: Private Methods
private extension iBeaconTransmissionVC {
    func setupViews() {
        view.addSubview(transmissionSwitch)
        
        constrain(view, transmissionSwitch) {
            view, transmissionSwitch in
            
            transmissionSwitch.center == view.center
        }
    }
    
    func toggleTransmission(shouldTransmit: Bool) {
        
    }
}

