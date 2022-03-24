//
//  String + Location.swift
//  DinoEscape
//
//  Created by Thallis Sousa on 23/03/22.
//

import Foundation

extension String {
        // Nova função:
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localization",
            bundle: .main,
            value: self,             
            comment: self
        )
    }
}


