//
//  ViewController.swift
//  SimpleDog
//
//  Created by Myron Wells on 9/21/19.
//  Copyright © 2019 Myron Wells. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        DogApi.requestRandomImage(completionHandler: self.handleRandomImageResponse)
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let url = URL(string: imageData?.message ?? "") else {
            return
        }
        
        DogApi.requestImageFile(url: url, completionHandler: self.handleImageFileResponse)
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }


}

