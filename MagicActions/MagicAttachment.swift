//
//  MagicAttachment.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 21/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit

public protocol MagicAttachment {
    
    /// The source content that can be captured and output in NSAttributedString's fragments.
    var source: Any { get }
    
    /// The rendered attributed string. This might be a prerendered image.
    var rendered: NSAttributedString { get }
    
}

// MARK: - NSTextAttachment Compliance

extension NSTextAttachment: MagicAttachment {
    
    public var source: Any {
        return contents
    }
    
    public var rendered: NSAttributedString {
        return NSAttributedString(attachment: self)
    }
    
}
