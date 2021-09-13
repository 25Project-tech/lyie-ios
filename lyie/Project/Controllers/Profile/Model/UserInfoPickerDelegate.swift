//
//  UserInfoPickerDelegate.swift
//  lyie
//
//  Created by Sevcan Eşim on 9.12.2020.
//

import Foundation

 @objc protocol UserInfoPickerDelegate {
    func onPickerDismissed()
    @objc optional func onGenderSet(gender: String)
//    @objc optional func onCitySet(city: Int)
//    @objc optional func onPlaceOfBirthSet(city: Int)
    @objc optional func onAgeSet(date: Date)
    @objc optional func onClassSet(classNumber: String)
    @objc optional func onDepartmentSet(departmentName: String)
    @objc optional func onTypeSet(type: String)
}

