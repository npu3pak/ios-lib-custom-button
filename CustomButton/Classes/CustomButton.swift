//
//  CustomButton.swift
//  CustomButton
//
//  Created by Evgeniy Safronov on 30.08.17.
//  Copyright © 2017 Evgeniy Safronov. All rights reserved.
//

import UIKit

public class CustomButton: UIButton {
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
        addTarget(self, action: #selector(configureRegularColors), for: .touchCancel)
        addTarget(self, action: #selector(configureRegularColors), for: .touchUpInside)
        addTarget(self, action: #selector(configureRegularColors), for: .touchDragExit)
        
        configureRegularColors()
        configureDisabledColors()
    }
    
    public override var isEnabled: Bool {
        didSet {
            configureDisabledColors()
        }
    }
    
    public var regularColor: UIColor = UIColor.darkGray {
        didSet {
            configureRegularColors()
        }
    }
    
    public var regularBackgroundColor: UIColor? = UIColor.clear {
        didSet {
            configureRegularColors()
        }
    }
    
    public var regularBorderColor: UIColor? = UIColor.clear {
        didSet {
            configureRegularColors()
        }
    }
    
    @objc private func configureRegularColors() {
        guard isEnabled else {
            return
        }
        
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
    
    public var disabledColor: UIColor = UIColor.darkGray {
        didSet {
            configureDisabledColors()
        }
    }
    
    public var disabledBackgroundColor: UIColor? = UIColor.clear {
        didSet {
            configureDisabledColors()
        }
    }
    
    public var disabledBorderColor: UIColor? = UIColor.clear {
        didSet {
            configureDisabledColors()
        }
    }
    
    @objc private func configureDisabledColors() {
        guard isEnabled == false else {
            return
        }
        
        if tintImages {
            leftImageView.image = leftImage?.tintedImage(disabledColor)
            rightImageView.image = rightImage?.tintedImage(disabledColor)
        } else {
            leftImageView.image = leftImage
            rightImageView.image = rightImage
        }
        setTitleColor(disabledColor, for: UIControlState())
        backgroundColor = disabledBackgroundColor
        layer.borderColor = disabledBorderColor?.cgColor ?? disabledBackgroundColor?.cgColor
    }
    
    public var pressedColor: UIColor = UIColor.lightGray
    
    public var pressedBackgroundColor: UIColor? = UIColor.clear
    
    public var pressedBorderColor: UIColor? = UIColor.clear
    
    @objc private func configurePressedColors() {
        guard isEnabled else {
            return
        }
        
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
    
    public var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    public var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius  }
    }
    
    public var imageSize: CGFloat = 16 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    public var imagePadding: CGFloat = 16 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    public var leftImage: UIImage? {
        didSet {
            configureRegularColors()
            configureDisabledColors()
        }
    }
    
    public var rightImage: UIImage? {
        didSet {
            configureRegularColors()
            configureDisabledColors()
        }
    }
    
    public var tintImages: Bool = true {
        didSet {
            configureRegularColors()
        }
    }
    
    override public func updateConstraints() {
        
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
        
        
        let leftImageRight = NSLayoutConstraint(item: leftImageView,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: imagePadding)
        leftImageRight.identifier = "leftImageRight"
        
        let leftImageCenter = NSLayoutConstraint(item: leftImageView,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .centerY,
                                                 multiplier: 1,
                                                 constant: 0)
        leftImageCenter.identifier = "leftImageCenter"
        
        
        let rightImageRight = NSLayoutConstraint(item: rightImageView,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -imagePadding)
        rightImageRight.identifier = "rightImageRight"
        
        let rightImageCenter = NSLayoutConstraint(item: rightImageView,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        rightImageCenter.identifier = "rightImageCenter"
        
        let constraintsForRemove = [leftImageRight.identifier!,
                                    leftImageCenter.identifier!,
                                    rightImageRight.identifier!,
                                    rightImageCenter.identifier!]
        
        constraints.filter({$0.identifier != nil && constraintsForRemove.contains($0.identifier!)}).forEach() {
            self.removeConstraint($0)
        }
        
        addConstraints([leftImageRight, leftImageCenter, rightImageRight, rightImageCenter])
        
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
