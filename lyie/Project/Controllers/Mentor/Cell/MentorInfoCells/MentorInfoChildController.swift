//
//  MentorInfoChildController.swift
//  lyie
//
//  Created by Sevcan Eşim on 16.01.2021.
//

import UIKit
import Parse

class MentorInfoChildController: UIViewController {

    @IBOutlet var educationTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        educationTableView.delegate = self
        educationTableView.dataSource = self
        self.educationTableView.register(UINib(nibName: "MentorIDCell", bundle: nil), forCellReuseIdentifier: "MentorIDCell")
        educationTableView.separatorStyle = .none
        educationTableView.backgroundColor = StyleManager.colors.backgroundColor
        mainView.backgroundColor = StyleManager.colors.backgroundColor
    }
}

extension MentorInfoChildController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: MentorIDCell = tableView.dequeueReusableCell(at: indexPath)
            cell.selectionStyle = .none
            cell.config(index: index)
            return cell
        default:
            let cell: MentorIDCell = tableView.dequeueReusableCell(at: indexPath)
            cell.selectionStyle = .none
            cell.config(index: index)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
}

