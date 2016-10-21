//
//  MagicActions.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 20/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Foundation

public class MagicActions {
    
    /// Shared Instance of MagicActions
    public static let shared = MagicActions()
    
    /// Disable to stop including default actions
    public static var registerDefaults = true
    
    /// The text displayed on the title when no magic word is in play
    public static var buttonTitle = "Start Typing..."
    
    /// Stop from being intialized
    fileprivate init() {
        if MagicActions.registerDefaults {
            _actions = [
                MagicAction(title: "Battery", description: "The current battery life", trigger: "battery", attachment: MagicBatteryAttachment())
            ]
        }
    }
    
    /// Actions registered. Default actions are automatically registered but can be disabled.
    fileprivate var _actions = Set<MagicAction>()
    
    /// Actions registered with `MagicActions`. Default actions are automatically registered but can be disabled.
    public static var actions: Set<MagicAction> {
        return shared._actions
    }
    
    /// Register a new action with MagicActions
    ///
    /// - parameter action: The action to be registered
    public static func register(action: MagicAction) {
        shared._actions.insert(action)
    }
    
    /// Register a set of actions with MagicActions
    ///
    /// - parameter actions: The actions to register
    public static func register(actions: Set<MagicAction>) {
        shared._actions.formUnion(actions)
    }
    
}
