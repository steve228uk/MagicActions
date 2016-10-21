//
//  MagicBatteryAttachment.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 21/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit

public class MagicBatteryAttachment: NSTextAttachment {

    override public var source: Any {
        get {
            UIDevice.current.isBatteryMonitoringEnabled = true
            return "🔋 \(Int(UIDevice.current.batteryLevel * 100))%"
        }
    }
    
    override public var rendered: NSAttributedString {
        
        // Create a UIView
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 44))
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        
        // Set the label
        let label = UILabel(frame: view.bounds.insetBy(dx: 8, dy: 8))
        label.text = source as? String
        view.addSubview(label)
        
        // Create an image from UIView
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }

        return NSAttributedString(attachment: self)
        
    }
    
}
