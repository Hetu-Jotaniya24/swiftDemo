//
//  ThemeShadowAndViews.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 15/03/21.
//

import Foundation
import UIKit


class GradientView: UIView {

    override class var layerClass: AnyClass { return CAGradientLayer.self }

    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    @IBInspectable var color1: UIColor = UIColor.appColor(.themeGold) { didSet { updateColors() } }
    @IBInspectable var color2: UIColor = UIColor.appColor(.themeGreen)  { didSet { updateColors() } }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradient()
    }

    private func configureGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        updateColors()
    }

    private func updateColors() {
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
    }

}


final class innerShadow : UIView {
    @IBInspectable public var Corner_Radius: CGFloat = 20.0
    override func layoutSubviews() {
        super.layoutSubviews()
        addInnerShadow()
    }
    private func addInnerShadow() {
        let innerShadow = CALayer()
        innerShadow.frame = bounds

        // Shadow path (1pt ring around bounds)
        self.clipsToBounds = true
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -2, dy:-2), cornerRadius:Corner_Radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:Corner_Radius).reversing()
        

        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: -2, height: 2)
        innerShadow.shadowOpacity = 0.5
        innerShadow.shadowRadius = 2
        innerShadow.cornerRadius = Corner_Radius
        layer.addSublayer(innerShadow)
    }
  
}

final class outerShadow : UIView {
    private var shadowLayer: CAShapeLayer!
    @IBInspectable public var isRounded : Bool = false
    @IBInspectable public var FillColor : UIColor = .white
    @IBInspectable public var Corner_Radius: CGFloat = 5.0
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: isRounded ? (self.frame.size.height/2) : Corner_Radius).cgPath
            shadowLayer.fillColor = FillColor.cgColor
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.shadowOpacity = 0.9
            shadowLayer.shadowRadius = 4.0
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}

final class sharpDoubleShadow : UIView{
    
    @IBInspectable public var Corner_Radius: CGFloat = 20.0
    @IBInspectable public var isRounded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupview()
        
    }
    
    
    func setupview(){
        self.layer.cornerRadius = isRounded ? self.frame.height / 2 : Corner_Radius
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize( width: 2, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor//UIColor(red: 223/255, green: 228/255, blue: 238/255, alpha: 1.0).cgColor
        
        let imageName = "imgGradient_GrayBG.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        imageView.layer.cornerRadius = isRounded ? self.frame.height / 2 : Corner_Radius
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        //Imageview on Top of View
        self.bringSubviewToFront(imageView)
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        
        shadowLayer.backgroundColor = hexStringToUIColor(hex: "303030").cgColor// UIColor.gray.cgColor//themeColor.cgColor
        shadowLayer.shadowColor = UIColor(white: 1, alpha: 0.2).cgColor
        shadowLayer.cornerRadius = isRounded ? self.frame.height / 2 : Corner_Radius
        shadowLayer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 2
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
class RectangularDashedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
