//
//  Label.swift
//  ibeacon-transmitter
//
//  Created by Oscar Silver on 2017-03-07.
//  Copyright © 2017 Snowlayer. All rights reserved.
//

import UIKit

class Label: UILabel {
    init(_ text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(neededByCompiler)
    }
}

//MARK: L10n support
extension Label {
    convenience init(_ text: L10n) {
        self.init(tr(text))
    }
}
