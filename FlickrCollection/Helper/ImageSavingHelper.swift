//
//  ImageSavingHelper.swift
//  FlickrCollection
//
//  Created by Оля on 27.04.2021.
//

import UIKit

class ImageSavingHelper {
    
    // MARK: Alert variables
    static var successfullSavingAlert:UIAlertController{
        get{
            let alert = UIAlertController(title: "Saved!", message: "Image saved successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            return alert
        }
    }
    
    static var failedSavingAlert:UIAlertController{
        get{
            let alert = UIAlertController(title: "Error!", message: "Image wasn't saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            return alert
        }
    }
    
    // MARK: Saving
    static func saveImageToGallery(image: UIImage) -> Bool{
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        return true
    }
}
