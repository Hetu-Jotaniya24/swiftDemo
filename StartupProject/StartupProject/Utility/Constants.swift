//
//  Constants.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 10/11/21.
//
import Foundation
import UIKit
import SDWebImage
//import SkeletonView

struct Constants {
    static var user_defaults = UserDefaults.standard
    static  let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    /*let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first */

    static let appDel = UIApplication.shared.delegate as! AppDelegate

    static let ScreenWidth = UIScreen.main.bounds.width
    static let ScreenHeight = UIScreen.main.bounds.height
    static let KAPPVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

    static let AppName = "appName"
    static let currency = ""

    static let APPURL = "itms-apps://itunes.apple.com/app/appid"

    static let GoogleServiceApiKey = "apikey"

    static let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    static let TEXTFIELD_MaximumLimit = 25
    static let TEXTFIELD_MinimumLimit = 2
    
    //static let skeletonAnimationDirection = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    //static let skeletonBackgroundColor = SkeletonGradient(baseColor: UIColor.appColor(.color))// UIColor.white.withAlphaComponent(0.25))
}


func getVectorImageFromAPI()->UIImageView{
    let api_vector = UIImageView()
   api_vector.sd_setImage(with: URL(string: "http://defaultimageurl/assets/images/default_user.png"))
    return api_vector
}


struct DeviceType {
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}

extension Notification.Name {
    static let notificationBadge = Notification.Name("notificationBadge")
}
