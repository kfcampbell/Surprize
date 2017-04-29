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
        makeApiRequest()
    }
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    
    func changeWallpaper (path: String) {
        do {
            let imgurl = NSURL.fileURL(withPath: path)
            let workspace = NSWorkspace.shared()
            if let screen = NSScreen.main()  {
                try workspace.setDesktopImageURL(imgurl, for: screen, options: [:])
            }
        } catch {
            print(error)
        }
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
    
    func makeApiRequest() {
        let url = URL(string: apiPath)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                // todo: some sort of error handling here
                let image = NSImage(data: data!)
                
                // now save image
                let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
                let uniqueFilename = self.getUniqueImageFilename()
                let destinationURL = desktopURL.appendingPathComponent(uniqueFilename)
                if (image?.pngWrite(to: destinationURL, options: .withoutOverwriting))! {
                    print("File saved")
                    
                let filePath = desktopURL.appendingPathComponent(uniqueFilename).relativePath
                self.changeWallpaper(path: filePath)
                }
            }
        }
    }
    
    func getUniqueImageFilename() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        // todo(kfcampbell): reflect the categories used in the answer here
        formatter.dateFormat = "yyyy-MM-dd-hh-mm-ss"
        return (formatter.string(from: date) + ".png")
    }
    func preferencesDidUpdate() {
        // do stuff when the settings are updated. 
    }

}
