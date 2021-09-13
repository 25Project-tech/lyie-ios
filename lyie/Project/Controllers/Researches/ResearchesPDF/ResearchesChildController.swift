//
//  ResearchesChildController.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.04.2021.
//

import UIKit
import PDFKit
import Parse

class ResearchesChildControllerr: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    //    @IBOutlet weak var pdfView: PDFView!
    var index = 0
    var angle = 0
    var pdfIndex = 0
    var pdfViewMain: PDFView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = StyleManager.colors.backgroundColor
        self.pdfViewMain = PDFView()
        if let path = Bundle.main.path(forResource: ResourcesService.getBundleText(by: pdfIndex), ofType: ResourcesService.getBundleDesc(by: pdfIndex)) {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url: url) {
                pdfViewMain?.document = pdfDocument
                if let pageIndex = pdfDocument.page(at: self.index) {
                    pageIndex.rotation = 270
                    pdfViewMain?.go(to: pageIndex)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.config()
        }
    }
}

extension ResearchesChildControllerr {
    func config() {
        pdfViewMain?.autoScales = true
        pdfViewMain?.displayDirection = .vertical
        pdfViewMain?.displayMode = .singlePage
        let width = self.view.frame.width
        let height = self.view.frame.height
        self.pdfViewMain!.frame = CGRect(x: 0, y: 0, width: width, height: height)
        pdfViewMain?.backgroundColor = .clear
        //                    self.pdfViewMain!.backgroundColor = .white
        self.view.addSubview(self.pdfViewMain!)
        //                if let pageIndex = pdfDocument.page(at: self.index) {
        //
        //                    pdfViewMain?.maxScaleFactor = 4.0
        //
        //
        ////                    pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        //
        ////                    let pageBounds = pageIndex.bounds(for: pdfView.displayBox)
        ////                    pdfView.scaleFactor = (pdfView.bounds.width -   * 2) / pageBounds.width
        //                }
        
        
        //                self.pdfView?.subviews[0].backgroundColor = StyleManager.colors.backgroundColor
        
    }
//    
//    func updateResearches() {
//        let query = PFQuery(className: "Researches")
//        let pdfQuery = PFQuery(className: "Files")
//       
//        query.findObjectsInBackground { (objects, error) in
//            if error != nil {
//                print(error?.localizedDescription)
//            } else {
//                if let objects = objects {
//                    if objects.count > 0 {
//                        for object in objects {
//                            
//                            pdfQuery.whereKey("objectId", equalTo: object.objectId)
//                            query.whereKey("pdfFile", matchesQuery: pdfQuery)
//                            
//                            query.findObjectsInBackground { (objs, error) in
//                                if error != nil {
//                                    print(error?.localizedDescription)
//                                } else {
//                                    if let objs = objs {
//                                        if objs.count > 0 {
//                                            for obje in objs {
//                                                
////                                                ResearchesFileModel(objectId: object.object(forKey: "objectId"), title: object.object(forKey: "title"), desc: object.object(forKey: "desc"), coverImageURL: object.object(forKey: "coverImageURL"), coverImageFile: object.object(forKey: "coverImageFile"), file: )
//                                                if obje.object(forKey: "file") != nil {
//                                                    if let pdfDocument = PDFDocument(url: obje.object(forKey: "file") as! URL) {
//                                                        self.pdfViewMain?.document = pdfDocument
//                                                        if let pageIndex = pdfDocument.page(at: self.index) {
//                                                            pageIndex.rotation = 270
//                                                            self.pdfViewMain?.go(to: pageIndex)
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
}
