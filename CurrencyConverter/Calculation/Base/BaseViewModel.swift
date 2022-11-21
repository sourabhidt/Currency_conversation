//
//  BaseViewModel.swift
//  Calculation
//
//  Created by Kripa on 20/11/22.
//

import Foundation

class BaseViewModel: NSObject {
    override init() {
        super.init()
        callService()
    }

    public func callService() {
        // childs should implement this
    }
}
