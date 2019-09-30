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
    @IBOutlet weak var pickerView: UIPickerView!
    var breeds: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        DogApi.requestBreeds(completionHandler: self.handleBreedsListResponse(breeds:error:))
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
    
    func handleBreedsListResponse(breeds: [String], error: Error?) {
        
        self.breeds = breeds
    }


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogApi.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
}

