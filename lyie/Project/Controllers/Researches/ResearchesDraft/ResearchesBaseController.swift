//
//  ResearchesBaseController.swift
//  lyie
//
//  Created by Sevcan Eşim on 20.02.2021.
//

import Foundation
import UIKit

protocol RegisterWizardListenerForProfileUpdate {
    /// Move Next Stage
    func onNextStage()
    /// Move Previous Stage
    func onPreviousStage()
    /// Dismiss
    func onDismiss()
}

//protocol UserInfoPickerDelegateForProfileUpdate {
//    /// Update Current User Gender and Firebase
//    func onGenderSet(gender: String)
//    /// Update Current User Weight and Firebase
//    func onWeightSet(weight: Double)
//    /// Update Current User Height and Firebase
//    func onHeightSet(height: Double)
//    /// Update Current User Birthday and Firebase
//    func onAgeSet(date: Date)
//}

class ResearchesBaseController: UIViewController {
    var registerWizardListenerForProfileUpdate: RegisterWizardListenerForProfileUpdate!
//    var userInfoPickerDelegateForProfileUpdate: UserInfoPickerDelegateForProfileUpdate!
}


