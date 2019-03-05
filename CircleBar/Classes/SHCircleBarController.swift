//
//  SHCircleBarController.swift
//  SHCircleBar
//
//  Created by Adrian Perțe on 19/02/2019.
//  Copyright © 2019 softhaus. All rights reserved.
//

import UIKit

class SHCircleBarController: UITabBarController {

    fileprivate var shouldSelectOnTabBar = true
    private var circleView : UIView!
    private var circleImageView: UIImageView!
    open override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar, let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? SHCircleBar, let index = viewControllers?.index(of: newValue) else {return}
            tabBar.select(itemAt: index, animated: true)
        }
    }
    
    open override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? SHCircleBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: true)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = SHCircleBar()
        self.setValue(tabBar, forKey: "tabBar")
        
        self.circleView = UIView(frame: .zero)
        circleView.layer.cornerRadius = 30
        circleView.backgroundColor = .white
        circleView.isUserInteractionEnabled = false
        
        self.circleImageView = UIImageView(frame: .zero)
        circleImageView.layer.cornerRadius = 30
        circleImageView.isUserInteractionEnabled = false
        circleImageView.contentMode = .center
        
        circleView.addSubview(circleImageView)
        self.view.addSubview(circleView)
        let tabWidth = self.view.bounds.width / CGFloat(self.tabBar.items?.count ?? 4)
        
        circleView.frame = CGRect(x: tabWidth / 2 - 30, y: self.tabBar.frame.origin.y - 40, width: 60, height: 60)
        circleImageView.frame = self.circleView.bounds
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circleImageView.image = image(with: self.tabBar.selectedItem?.image ?? self.tabBar.items?.first?.image, scaledTo: CGSize(width: 30, height: 30))
        
    }
    
    private var _barHeight: CGFloat = 74
    open var barHeight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return _barHeight + view.safeAreaInsets.bottom
            } else {
                return _barHeight
            }
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }
    
    private func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
        updateTabBarFrame()
    }
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.index(of: item) else { return }
        if  idx != selectedIndex, let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            let tabWidth = self.view.bounds.width / CGFloat(self.tabBar.items!.count)
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame = CGRect(x: (tabWidth * CGFloat(idx) + tabWidth / 2 - 30), y: self.tabBar.frame.origin.y - 15, width: 60, height: 60)
            }
            UIView.animate(withDuration: 0.15, animations: {
                self.circleImageView.alpha = 0
            }) { (_) in
                self.circleImageView.image = self.image(with: item.image, scaledTo: CGSize(width: 30, height: 30))
                UIView.animate(withDuration: 0.15, animations: {
                    self.circleImageView.alpha = 1
                })
            }
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }
    private func image(with image: UIImage?, scaledTo newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, _: false, _: 0.0)
        image?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
