//
//  MagicButton.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 20/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit

class MagicButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setTitle(MagicActions.buttonTitle, for: [.normal, .disabled])
        isEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle(MagicActions.buttonTitle, for: [.normal, .disabled])
        isEnabled = false
    }

}
