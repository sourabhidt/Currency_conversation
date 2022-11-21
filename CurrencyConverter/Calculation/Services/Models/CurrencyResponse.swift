//
//  CurrencyResponse.swift
//  Calculation
//
//  Created by Kripa on 20/11/22.
//

import Foundation

class CurrencyResponse: Decodable {
    var rates: [String: Double]?
    var symbols: [String]?
    var base: String?
}
