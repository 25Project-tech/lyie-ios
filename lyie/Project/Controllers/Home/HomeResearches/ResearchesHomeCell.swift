//
//  ResearchesHomeCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.02.2021.
//

import UIKit

class ResearchesHomeCell: UITableViewCell {
    
    static let reuseIdentifier = "ResearchesHomeCell"
    @IBOutlet weak var pageView: UIView!
    var navigateResearchPagesTapAction: ((ResearchesHomeCell) -> ())?
    func config() {
        pageView.overrideUserInterfaceStyle = .light
    }
}

extension ResearchesHomeCell: NavigateDelegate {
    func navigateResearchPage() {
        self.navigateResearchPagesTapAction!(self)
    }

    func navigateMentorPage() {}

}

