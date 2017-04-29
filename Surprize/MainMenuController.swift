//
//  MainMenuController.swift
//  Surprize
//
//  Created by Keegan Campbell on 4/22/17.
//  Copyright © 2017 Keegan Campbell. All rights reserved.
//

import Cocoa

class MainMenuController: NSObject, PreferencesWindowDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    var preferencesWindow: PreferencesWindow!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    let constants = Constants()
    let wallpaperHelper = WallpaperHelper()
    let apiHelper = ApiHelper()
    var defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
    }
    
    @IBAction func updateClicked(_ sender: NSMenuItem) {
        let apiPath = apiHelper.updateDefaultsAndReturnApiPath()
        var imageData: Data? = nil
        if apiPath != "" {
            imageData = apiHelper.getImageData(urlPath: apiPath)
        } else {
            alertUserProvideNoActions(header: "Preferences error", message: "Couldn't construct the API call you wanted", buttonTitle: "I guess I'll go fix it")
        }
        
        if imageData != nil {
            let savedFilePath = self.wallpaperHelper.saveImage(data: imageData!)
            self.wallpaperHelper.changeWallpaper(path: savedFilePath)
        } else {
            self.alertUserProvideNoActions(header: "Error Downloading Image", message: "What did you do wrong?", buttonTitle: "I have no idea...")
        }
    }
    
    @IBAction func humzahClicked(_ sender: NSMenuItem){
        let humzahPath = Bundle.main.urlForImageResource("humzah_smiling.png")
        self.wallpaperHelper.changeWallpaper(path: (humzahPath?.relativePath)!)
    }
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    func alertUserProvideNoActions(header: String, message: String, buttonTitle: String) {
        let popUp = NSAlert()
        popUp.messageText = header
        popUp.informativeText = message
        popUp.alertStyle = NSAlertStyle.critical
        popUp.addButton(withTitle: buttonTitle)
        popUp.runModal()
    }

    func preferencesDidUpdate() {
        // do stuff when the settings are updated. 
    }

}
