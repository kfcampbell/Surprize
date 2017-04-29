//
//  ApiHelper.swift
//  Surprize
//
//  Created by Keegan Campbell on 4/28/17.
//  Copyright © 2017 Keegan Campbell. All rights reserved.
//

import Foundation
/*
class ApiHelper {
    let apiPath = "https://source.unsplash.com/2880x1800/?nature,water"
    
    func makeApiRequest() -> Data {
        let url = URL(string: apiPath)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
            }
            return data!
        }
    }
    
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
*/
