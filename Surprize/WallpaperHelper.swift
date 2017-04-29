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
    
    // eventually this should take into account the user's preferred location
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
        
        if (image?.pngWrite(to: destinationURL!, options: .withoutOverwriting))! {
            print("File saved")
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
        } catch {
            print(error)
        }
    }
}
