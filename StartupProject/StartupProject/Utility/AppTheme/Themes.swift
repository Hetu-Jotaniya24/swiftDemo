//
//  Themes.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 15/03/21.
//

import Foundation
import UIKit
//import CountryPickerView
//import SkyFloatingLabelTextField
//import FormTextField

//==========================
//MARK: ====== Button ======
//==========================

//class themeButton: UIButton {
//    
//    @IBInspectable public var Font_Size: CGFloat = FontSize.size19.rawValue
//    @IBInspectable public var isbordered: Bool = false
//    @IBInspectable public var radius: CGFloat = 7.0
//    @IBInspectable public var borderWidth: CGFloat = 2.0
//    @IBInspectable public var background : UIColor = UIColor.appColor(ThemeColor.themeGold)
//    @IBInspectable public var isSemibold: Bool = false
//    @IBInspectable public var fontColor: UIColor = .white
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
////        self.tintColor = fontColor
//        
//        self.setTitleColor(fontColor, for: .normal)
//        self.titleLabel?.font  = isSemibold ? FontBook.semibold.of(size: Font_Size) : FontBook.regular.of(size: Font_Size)
//     if isbordered{
//            
//            self.backgroundColor = .clear
//            self.layer.borderColor = UIColor.white.cgColor
//            self.layer.borderWidth = borderWidth
//            self.layer.cornerRadius = radius
//            
//        }else{
//          
//            self.layer.cornerRadius = radius
//            self.backgroundColor = background
//        }
//    }
//    
//    
//}
//
//
//class themeCustomShadowButton : UIControl{
//    @IBInspectable public var front_image: UIImage = UIImage(named: "imgBtnSimpleGoldBG") ?? UIImage()
//    @IBInspectable public var Font_Size: CGFloat = FontSize.size19.rawValue
//    @IBInspectable public var fontColor: UIColor = .white
//    @IBInspectable public var Title: String = ""
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        self.addSoftUIEffectForView()
//        let imageView = UIImageView(image: front_image)
//        imageView.frame = CGRect(x: 5, y: 5, width: self.frame.width - 10, height: self.frame.height - 10)
//        imageView.layer.cornerRadius = self.frame.height/2
//        self.addSubview(imageView)
//        let label = UILabel(frame: CGRect(x: 5, y: 5, width: imageView.frame.width - 10, height: imageView.frame.height - 10))
//        label.text = Title
//        label.textAlignment = .center
//        label.isUserInteractionEnabled = false
//        label.font = FontBook.regular.of(size: Font_Size)
//        label.textColor = fontColor
//        imageView.addSubview(label)
//    }
//}
//
//
////==========================
////MARK: === Label ===
////==========================
//
//class themeLabel: UILabel{
//    @IBInspectable public var Font_Size: CGFloat = FontSize.size15.rawValue
//    @IBInspectable public var isBold: Bool = false
//    @IBInspectable public var isSemibold: Bool = false
//    @IBInspectable public var isLight: Bool = false
//    @IBInspectable public var fontColor: UIColor = .white
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.font = isBold ? FontBook.bold.of(size : Font_Size) :
//            (isSemibold ? FontBook.semibold.of(size : Font_Size)  :
//                (isLight ? FontBook.light.of(size : Font_Size) : FontBook.regular.of(size : Font_Size) ))
//       
////        print(self.font.familyName)
//    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.textColor = fontColor
//       
//    }
//}
//
////==========================
////MARK: === Textfield ===
////==========================
//
//class themeTextfield : UITextField{
//    @IBInspectable public var Font_Size: CGFloat = FontSize.size15.rawValue
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//       
//        self.font = FontBook.regular.of(size : Font_Size)
//        self.textColor = .white
//        self.tintColor = UIColor.appColor(ThemeColor.themeGold)
//    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        DispatchQueue.main.async {
//            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
//                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white] )
//        }
//        
//        
//    }
//}
//
//class ThemeFloatTextfield: SkyFloatingLabelTextField {
//    
//    @IBInspectable public var FontSize: CGFloat = 16.0
//    @IBInspectable public var PlaceHolderFontSize: CGFloat = 14.0
//    @IBInspectable public var HideBottomLine: Bool = false
//    @IBInspectable public var PlaceHolder_Color: UIColor = UIColor.white.withAlphaComponent(0.5)
//    @IBInspectable public var text_color: UIColor = UIColor.white.withAlphaComponent(0.5)
//    /*    override var isEnabled: Bool{
//             willSet{
//                 self.textColor = newValue ? UIColor.red : UIColor.blue
//             }
//     }*/
//    override func awakeFromNib() {
//        super.awakeFromNib()
//       
//        self.font = FontBook.regular.of(size: FontSize)
//        self.textColor = text_color
//        if HideBottomLine{
//            self.lineView.isHidden = true
//            self.placeholderColor = PlaceHolder_Color
//        }else{
//            self.lineHeight = 0.5
//            self.selectedLineHeight = 0.5
//            self.lineColor = PlaceHolder_Color
//            self.selectedLineColor = PlaceHolder_Color
//        }
//        self.placeholderFont = FontBook.regular.of(size: PlaceHolderFontSize)
//        self.selectedTitleColor = PlaceHolder_Color
//        self.placeholderColor = PlaceHolder_Color
//        
//        self.titleFormatter = { $0.localizedCapitalized}
//        self.tintColor = UIColor.appColor(.themeGold)
//    }
//}
//
//
////MARK: ======== cardtextfield custom class
//class themeCardTextfield: FormTextField {
//    @IBInspectable public var FontSize: CGFloat = 15.0
//    override func awakeFromNib() {
//        super.awakeFromNib()
//       
//        self.font = FontBook.regular.of(size : FontSize)
//      
//    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
//                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white] )
//        self.tintColor = UIColor.appColor(.themeGold)
//        self.enabledTextColor = .white
//        self.clearButtonColor = UIColor.appColor(.themeGold)
//        
//
//    }
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        
////        if self.tag == 101{
//            if action == #selector(UIResponderStandardEditActions.paste(_:)) ||  action == #selector(UIResponderStandardEditActions.copy(_:)) ||  action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||  action == #selector(UIResponderStandardEditActions.select(_:)) ||  action == #selector(UIResponderStandardEditActions.cut(_:)) ||  action == #selector(UIResponderStandardEditActions.delete(_:))  {
//                return false
//            }
////        }
//        return super.canPerformAction(action, withSender: sender)
//    }
//}
