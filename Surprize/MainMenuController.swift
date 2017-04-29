//
//  MainMenuController.swift
//  Surprize
//
//  Created by Keegan Campbell on 4/22/17.
//  Copyright © 2017 Keegan Campbell. All rights reserved.
//

import Cocoa

class MainMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    let apiPath = "https://source.unsplash.com/2880x1800/?nature,water"
    
    @IBAction func updateClicked(_ sender: NSMenuItem) {
        makeApiRequest()
    }
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    /*func changeWallpaper (string path) {
        do {
            let imgurl = NSURL.fileURL(withPath: singleImage)
            let workspace = NSWorkspace.shared()
            if let screen = NSScreen.main()  {
                try workspace.setDesktopImageURL(imgurl, for: screen, options: [:])
            }
        } catch {
            print(error)
        }
    }*/
    
    func makeApiRequest() {
        let url = URL(string: apiPath)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                let image = NSImage(data: data!)
                
                // now save image
                let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
                let destinationURL = desktopURL.appendingPathComponent("my-image.png")
                if (image?.pngWrite(to: destinationURL, options: .withoutOverwriting))! {
                    print("File saved")
                }
            }
        }
    }

    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
    }
}
