//
//  ScoreListCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 26.12.2020.
//

import UIKit
import Parse

class ScoreListCell: UITableViewCell {
    
    static let reuseIdentifier = "ScoreListCell"
    
    @IBOutlet weak var scoreTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    var detailDesc = [String]()
    var detailValue = [Int]()
    var count = 0
    
    func config() {
        initTableView()
        scoreTableView.reloadData()
    }
    
    func initTableView() {
        calculatorScoreListCount()
        updateScoreDetail()
        mainView.makeShadow()
        scoreTableView.backgroundColor = StyleManager.colors.white
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
        scoreTableView.separatorStyle = .none
        self.scoreTableView.register(UINib(nibName: "ScoreDetailCell", bundle: nil), forCellReuseIdentifier: "ScoreDetailCell")
        self.scoreTableView.register(UINib(nibName: "ScoreCell", bundle: nil), forCellReuseIdentifier: "ScoreCell")
    }
}

//MARK:  - UITableViewDelegate, UITableViewDataSource
extension ScoreListCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailDesc.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: ScoreDetailCell = tableView.dequeueReusableCell(at: indexPath) as ScoreDetailCell
            cell.config()
            return cell
        default:
            let cell: ScoreCell = tableView.dequeueReusableCell(at: indexPath) as ScoreCell
            cell.config(scoreDesc: detailDesc[indexPath.row - 1], scoreValue: "\(detailValue[indexPath.row - 1])")
            return cell
            
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 170.0
        default:
            return 100.0
        }
    }
}

extension ScoreListCell {
    func updateScoreDetail() {
        detailDesc.removeAll(keepingCapacity: false)
        detailValue.removeAll(keepingCapacity: false)
        
        if let currentUser = PFUser.current() {
            let currentUserScore = currentUser.relation(forKey: "userScore")
            currentUserScore.query().findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    if objects.count > 0 {
                        for object in objects {
                            self.count = objects.count
                            self.detailDesc.append(object.object(forKey: "scoreDesc") as! String)
                            self.detailValue.append(object.object(forKey: "scoreValue") as! Int)
                            self.scoreTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func calculatorScoreListCount() {
        if let currentUser = PFUser.current() {
            let query = PFQuery(className: "UserScoreInfo")
            query.countObjectsInBackground { (count, error) in
                self.count = Int(count)
            }
        }
    }
}
