//
//  String+Ext.swift
//  NetflixCloneProgramaticly
//
//  Created by abdullah on 3.05.2024.
//

import Foundation

extension String {
    func capitalizeFirstLetter()->String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
