//
//  DetailedViewController.swift
//  FlickrCollection
//
//  Created by Оля on 22.04.2021.
//

import UIKit
import CoreImage

class DetailedViewController: UIViewController {
    
    //MARK: Properties
    var descriptionOfPhoto: String?
    var photoURL: String?
    let context = CIContext()
    var filteredImage: UIImage?
    
    
    // MARK: Outlets
    @IBOutlet weak var detailedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = descriptionOfPhoto
        self.photoURL?.loadImage(completion: { (image) in
            self.detailedImage.image = image
        })
        
    }
    
    // MARK: IB Actions
    @IBAction func shareTapped(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Save image", style: .default, handler: { (action) in
            let alert: UIAlertController?
            UIImageWriteToSavedPhotosAlbum((self.detailedImage.image)!, nil, nil, nil)
            alert = ImageSavingHelper.successfullSavingAlert
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Share image by email", style: .default, handler: { (action) in
            let mailViewController = MailHelperViewController()
            self.addChild(mailViewController)
            mailViewController.sendMail(withImage: URL(string: self.photoURL!)!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func editingButton(_ sender: Any) {
        let imageURL = NSURL(string: photoURL ?? "")
        let originalCIImage = CIImage(contentsOf: imageURL! as URL)!;self.detailedImage.image = UIImage(ciImage:originalCIImage)
        let sepiaCIImage = sepiaFilter(originalCIImage, intensity:0.9)
        self.detailedImage.image = UIImage(ciImage:sepiaCIImage!)
        self.filteredImage = UIImage(ciImage:sepiaCIImage!)
        self.filteredImage = self.detailedImage.image
    }
    
    // MARK: Methods
    func sepiaFilter(_ input: CIImage, intensity: Double) -> CIImage? {
        let sepiaFilter = CIFilter(name:"CISepiaTone")
        sepiaFilter?.setValue(input, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(intensity, forKey: kCIInputIntensityKey)
        return sepiaFilter?.outputImage
    }
}
