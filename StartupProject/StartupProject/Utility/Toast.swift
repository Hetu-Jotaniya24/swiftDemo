//
//  Toast.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 10/11/21.
//
import Foundation
import UIKit

enum MessageAlertState {
    case success , failure , info , theme
}

enum ToastCustomMessagesString : String{
    case SelectCard = "Please select card."
    case MoneyAddedToWallet = "Money added successfully."
    case EnterAmount = "Please enter amount."
}

class Toast {
    
    static func show(title: String = "" ,delay :Double = 1.5,  message: String, state : MessageAlertState ,  completion: (() -> Void)? = nil) {
        guard let window = Constants.keyWindow else { return}
        
        let toastContainer = UIView(frame: CGRect())
        toastContainer.tag = viewComponentsTags.ToastView.rawValue
        if (window.viewWithTag(viewComponentsTags.ToastView.rawValue) != nil ){
            return
        }
        
        let toastLabel = UILabel(frame: CGRect())
        let statusImage = UIImageView(frame: CGRect())
        switch state {
        case .success:
            toastContainer.backgroundColor = UIColor(red: 97.0/255.0, green: 161.0/255.0, blue: 23.0/255.0, alpha: 1.0)// UIColor.green//.withAlphaComponent(0.9)
            statusImage.image = UIImage(named: "imgAlertCheck")
        case .failure:
            toastContainer.backgroundColor = UIColor(red: 249.0/255.0, green: 66.0/255.0, blue: 47.0/255.0, alpha: 1.0)// UIColor.red//.withAlphaComponent(0.9)
            statusImage.image = UIImage(named: "imgAlertCancel")
        case .info:
            toastContainer.backgroundColor = UIColor.appColor(.themeSolidGray)//.withAlphaComponent(0.9) //UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            statusImage.image = UIImage(named: "imgAlertInfo")
            
        case .theme:
            toastContainer.backgroundColor = UIColor.appColor(.themeGold)//.withAlphaComponent(0.9)
            statusImage.image = UIImage(named: "imgAlertInfo")
        }
        
        statusImage.layer.cornerRadius = 15
        statusImage.clipsToBounds = true
        
        toastContainer.alpha = 1.0
        toastContainer.layer.cornerRadius = 15
        toastContainer.clipsToBounds = true
        
        toastLabel.textAlignment = .left;
        
        let messagetoPrint = title != "" ?
            
            NSMutableAttributedString()
            .bold( "\(title)\n" , fontSize: 15.0 , fontColor: .white)
            .normal(message, fontSize: 14.0 , fontColor: .white)
            :
            NSMutableAttributedString()
            .normal(message, fontSize: 15.0 , fontColor: .white)
        toastLabel.attributedText = messagetoPrint
        
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        
        toastContainer.addSubview(statusImage)
        toastContainer.addSubview(toastLabel)
        
        
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let i1 = NSLayoutConstraint(item: statusImage, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        statusImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        statusImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let i4 = NSLayoutConstraint(item: statusImage, attribute: .centerY, relatedBy: .equal, toItem: toastContainer, attribute: .centerY, multiplier: 1, constant: 0)
        toastContainer.addConstraints([i1, i4])
        
        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: statusImage, attribute: .trailing, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])
        
        window.addSubview(toastContainer)
        
        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1, constant: 20)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: window, attribute: .trailing, multiplier: 1, constant: -20)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1, constant: 0)
        window.addConstraints([c1,c2,c3])
        
        DispatchQueue.main.async {
            c3.constant = 50
            
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.beginFromCurrentState, .curveLinear, .allowUserInteraction], animations: {
                //                toastContainer.alpha = 1.0
                window.layoutIfNeeded()
                
            }, completion: { completed in
                c3.constant = 0
                UIView.animate(withDuration: 0.1, delay: delay, options: .curveLinear, animations: {
                    //                    toastContainer.alpha = 0.0
                    window.layoutIfNeeded()
                }) { _ in
                    toastContainer.removeFromSuperview()
                    if let comp = completion{
                        comp()
                    }
                }
            })
        }
    }
}


