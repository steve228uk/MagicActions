//
//  MagicTextField.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 20/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit

class MagicTextField: UITextView, NSTextStorageDelegate {
    
    /// Used to style the text within the text field
    public var textAttributes: [String:Any] = [
        NSForegroundColorAttributeName: UIColor.darkGray,
        NSFontAttributeName: UIFont(name: "Courier", size: 14)!
    ]
    
    @IBOutlet weak var magicButton: MagicButton? {
        didSet {
            magicButton?.addTarget(self, action: #selector(magicButtonTapped), for: .touchUpInside)
        }
    }
    
    var currentAction: MagicAction? {
        didSet {
            // TODO: display the action on the magic button
            guard let action = currentAction else { return  }
            magicButton?.setTitle(action.title, for: .normal)
            magicButton?.isEnabled = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        attributedText = NSAttributedString(string: "", attributes: textAttributes) // doesn't appear to be working
        textStorage.delegate = self
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        attributedText = NSAttributedString(string: "", attributes: textAttributes) // doesn't appear to be working
        textStorage.delegate = self
    }
    
    // Detect if the text has changed and if necessary display the magic action related to it.
    func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
        
        magicButton?.isEnabled = false
        currentAction = nil
        
        let text = textStorage.string.lowercased()
        
        let lines = text.components(separatedBy: "\n")
        guard let words = lines.last?.components(separatedBy: " ") else { return }
        guard let last = words.last?.replacingOccurrences(of: " ", with: "") else { return }
        guard last.characters.count > 0 else { return }
        
        for action in MagicActions.actions {
            guard action.trigger.hasPrefix(last) else {
                currentAction = nil
                continue
            }
            currentAction = action
            return
        }
    }
    
    
    /// Called when the magic button is tapped, triggering that the current action should be performed.
    ///
    /// - parameter button: The button that was tapped
    func magicButtonTapped(button: MagicButton) {
        
        currentAction?.generateAttachment { [unowned self] attachment in
            
            self.textStorage.setAttributedString(self.attributedText.byRemovingLastWord())
            self.textStorage.append(NSAttributedString(string: "\n", attributes: self.textAttributes))
            self.textStorage.append(attachment.rendered)
            self.textStorage.append(NSAttributedString(string: "\n\n", attributes: self.textAttributes))
            
            self.selectedRange = NSMakeRange(self.attributedText.length, 0)
            
        }
        
    }
    
}
