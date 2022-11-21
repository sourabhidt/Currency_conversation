//
//  HttpError.swift
//  Calculation
//
//  Created by Kripa on 20/11/22.
//

import Foundation

enum HTTPError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
}
