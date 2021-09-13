//
//  QuestionAreaCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 16.01.2021.
//

import UIKit

class QuestionAreaCell: UITableViewCell {
    
    static let reuseIdentifier = "QuestionAreaCell"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var educationTableView: UITableView!
    
    var navigateSpecificTapAction: ((QuestionAreaCell) -> ())?
    var index = 0
    
    func config() {
        initTableView()
        mainView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        leftView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Mentor Soru Alanı"
        titleText.textColor = StyleManager.colors.leftTitleColor
    }
    
    func initTableView()  {
        educationTableView.backgroundColor = StyleManager.colors.white
        educationTableView.delegate = self
        educationTableView.dataSource = self
        educationTableView.separatorStyle = .none
        self.educationTableView.register(UINib(nibName: "QuestionEducationCell", bundle: nil), forCellReuseIdentifier: "QuestionEducationCell")
        self.educationTableView.register(UINib(nibName: "EducationsCell", bundle: nil), forCellReuseIdentifier: "EducationsCell")
    }
}

//MARK:  - UITableViewDelegate, UITableViewDataSource
extension QuestionAreaCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: QuestionEducationCell = tableView.dequeueReusableCell(at: indexPath)
            if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                if studentEducationItem.education101aiNum == 1 {
                    cell.configMentorYapayZeka()
                }
                if studentEducationItem.education101inoNum == 1 {
                    cell.configMentorIno()
                }
                if studentEducationItem.education101iotNum == 1 {
                    cell.configMentorIot()
                }
            }
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell: EducationsCell = tableView.dequeueReusableCell(at: indexPath) as EducationsCell
            cell.configDetail(Education: .inovation, CellNumber: indexPath.row, goalData: 100, percentViewActive: true, lockIconHidden: true, completed: true, isProfile: true)
            return cell

        default:
            let cell: QuestionEducationCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configMentorIno()
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 180.0
        case 1:
            return 120.0
        default:
            return 180.0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            self.navigateSpecificTapAction!(self)
        case 2:
            self.navigateSpecificTapAction!(self)
        default:
            break
        }
    }
}
