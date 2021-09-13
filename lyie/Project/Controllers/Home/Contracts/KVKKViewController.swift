//
//  KVKKViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 6.05.2021.
//

import UIKit
import WebKit
import PDFKit

class KVKKViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
        mainView.backgroundColor = StyleManager.colors.backgroundColor
        
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
    
}

extension KVKKViewController {
    func config() {
        if let path = Bundle.main.path(forResource: "KVKK", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url: url) {
                pdfView.autoScales = true
                pdfView.displayMode = .singlePageContinuous
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
                self.pdfView?.subviews[0].backgroundColor = StyleManager.colors.backgroundColor
            }
        }
    }
}


