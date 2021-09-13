//
//  UIApplication.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import UIKit

extension UIApplication {

    static func openAppSettings(completion: @escaping (_ isSuccess: Bool) -> ()) {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            completion(false)
            return
        }

        let app = UIApplication.shared

        app.open(url) { isSuccess in
            completion(isSuccess)
        }
    }
}
