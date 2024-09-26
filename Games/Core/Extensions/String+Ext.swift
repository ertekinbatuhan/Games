//
//  String+Ext.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 26.09.2024.
//

import Foundation

extension String {
    func cleanedDescription() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
