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
    
    func formatDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy"
            return outputFormatter.string(from: date)
        }
        return self 
    }
}
