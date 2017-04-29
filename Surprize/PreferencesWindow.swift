//
//  PreferencesWindow.swift
//  Surprize
//
//  Created by Keegan Campbell on 4/28/17.
//  Copyright © 2017 Keegan Campbell. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    
    var delegate: PreferencesWindowDelegate?
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func windowWillClose(_ notification: Notification) {
        // save relevant data to user defaults here
        let defaults = UserDefaults.standard
        //defaults.setValue(cityTextField.stringValue, forKey: "city")
        delegate?.preferencesDidUpdate()
    }
    
    
}
