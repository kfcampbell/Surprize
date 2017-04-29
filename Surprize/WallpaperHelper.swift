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
        
        let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let uniqueFilename = getUniqueImageFilename()
        let destinationURL = desktopURL.appendingPathComponent(uniqueFilename)
        
        if (image?.pngWrite(to: destinationURL, options: .withoutOverwriting))! {
            print("File saved")
            let filePath = desktopURL.appendingPathComponent(uniqueFilename).relativePath
            return filePath
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
