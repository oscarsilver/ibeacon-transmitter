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

    fileprivate let broadcaster: BroadcasterProtocol
    fileprivate lazy var transmittingLabel: Label = Label(.idle)
    
    fileprivate lazy var transmissionSwitch: UISwitch = {
        let transmissionSwitch = UISwitch()
        transmissionSwitch.isOn = false
        transmissionSwitch.addTarget(self, action: #selector(transmissionSwitchToggled(_:)), for: .valueChanged)
        return transmissionSwitch
    }()
    
    //MARK: Initialization
    init(broadcaster: BroadcasterProtocol) {
        self.broadcaster = broadcaster
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(neededByCompiler)
    }
    
    //MARK: View Lifecycle
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
        view.addSubview(transmittingLabel)
        
        constrain(view, transmissionSwitch, transmittingLabel) {
            view, transmissionSwitch, transmittingLabel in
            
            transmissionSwitch.center == view.center
            transmittingLabel.centerX == view.centerX
            transmittingLabel.bottom == transmissionSwitch.top - .m20
        }
    }
    
    func toggleTransmission(shouldTransmit: Bool) {
        if shouldTransmit {
            startTransmission()
        } else {
            stopTransmission()
        }
    }
    
    func startTransmission() {
        broadcaster.startBeacon(withUUID: "6C5DF2C4-7256-4563-BA20-A2507EFED9BB")
        transmittingLabel.text = tr(.transmitting)
    }
    
    func stopTransmission() {
        broadcaster.stopBeacon()
        transmittingLabel.text = tr(.idle)
    }
}

