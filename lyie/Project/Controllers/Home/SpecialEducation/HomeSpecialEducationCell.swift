//
//  HomeSpecialEducationCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 22.12.2020.
//

import UIKit

class HomeSpecialEducationCell: UITableViewCell {
    
    @IBOutlet weak var myTableView: UITableView!
    static let reuseIdentifier = "HomeSpecialEducationCell"
    lazy var cells = [UIViewController]()
    
    func config() {
        myTableView.dataSource = self
        myTableView.delegate = self
        
        let controller: HomeSpecialEducationsController = UIStoryboard.home.instantiateViewController()
        cells.append(controller)
        myTableView.reloadData()
    }
}

extension HomeSpecialEducationCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
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
        return 700.0
    }
    
}

