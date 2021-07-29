//
//  SHCircleBar.swift
//  SHCircleBar
//
//  Created by Adrian Perțe on 19/02/2019.
//  Copyright © 2019 softhaus. All rights reserved.
//

import UIKit

@IBDesignable class SHCircleBar: UITabBar {
    private var tabWidth: CGFloat = 0
    private var index: CGFloat = 0 {
        willSet{
            self.previousIndex = index
        }
    }
    private var animated = false
    private var selectedImage: UIImage?
    private var previousIndex: CGFloat = 0
    
    private let maskLayer = CAShapeLayer()
    private let shadowLayer = CAShapeLayer()
    private let maskedView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    open override func draw(_ rect: CGRect) {
        drawCurve()
    }
}

extension SHCircleBar {
    
    func select(itemAt: Int, animated: Bool) {
        self.index = CGFloat(itemAt)
        self.animated = animated
        self.selectedImage = self.selectedItem?.selectedImage
        self.selectedItem?.selectedImage = nil
        self.setNeedsDisplay()
    }
    
    private func drawCurve() {
        tabWidth = self.bounds.width / CGFloat(self.items?.count ?? 4)
        let bezPath = drawPath(for: index)
        
        maskedView.frame = bezPath.bounds
        maskLayer.path = bezPath.cgPath
        shadowLayer.path = bezPath.cgPath
        
        if (animated) {
            let bezAnimation = CABasicAnimation(keyPath: "path")
            let bezPathFrom = drawPath(for: previousIndex)
            bezAnimation.toValue = bezPath.cgPath
            bezAnimation.fromValue = bezPathFrom.cgPath
            bezAnimation.duration = 0.3
            bezAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            maskLayer.add(bezAnimation, forKey: nil)
            shadowLayer.add(bezAnimation, forKey: nil)
        }
    }
    
    private func customInit(){
        maskedView.center = CGPoint(x: self.frame.size.width  / 2,
                                    y:  self.frame.size.height / 2)
        maskedView.backgroundColor = .white
        self.insertSubview(maskedView, at:0)
        maskedView.layer.mask = maskLayer
        
        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowRadius = 2
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)

        maskedView.superview?.layer.insertSublayer(shadowLayer, below: maskedView.layer)
        
        self.tintColor = .clear
        self.barTintColor = .clear
    }
    
    private func drawPath(for index: CGFloat) -> UIBezierPath {
        let bezPath = UIBezierPath()
        
        let tabHeight: CGFloat = tabWidth
        
        let leftPoint = CGPoint(x: (index * tabWidth), y: 0)
        let leftPointCurveUp = CGPoint(
            x: ((tabWidth * index) + tabWidth / 5),
            y: 0)
        let leftPointCurveDown = CGPoint(
            x: ((index * tabWidth) - tabWidth*0.2) + tabWidth / 4,
            y: tabHeight*0.40)
        
        let middlePoint = CGPoint(
            x: (tabWidth * index) + tabWidth / 2,
            y: tabHeight*0.4)
        let middlePointCurveDown = CGPoint(
            x: (((index * tabWidth) - tabWidth*0.2) + tabWidth / 10) + tabWidth,
            y: tabHeight*0.40)
        let middlePointCurveUp = CGPoint(
            x: (((tabWidth * index) + tabWidth) - tabWidth / 5),
            y: 0)
        
        let rightPoint = CGPoint(x: (tabWidth * index) + tabWidth, y: 0)
        bezPath.move(to: leftPoint)
        bezPath.addCurve(to: middlePoint, controlPoint1: leftPointCurveUp, controlPoint2: leftPointCurveDown)
        bezPath.addCurve(to: rightPoint, controlPoint1: middlePointCurveDown, controlPoint2: middlePointCurveUp)
        
        bezPath.append(UIBezierPath(rect: self.bounds))
        bezPath.close()
        
        return bezPath
    }
}

