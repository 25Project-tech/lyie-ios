//
//  SearchCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 10.01.2021.
//

import UIKit

class SearchCell: UITableViewCell {
    static let reuseIdentifier = "SearchCell"
    
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    
    func config(uni: UniversityServices) {
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = uni.name
    }
    
    func config(dept: DepartmentServices) {
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = dept.name
    }
    
    func config(hscholl: HighSchoolServices) {
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = hscholl.name
    }
    
    func config(cities: CityServices) {
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = cities.name
    }
    
    func config(birthCities: CityServices) {
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = birthCities.name
    }
    
    func config(hgDept: DepartmentService) {
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = hgDept.name
    }
    
    
//    func config(uni: String) {
//        titleText.textColor = StyleManager.colors.leftTitleColor
//        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
//        titleText.text = uni.name
//    }
//    
//    func config(dept: DepartmentServices) {
//        titleText.textColor = StyleManager.colors.leftTitleColor
//        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
//        titleText.text = dept.name
//    }
//    
//    func config(hscholl: String) {
//        titleText.textColor = StyleManager.colors.leftTitleColor
//        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
//        titleText.text = hscholl.name
//    }
//    
//    func config(cities: String) {
//        titleText.textColor = StyleManager.colors.leftTitleColor
//        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
//        titleText.text = cities.name
//    }
//    
//    func config(birthCities: String) {
//        titleText.textColor = StyleManager.colors.leftTitleColor
//        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
//        titleText.text = birthCities.name
//    }
}
