//
//  NSAttributedString + RemoveLastWord.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 20/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    /// Create a new attributed string by removing the last word
    ///
    /// - returns: The newly create attributed string
    func byRemovingLastWord() -> NSAttributedString {
        
        let lines = string.components(separatedBy: "\n")
        
        if let words = lines.last?.components(separatedBy: " ") {
            if let last = words.last {
                return attributedSubstring(from: NSMakeRange(0, self.length - last.characters.count))
            }
        }
        
        return self
    }
    
}
