//
//  Double+Currency.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import Foundation
extension NumberFormatter {
    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
}


public extension Double {
    var currency: String {
        return self.formatCurrency()
    }

    func formatCurrency(fraction min: Int? = 2, max: Int? = 2, signed: Bool = false) -> String {
        let formatter = NumberFormatter.currencyFormatter
        formatter.numberStyle = .currency

        if let min = min {
            formatter.minimumFractionDigits = min
        }

        if let max = max {
            formatter.maximumFractionDigits = max
        }

        if signed {
            let number = NSNumber(value: abs(self))
            let value = formatter.string(from: number) ?? ""
            
            return "\(String(describing: signal)) \(value)".trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
