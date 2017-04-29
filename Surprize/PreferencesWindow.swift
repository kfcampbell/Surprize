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
    
    @IBOutlet weak var saveImagesToDiskCheckBox: NSButton!
    @IBOutlet weak var imageSaveLocationTextField: NSTextField!
    @IBOutlet weak var searchQueriesTextField: NSTextField!
    @IBOutlet weak var screenWidthTextField: NSTextField!
    @IBOutlet weak var screenHeightTextField: NSTextField!
    @IBOutlet weak var changeFrequencySlider: NSSlider!
    
    var delegate: PreferencesWindowDelegate?
    
    let constants = Constants()
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }

    @IBAction func selectSavedImageLocationButtonClicked(_ sender: NSButton) {
        
        let chooseFolderDialog = NSOpenPanel()
        chooseFolderDialog.title = "Choose a folder"
        chooseFolderDialog.showsResizeIndicator = true
        chooseFolderDialog.showsHiddenFiles = false
        chooseFolderDialog.canChooseDirectories = true
        chooseFolderDialog.canCreateDirectories = true
        chooseFolderDialog.allowsMultipleSelection = false
        chooseFolderDialog.allowedFileTypes = [""]
        
        if (chooseFolderDialog.runModal() == NSModalResponseOK) {
            let chosenFilePath = chooseFolderDialog.url
            
            if (chosenFilePath != nil) {
                let path = chosenFilePath!.path
                imageSaveLocationTextField.stringValue = path
            }
        } // no action if the user clicked cancel
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // load all of the settings
        let defaults = UserDefaults.standard
        saveImagesToDiskCheckBox.state = defaults.value(forKey: constants.saveImagesToDisk) as? Int ?? 0
        imageSaveLocationTextField.stringValue = defaults.value(forKey: constants.imageSaveLocation) as? String ?? ""
        searchQueriesTextField.stringValue = defaults.value(forKey: constants.searchQueries) as? String ?? ""
        screenWidthTextField.stringValue = defaults.value(forKey: constants.screenWidth) as! String
        screenHeightTextField.stringValue = defaults.value(forKey: constants.screenHeight) as! String
        changeFrequencySlider.integerValue = defaults.value(forKey: constants.changeFrequency) as? Int ?? 0
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    
    func windowWillClose(_ notification: Notification) {
        // save relevant data to user defaults here
        let defaults = UserDefaults.standard
        
        defaults.setValue(saveImagesToDiskCheckBox.state, forKey: constants.saveImagesToDisk)
        defaults.setValue(imageSaveLocationTextField.stringValue, forKey: constants.imageSaveLocation)
        defaults.setValue(searchQueriesTextField.stringValue, forKey: constants.searchQueries)
        defaults.setValue(screenWidthTextField.stringValue, forKey: constants.screenWidth)
        defaults.setValue(screenHeightTextField.stringValue, forKey: constants.screenHeight)
        
        defaults.setValue(changeFrequencySlider.integerValue, forKey: constants.changeFrequency)
        
        delegate?.preferencesDidUpdate()
    }
    
    
}
