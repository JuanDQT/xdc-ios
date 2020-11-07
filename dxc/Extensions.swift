//
//  Extensions.swift
//  dxc
//
//  Created by Juan on 07/11/2020.
//

import UIKit

extension String {
    func toDate() -> Date? {
        if(self != nil) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd'-'MM'-'yyyy'"
            return dateFormatter.date(from: self)
        } else {
            return nil
        }
    }
}
