//
//  CustomButton.swift
//  CustomButton
//
//  Created by Evgeniy Safronov on 30.08.17.
//  Copyright © 2017 Evgeniy Safronov. All rights reserved.
//

import UIKit

@IBDesignable public class CustomButton: UIButton {
    private var leftImageView: UIImageView!
    private var rightImageView: UIImageView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        clipsToBounds = true
        
        leftImageView = UIImageView(image: leftImage)
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftImageView)
        
        rightImageView = UIImageView(image: rightImage)
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightImageView)
        
        setNeedsUpdateConstraints()
        
        addTarget(self, action: #selector(configurePressedColors), for: .touchDown)
        addTarget(self, action: #selector(configureRegularColors), for: .touchUpInside)
        addTarget(self, action: #selector(configureRegularColors), for: .touchUpOutside)
        
        configureRegularColors()
    }
    
    @IBInspectable public var regularColor: UIColor = UIColor.darkGray {
        didSet {
            configureRegularColors()
        }
    }
    
    @IBInspectable public var regularBackgroundColor: UIColor? = UIColor.clear {
        didSet {
            configureRegularColors()
        }
    }
    
    @IBInspectable public var regularBorderColor: UIColor? = UIColor.clear {
        didSet {
            configureRegularColors()
        }
    }
    
    @objc private func configureRegularColors() {
        if tintImages {
            leftImageView.image = leftImage?.tintedImage(regularColor)
            rightImageView.image = rightImage?.tintedImage(regularColor)
        } else {
            leftImageView.image = leftImage
            rightImageView.image = rightImage
        }
        setTitleColor(regularColor, for: UIControlState())
        backgroundColor = regularBackgroundColor
        layer.borderColor = regularBorderColor?.cgColor ?? regularBackgroundColor?.cgColor
    }
    
    @IBInspectable public var pressedColor: UIColor = UIColor.lightGray
    
    @IBInspectable public var pressedBackgroundColor: UIColor? = UIColor.clear
    
    @IBInspectable public var pressedBorderColor: UIColor? = UIColor.clear
    
    @objc private func configurePressedColors() {
        if tintImages {
            leftImageView.image = leftImage?.tintedImage(pressedColor)
            rightImageView.image = rightImage?.tintedImage(pressedColor)
        } else {
            leftImageView.image = leftImage
            rightImageView.image = rightImage
        }
        setTitleColor(pressedColor, for: UIControlState())
        backgroundColor = pressedBackgroundColor
        layer.borderColor = pressedBorderColor?.cgColor ?? pressedBackgroundColor?.cgColor
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius  }
    }
    
    @IBInspectable public var imageSize: CGFloat = 16 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    @IBInspectable public var imagePadding: CGFloat = 16 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    @IBInspectable public var leftImage: UIImage? {
        didSet {
            leftImageView.image = leftImage?.tintedImage(tintColor)
        }
    }
    
    @IBInspectable public var rightImage: UIImage? {
        didSet {
            rightImageView.image = rightImage?.tintedImage(tintColor)
        }
    }
    
    @IBInspectable public var tintImages: Bool = true {
        didSet {
            configureRegularColors()
        }
    }
    
    override public func updateConstraints() {
        
        constraints.forEach({self.removeConstraint($0)})
        
        let leftImageWidth = NSLayoutConstraint(item: leftImageView,
                                                attribute: .width,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: 1,
                                                constant: imageSize)
        
        let leftImageHeight = NSLayoutConstraint(item: leftImageView,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: imageSize)
        
        leftImageView.addConstraints([leftImageWidth, leftImageHeight])
        
        
        let leftImageRight = NSLayoutConstraint(item: leftImageView,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: imagePadding)
        
        let leftImageCenter = NSLayoutConstraint(item: leftImageView,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .centerY,
                                                 multiplier: 1,
                                                 constant: 0)
        
        addConstraints([leftImageRight, leftImageCenter])
        
        
        let rightImageWidth = NSLayoutConstraint(item: rightImageView,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: imageSize)
        
        let rightImageHeight = NSLayoutConstraint(item: rightImageView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: imageSize)
        
        rightImageView.addConstraints([rightImageWidth, rightImageHeight])
        
        
        let rightImageRight = NSLayoutConstraint(item: rightImageView,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -imagePadding)
        
        let rightImageCenter = NSLayoutConstraint(item: rightImageView,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        
        addConstraints([rightImageRight, rightImageCenter])
        
        super.updateConstraints()
    }
}

extension CGColor {
    fileprivate var uiColor: UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}

extension UIImage {
    fileprivate func tintedImage(_ color: UIColor) -> UIImage {
        let blendMode:CGBlendMode = .destinationIn
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        color.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        draw(in: bounds, blendMode: blendMode, alpha: 1)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}
