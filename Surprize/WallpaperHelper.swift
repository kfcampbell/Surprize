//
//  WallpaperHelper.swift
//  Surprize
//
//  Created by Keegan Campbell on 4/29/17.
//  Copyright © 2017 Keegan Campbell. All rights reserved.
//

import Foundation
import Cocoa

class WallpaperHelper {
    let constants = Constants()
    
    private func getUniqueImageFilename() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        // todo(kfcampbell): reflect the categories used in the answer here
        formatter.dateFormat = "yyyy-MM-dd-hh-mm-ss"
        return (formatter.string(from: date) + ".png")
    }
    
    func saveImage(data: Data) -> String {
        
        let image = NSImage(data: data)
        let defaults = UserDefaults.standard
        
        var chosenFolderPath = defaults.value(forKey: constants.imageSaveLocation) as? String ?? ""
        var chosenFolderUrl: NSURL
        
        // default to desktop if there's no chosen folder
        if(chosenFolderPath == "") {
            chosenFolderPath = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!.relativePath
        }
        chosenFolderUrl = NSURL(string: chosenFolderPath)!
        
        let uniqueFilename = getUniqueImageFilename()
        let destinationURL = chosenFolderUrl.appendingPathComponent(uniqueFilename)
        let finalDestinationURL = URL(string:("file://" + (destinationURL?.relativePath)!))
        
        if (image?.pngWrite(to: finalDestinationURL!, options: .withoutOverwriting))! {
            return destinationURL!.relativePath
        }
        return ""
    }
    
    func changeWallpaper (path: String) {
        do {
            let imgurl = NSURL.fileURL(withPath: path)
            let workspace = NSWorkspace.shared()
            if let screen = NSScreen.main()  {
                try workspace.setDesktopImageURL(imgurl, for: screen, options: [:])
            }
            
            // check constants and delete image if the setting to keep images isn't saved.
            let defaults = UserDefaults.standard
            
            // it'd be cool if this was a boolean rather than an int
            let keepImageStatus = defaults.value(forKey: constants.saveImagesToDisk) as? Int ?? 1
            
            if keepImageStatus < 1 {
                let fileManager = FileManager.default
                try fileManager.removeItem(atPath: path)
            }
        } catch {
            print(error)
        }
    }
}
