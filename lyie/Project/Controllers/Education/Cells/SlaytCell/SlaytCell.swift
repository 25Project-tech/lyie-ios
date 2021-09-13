//
//  SlaytCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 30.03.2021.
//

import UIKit

class SlaytCell: UITableViewCell {
    
    static let reuseIdentifier = "SlaytCell"
    @IBOutlet weak var pageView: UIView!
    
    func config(titleString: String, desc: String, imageName: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, indexRow: Int, videoUrl: String, cellId: Int) {
        pageView.overrideUserInterfaceStyle = .light
        let controller: ParentSlaytController = UIStoryboard.education.instantiateViewController()
        controller.pageCountValue = count
        controller.childEducationIndex = indexRow
    }
}
