//
//  HomeEducationCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 22.12.2020.
//

import UIKit

class HomeEducationCell: UITableViewCell {
    
    static let reuseIdentifier = "HomeEducationCell"
    
    @IBOutlet weak var myTableView: UITableView!
    
    lazy var cells = [UIViewController]()
    
    var alertTapAction: ((HomeEducationCell) -> ())?
    var isMentor = false
    func config() {
        myTableView.dataSource = self
        myTableView.delegate = self
        
        let controller: HomeEducationsController = UIStoryboard.home.instantiateViewController()
        controller.popupDelegate = self
        controller.isMentor = isMentor
        cells.append(controller)
        myTableView.reloadData()
    }
}

extension HomeEducationCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 670.0
    }
    
}

extension HomeEducationCell: PopupDelegate {
    func alertView() {
        self.alertTapAction!(self)
    }
}
