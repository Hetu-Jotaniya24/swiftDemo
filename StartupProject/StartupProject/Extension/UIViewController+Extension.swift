//
//  UIViewController+Extension.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 10/11/21.
//

import Foundation
import UIKit

extension NSObject {
    static var className : String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    //MARK: ====ALERT
    
    enum AlertButton: Int {
        case confirm
        case cancel
    }
    
    /// From within view controller
    /// - Parameters:
    ///   - title: Alert Title String
    ///   - Message: Alert Message String
    ///   - defaultButtonTitle: Default Button Title like OK, Done (To be done action on)
    ///   - cancelButtonTitle: Optional (pass "" to remove cancel button)
    ///   - completionHandler: Action to be
    
    func showAlertWithTwoButtonCompletion(title:String, Message:String, defaultButtonTitle:String, cancelButtonTitle : String? = "Cancel",  completionHandler: ((AlertButton) -> Void)? = nil) -> Void{
        
        let alertController = UIAlertController(title: title , message:Message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: defaultButtonTitle, style: .default) { (UIAlertAction) in
            if let completionHandler = completionHandler {
                completionHandler(AlertButton.confirm)
            }
        }
        if cancelButtonTitle != ""{
            let CancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (UIAlertAction) in
                if let completionHandler = completionHandler {
                    completionHandler(AlertButton.cancel)
                }
            }
            alertController.addAction(OKAction)
            alertController.addAction(CancelAction)
        }else{
            alertController.addAction(OKAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    
        /* if let res = param as? String {
         Utility.showAlert(Message: res)
         }
         else if let resDict = param as? NSDictionary {
         let msg = (Localize.currentLanguage() == Languages.English.rawValue) ? "message" : "spanish_message"
         if let msg = resDict.object(forKey: msg) as? String {
         Utility.showAlert(Message: msg)
         }
         else if let msg = resDict.object(forKey: "msg") as? String {
         Utility.showAlert(Message: msg)
         }
         else if let msg = resDict.object(forKey: msg) as? [String] {
         Utility.showAlert(Message: msg.first ?? "")
         }
         }
         else if let resAry = param as? NSArray {
         
         if let dictIndxZero = resAry.firstObject as? NSDictionary {
         let msg = (Localize.currentLanguage() == Languages.English.rawValue) ? "message" : "spanish_message"
         if let message = dictIndxZero.object(forKey: msg) as? String {
         Utility.showAlert(Message: message)
         }
         else if let msg = dictIndxZero.object(forKey: "msg") as? String {
         Utility.showAlert(Message: msg)
         }
         else if let msg = dictIndxZero.object(forKey: msg) as? [String] {
         Utility.showAlert(Message: msg.first ?? "")
         }
         }
         else if let msg = resAry as? [String] {
         Utility.showAlert(Message: msg.first ?? "")
         }
         } */
    
    
  
  
}

