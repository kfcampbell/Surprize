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
    let baseApiPath = "https://source.unsplash.com/"
    var apiPath = ""
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
        updateDefaults()
        makeApiRequest(urlPath: apiPath)
    }
    
    @IBAction func humzahClicked(_ sender: NSMenuItem){
        
    }
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
        
    func updateDefaults() {
        let defaults = UserDefaults.standard
        
        if let screenWidth = defaults.value(forKey: constants.screenWidth) as? String {
            if let screenHeight = defaults.value(forKey: constants.screenHeight) as? String {
                if let searchqueries = defaults.value(forKey: constants.searchQueries) as? String {
                    apiPath = baseApiPath + screenWidth + "x" + screenHeight + "/?" + searchqueries
                }
            }
        } else {
            apiPath = baseApiPath + "2880x1800/?"
        }
    }
    
    func makeApiRequest(urlPath: String) {
        let url = URL(string: urlPath)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                // todo: some sort of error handling here
                let savedFilePath = self.wallpaperHelper.saveImage(data: data!)
                self.wallpaperHelper.changeWallpaper(path: savedFilePath)
            }
        }
    }
    

    func preferencesDidUpdate() {
        // do stuff when the settings are updated. 
    }

}
