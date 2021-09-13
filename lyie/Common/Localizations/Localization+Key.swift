//
//  Localization+Key.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

enum LocalizationKey: String {
    //MARK: - First Page - Login User Type
    case highSLoginText
    case mentorLoginText
    case inovatimLoginText
    
    //MARK: - Login
    case id
    case password
    case forget_password
    case login
    case or
    
    case register
    case error_email_not_valid
    case error_name_not_valid
    case error_surname_not_valid
    case error_password_contains_number
    case error_password_contains_uppercase
    case error_password_contains_special_char
    case error_password_contains_length
    case error_password_dont_match
    case user_activation_already_activated
    case user_activation_generic_error
    case error_password_not_found
    case error_name_not_found
    case error_surname_not_found
    case error_email_not_found
    case change_password_title
    case change_password_success
    case change_password_old_password_incorrect
    case placeholder_current_password
    case placeholder_new_password
    case placeholder_new_password_re
    
    //MARK: - Alert
    case internet_connection
    case error_occured
    
    //MARK: - Tabbar
    case tab1
    case tab2
    case tab3
    case tab4
    case tab5
    case tab6
    
    case male
    case female
    case other
}
