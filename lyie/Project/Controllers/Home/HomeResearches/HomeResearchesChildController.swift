//
//  HomeResearchesChildController.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.02.2021.
//

import UIKit
import PDFKit
import Parse

protocol NavigateDelegate {
    func navigateResearchPage()
    func navigateMentorPage()
}

class HomeResearchesChildController: UIViewController {

    @IBOutlet var educationTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    var index = 0
    var researchesDelegate: NavigateDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        educationTableView.delegate = self
        educationTableView.dataSource = self
        self.educationTableView.register(UINib(nibName: "HomeResearchesCell", bundle: nil), forCellReuseIdentifier: "HomeResearchesCell")
        educationTableView.separatorStyle = .none
        educationTableView.backgroundColor = StyleManager.colors.backgroundColor
        mainView.backgroundColor = StyleManager.colors.backgroundColor
    }
}

extension HomeResearchesChildController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeResearchesCell = tableView.dequeueReusableCell(at: indexPath)
        cell.config(index: index)
        cell.navigateResearchesTapAction = { cell in
            cell.index = self.index
            let controller: ResearchesPDFControllerr = UIStoryboard.researches.instantiateViewController()
            if let path = Bundle.main.path(forResource: ResourcesService.getBundleText(by: self.index), ofType: ResourcesService.getBundleDesc(by: self.index)) {
                let url = URL(fileURLWithPath: path)
                if let pdfDocument = PDFDocument(url: url) {
                    controller.pdfPageIndex = pdfDocument.pageCount
                    controller.pdfIndex = self.index
                }
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550.0
    }
}

//extension HomeResearchesChildController {
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
//    //                                                ResearchesFileModel(objectId: object.object(forKey: "objectId"), title: object.object(forKey: "title"), desc: object.object(forKey: "desc"), coverImageURL: object.object(forKey: "coverImageURL"), coverImageFile: object.object(forKey: "coverImageFile"), file: )
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
//}
//
