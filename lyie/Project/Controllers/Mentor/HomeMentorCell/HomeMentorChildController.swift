//
//  HomeMentorChildController.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit

class HomeMentorChildController: UIViewController {

    @IBOutlet var educationTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    var index = 0
    var navigateMentorDelegate: NavigateDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        educationTableView.delegate = self
        educationTableView.dataSource = self
        self.educationTableView.register(UINib(nibName: "MentorInfoCell", bundle: nil), forCellReuseIdentifier: "MentorInfoCell")
        educationTableView.separatorStyle = .none
        educationTableView.backgroundColor = StyleManager.colors.backgroundColor
        mainView.backgroundColor = StyleManager.colors.backgroundColor
    }
}

extension HomeMentorChildController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: MentorInfoCell = tableView.dequeueReusableCell(at: indexPath)
            cell.selectionStyle = .none
            cell.config(index: index)
            cell.navigateMentorTapAction = { cell in
                self.navigateMentorDelegate.navigateMentorPage()
            }
            return cell
        default:
            let cell: MentorInfoCell = tableView.dequeueReusableCell(at: indexPath)
            cell.selectionStyle = .none
            cell.config(index: index)
            cell.navigateMentorTapAction = { cell in
                self.navigateMentorDelegate.navigateMentorPage()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93.0
    }
}
