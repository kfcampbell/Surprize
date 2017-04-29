//
//  ApiHelper.swift
//  Surprize
//
//  Created by Keegan Campbell on 4/28/17.
//  Copyright © 2017 Keegan Campbell. All rights reserved.
//

import Foundation

class ApiHelper {
    let constants = Constants()
    let baseApiPath = "https://source.unsplash.com/"
    let apiPath = "https://source.unsplash.com/2880x1800/?nature,water"
    
    func updateDefaultsAndReturnApiPath() -> String {
        let defaults = UserDefaults.standard
        
        if let screenWidth = defaults.value(forKey: constants.screenWidth) as? String {
            if let screenHeight = defaults.value(forKey: constants.screenHeight) as? String {
                if let searchqueries = defaults.value(forKey: constants.searchQueries) as? String {
                    return (baseApiPath + screenWidth + "x" + screenHeight + "/?" + searchqueries)
                }
            }
        } else {
            return (baseApiPath + "2880x1800/?")
        }
        
        return ""
    }
    
    func getImageData(urlPath: String) -> Data? {
        let url = URL(string: urlPath)
        
        // todo: make this network call async
        // i don't understand how to wait on a result. i wish they had async/await...
        if let data = try? Data(contentsOf: url!) {
            return data
        } else {
            return nil
        }
    }
        
        /*
         //DispatchQueue.global().async {
         if let data = try? Data(contentsOf: url!) {
         return data
         
         // this is for going back to the UI thread
         /*DispatchQueue.main.async {
         return data
         //let savedFilePath = self.wallpaperHelper.saveImage(data: data)
         //self.wallpaperHelper.changeWallpaper(path: savedFilePath)
         }*/
         } else {
         // alert the user the image couldn't be found
         self.alertUserProvideNoActions(header: "Error Downloading Image", message: "What did you do wrong?", buttonTitle: "I have no idea...")
         }
         // }*/

    
    /*
    func makeApiRequest() -> Data {
        let url = URL(string: apiPath)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
            }
            return data!
        }
    }*/
    
    /*func makeApiRequest() -> NSData {
        var request = URLRequest(url: URL(string: apiPath)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            print("Entered the completionHandler")
            
            return NSData(data: data!)
            }.resume()
    }*/
}

