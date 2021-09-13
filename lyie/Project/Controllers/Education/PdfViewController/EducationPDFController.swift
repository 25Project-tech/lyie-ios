//
//  EducationPDFController.swift
//  lyie
//
//  Created by Sevcan Eşim on 6.01.2021.
//

import UIKit
import WebKit
import PDFKit

class EducationPDFController: UIViewController, WKNavigationDelegate {
    
    
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
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if !EducationMainLessonsProvider.educationMainLessons().filter({ $0.type == "PDFCell"}).filter({ $0.mainEducation == studentEducationItem.mainEducation}).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue}).filter({ $0.mainEducationCellNum == studentEducationItem.mainEducationCellNum}).filter({ $0.childCellNum == studentEducationItem.currentEducationNum}).isEmpty {
                if studentEducationItem.currentEducationNum == EducationMainLessonsProvider.educationMainLessons().filter({ $0.type == "PDFCell"}).filter({ $0.mainEducation == studentEducationItem.mainEducation}).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue}).filter({ $0.mainEducationCellNum == studentEducationItem.mainEducationCellNum}).filter({ $0.childCellNum == studentEducationItem.currentEducationNum})[0].childCellNum {
                    EducationController.studentEducationUpdate()
                }
            }
        } else {
            EducationController.studentEducationUpdate()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
}

extension EducationPDFController {
    func config() {
        if let path = Bundle.main.path(forResource: "pdf", ofType: "pdf") {
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
