//
//  MailHelper.swift
//  FlickrCollection
//
//  Created by Оля on 27.04.2021.
//

import UIKit
import MessageUI

class MailHelperViewController: UIViewController,MFMailComposeViewControllerDelegate{
    
    func sendMail(withImage imageURL: URL) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self;
            do {
                let imageData = try Data(contentsOf: imageURL)
                let imageURLWithoutExt = imageURL.deletingPathExtension()
                let imageName = imageURLWithoutExt.lastPathComponent
                mail.addAttachmentData(imageData,
                                       mimeType: "image/jpg",
                                       fileName: imageName)
                self.present(mail, animated: true, completion: nil)
                
            }catch let imageDataError{
                print(imageDataError.localizedDescription)
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
