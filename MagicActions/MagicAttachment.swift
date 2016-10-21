//
//  MagicAttachment.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 21/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit

public protocol MagicAttachment {

    var source: Any { get }
    
    var rendered: NSAttributedString { get }
    
}

extension NSTextAttachment: MagicAttachment {
    
    public var source: Any {
        return contents
    }
    
    public var rendered: NSAttributedString {
        return NSAttributedString(attachment: self)
    }
    
}
