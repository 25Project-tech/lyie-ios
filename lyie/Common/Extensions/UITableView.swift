//
//  UITableView.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import UIKit

extension UITableView {
    func reloadDataWithoutScrolling() {
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }
}
