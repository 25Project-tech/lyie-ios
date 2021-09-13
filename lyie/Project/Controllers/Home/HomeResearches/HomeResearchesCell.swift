//
//  HomeResearchesCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.02.2021.
//

import UIKit
import PDFKit
import Parse

class HomeResearchesCell: UITableViewCell {
    
    static let reuseIdentifier = "HomeResearchesCell"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var pdfView: UIView!
    @IBOutlet weak var researchImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var readButtonView: UIView!
    @IBOutlet weak var researchesTextLabel: UILabel!
    
    var navigateResearchesTapAction: ((HomeResearchesCell) -> ())?
    var index = 0
    
    func config(index: Int) {
        createdRealmObj()
        parseTransaction(index: index)
        
        self.pdfView.backgroundColor = .white
        self.leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        self.mainView.makeShadow()
        self.titleText.text = "ARAŞTIRMALAR"
        self.titleText.textColor = StyleManager.colors.leftTitleColor
        self.readButton.setTitle("Araştırmayı Oku", for: .normal)
        self.readButton.backgroundColor = StyleManager.colors.leftTitleColor
        self.researchesTextLabel.textColor = StyleManager.colors.leftTitleColor
        self.readButtonView.makeShadow()
        self.readButtonView.cornerRadius = 10.0
    }

    func parseTransaction(index: Int) {
        if let researchItem = ResearchProvider.researchs(for: "\(index)") {
            self.researchesTextLabel.text = researchItem.title
            self.descLabel.text = researchItem.desc
            LyieUtils.loadImage(resource: researchImage, imageURL: researchItem.coverUrl, placeHolder: UIImage(named: "Researches/\(index + 1)"), isCircle: false)
        }
    }
    
    func createdRealmObj() {
        let query = PFQuery(className: "Researches")
        query.findObjectsInBackground { objects, error in
            if error != nil  {
                print(error?.localizedDescription)
            } else {
                if let objects = objects {
                    if ResearchProvider.researchs().count != objects.count {
                        ResearchNotifier.shared.removeAll()
                        for i in 0..<objects.count {
                            ResearchProvider.create(with: "\(i)")
                            if var researchItem = ResearchProvider.researchs(for: "\(i)") {
                                researchItem.title = objects[i]["title"] as? String ?? ""
                                researchItem.desc = objects[i]["desc"] as? String ?? ""
                                researchItem.coverUrl = objects[i]["coverImageURL"] as? String ?? ""
                                ResearchProvider.update(researchs: researchItem)
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func readButtonTapped(_ sender: Any) {
        LyieLog.mPrint("readButtonTapped")
        self.navigateResearchesTapAction!(self)
    }
}
