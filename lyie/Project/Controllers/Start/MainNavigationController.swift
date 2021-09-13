//
//  MainNavigationController.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        self.navigationBar.tintColor = UIColor.white
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      super.pushViewController(viewController, animated: animated)
    }
}

////MARK:GRADIENT COLOR CONFIG
extension MainNavigationController {
    class func addLogoToNavigationBarItem(view: UIView, tabBarController: UITabBarController, navigationController: UINavigationController, leftButtonA: UIButton, rightButtonA: UIButton) -> [UIButton] {
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.isTranslucent = false
        tabBarController.tabBar.barTintColor  = StyleManager.colors.white
        
        //Right Bar Button
        let rightBarIcon = UIImage(named: "Icons/right")?.withRenderingMode(.alwaysOriginal)
        rightButtonA.setImage(rightBarIcon, for: .normal)
        rightButtonA.tintColor = .white
        let rightBarButton = UIBarButtonItem(customView: rightButtonA)
        navigationController.navigationItem.rightBarButtonItem = rightBarButton
        
        //Left Button
        let leftBarIcon = UIImage(named: "Icons/left")?.withRenderingMode(.alwaysOriginal)
        leftButtonA.setImage(leftBarIcon, for: .normal)
        leftButtonA.tintColor = .white
        let leftBarButton = UIBarButtonItem(customView: leftButtonA)
        navigationController.navigationItem.leftBarButtonItem = leftBarButton
        
        return [rightButtonA, leftButtonA]
    }
    
    class func addLogo(navigationController: UINavigationController) {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Dashboard/inovatim")
        
        let view = UIView()
        navigationController.navigationItem.titleView = view
        navigationController.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    
    @objc func handleMenuToggle() {
        LyieLog.mPrint("-")
    }
    
    func getBackgroundColors() -> [UIColor] {
        var colors = [UIColor]()
        colors.append(StyleManager.colors.navigationBarGradientColorFirst)
        colors.append(StyleManager.colors.navigationBarGradientColorSecond)
        return colors
    }
}



//MARK:InternetConnectivity Alert
extension MainNavigationController {
    ///Add Device Disconnected Alert top of tabbar
    func prepareInternetConnectivityTopView() {
        let initialHeight = self.navigationBar.frame.height
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationBar.frame.height)
        
        let myView = Bundle.loadView(fromNib: "InternetConnectivityAlert", withType: InternetConnectivityAlert.self)
        myView.textLabel.text = .localized(.internet_connection)
        
        myView.frame = CGRect(x: 0, y: 0, width: (self.view.frame.width), height: 40)
        myView.center = CGPoint(x: (self.view.frame.width)/2, y: topBarHeight + 20)
        myView.alpha = 0.9
        self.view.addSubview(myView)
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
            myView.alpha = 0.8
        }, completion: {(finished: Bool) in
            UIView.animate(withDuration: 2, delay: 2, options: .curveEaseOut, animations: {
                myView.alpha = 0
            }, completion: {(finished: Bool) in
                myView.removeFromSuperview()
            })
        })
    }
}
