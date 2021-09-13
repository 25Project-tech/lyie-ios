//
//  InovatimController.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit
import Alamofire
import Reachability


class InovatimController: UIViewController, UITableViewDelegate, UITableViewDataSource, Localizable, Styleable {
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    var leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    var rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    lazy var cells = [UIViewController]()
    
    func applyLanguage() {
    }
    
    func applyStyle() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingStyle()
        startObservingLanguage()
        configView()
        config()
    }
    
    deinit {
        stopObservingStyle()
        stopObservingLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.hidesBottomBarWhenPushed = false
        tabBarController?.tabBar.isHidden = false
    }
}

extension InovatimController {
    
    func configView() {
        let buttonArray = MainNavigationController.addLogoToNavigationBarItem(view: mainView, tabBarController: tabBarController!, navigationController: navigationController!, leftButtonA: leftButton, rightButtonA: rightButton)
        self.rightButton = buttonArray[0]
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        rightButton.addTarget(self, action: #selector(rightButtonPressed(sender:)), for: .touchUpInside)
        
        self.leftButton =  buttonArray[1]
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        leftButton.addTarget(self, action: #selector(leftButtonPressed(sender:)), for: .touchUpInside)
        
        mainView.backgroundColor = StyleManager.colors.backgroundColor
        myTableView.backgroundColor = StyleManager.colors.backgroundColor
    }
    
    @objc private func rightButtonPressed(sender: UIBarButtonItem) {
        LyieLog.mPrint("right button pressed")
    }
    
    @objc private func leftButtonPressed(sender: UIBarButtonItem) {
        LyieLog.mPrint("left button pressed")
    }
    
    func config() {
        if let controller: HomeSpecialEducationsController = storyboard?.instantiateViewController() {
            cells.append(controller)
            myTableView.reloadData()
        }
    }
}



extension InovatimController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if indexPath.row != cells.count {
            cell.contentView.embed(cells[indexPath.row].view)
            cell.reloadInputViews()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
