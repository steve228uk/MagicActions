//
//  MagicAction.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 20/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit

/// Called when the magic word is activated and should generate and return a text attachment.
public typealias MagicAttachmentGenerator = (@escaping (MagicAttachment) -> Void) -> Void

public class MagicAction: Hashable {
    
    /// The title that will be displayed with the action.
    public var title: String
    
    /// The description that explains what the action does.
    public var description: String
    
    /// The regex pattern that should trigger the action. This cannot be the same as another in the set.
    public var trigger: String
    
    /// The generator to be used to create the NSTextAttachment.
    private var generator: MagicAttachmentGenerator?
    
    /// Attachments can be preset if we always know what it's going to be. For example we may always add a specific image such as a separtor or start an ordered list.
    private var attachment: MagicAttachment?
    
    /// Complies with `Hashable` so we can use `MagicAction` in sets.
    public var hashValue: Int {
        return trigger.hashValue
    }
    
    /// Complies with `Equatable`
    public static func == (lhs: MagicAction, rhs: MagicAction) -> Bool {
        return lhs.trigger == rhs.trigger && lhs.title == rhs.title
    }
    
    /// Create a new `MagicAction` with a dynamic generator.
    ///
    /// - parameter title:       The title that the will be displayed in the `MagicBar`.
    /// - parameter description: The description that will be displayed in the `MagicBar`.
    /// - parameter generator:   A generator that will create and return a `NSTextAttachment`
    ///
    /// - returns: A new `MagicAction`
    public init(title: String, description: String, trigger: String, generator: @escaping MagicAttachmentGenerator) {
        self.title = title
        self.description = description
        self.trigger = trigger
        self.generator = generator
    }
    
    /// Create a new `MagicAction` with a static attachment.
    ///
    /// - parameter title:       The title that the will be displayed in the `MagicBar`.
    /// - parameter description: The description that will be displayed in the `MagicBar`.
    /// - parameter attachment:  A static attachment that will be inserted into the text field.
    ///
    /// - returns: A new `MagicAction`
    public init(title: String, description: String, trigger: String, attachment: NSTextAttachment) {
        self.title = title
        self.description = description
        self.trigger = trigger
        self.attachment = attachment
    }
    
    /// Generate the attachment that's linked to the action
    ///
    /// - parameter completed: Callback when the attachment has finished generating
    internal func generateAttachment(completed: @escaping (MagicAttachment) -> Void) {
        guard let attachment = attachment else {
            generator?() { completed($0) }
            return
        }
        
        completed(attachment)
    }
    
}
