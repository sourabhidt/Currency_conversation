//
//  CurrencyViewModel.swift
//  Calculation
//
//  Created by Kripa on 20/11/22.
//

import Foundation

class CurrencyViewModel: BaseViewModel {
    var currenciesLoaded: ((CurrencyResponse, Bool) -> Void)?
    var currencyList: [String: Double]!
    var currencyKeys: [String]?
    var currencyValues: [Double]?
    //var baseCurrency: String = "base=EUR"
    override func callService() {
        APIServices.shared.callCurrencies(success: { result in
            if let response = result {
                //print(response.rates?.keys)
                //print(response)
                self.handleResponse(response: response, success: true)
            }
        }, failure: { failureMsg in
            print(failureMsg)
            self.handleResponse(response: nil, success: false)
        })
    }

    private func handleResponse(response: CurrencyResponse?, success: Bool) {
        if let currenciesLoaded = self.currenciesLoaded {
            currenciesLoaded(response!, success)
            if let _ = response?.rates {
                print("data found")
            }
        }
    }
}
