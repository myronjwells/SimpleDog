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
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/\(breed)/hound/images/random"
            }
            
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
    
    class func requestRandomImage (breed: String, completionHandler:@escaping (DogImage?, Error?) -> Void ) {
        
        
        let randomImageEndpoint = DogApi.Endpoint.randomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
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
