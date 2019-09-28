//
//  DogApi.swift
//  SimpleDog
//
//  Created by Myron Wells on 9/21/19.
//  Copyright © 2019 Myron Wells. All rights reserved.
//

import Foundation
import UIKit

class DogApi {
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestImageFile (url:URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            
            guard let data = data else {
                completionHandler(nil,error)
                return
            }
                let dogImage = UIImage(data: data)
                completionHandler(dogImage,nil)
            
        })
        task.resume()
    }
    
    class func requestRandomImage (completionHandler:@escaping (DogImage?, Error?) -> Void ) {
        
        let task = URLSession.shared.dataTask(with: Endpoint.randomImageFromAllDogsCollection.url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil,error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                completionHandler(imageData,nil)
                
            } catch {
                print(error)
            }
        
    }
        task.resume()
}
    
}
