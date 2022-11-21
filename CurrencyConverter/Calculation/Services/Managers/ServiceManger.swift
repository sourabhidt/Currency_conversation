//
//  ServiceManger.swift
//  Calculation
//
//  Created by Kripa on 20/11/22.
//

import Foundation
import Alamofire

struct APIServices {
    public static let shared = APIServices()
    
    func callCurrencies(queryItems: [URLQueryItem]? = nil, parameters: Parameters? = nil, success: @escaping (_ result: CurrencyResponse?) -> Void, failure: @escaping (_ failureMsg: FailureMessage) -> Void) {
        var headers = HTTPHeaders()
        headers["content-type"] = "application/json"
        //        headers["access_key"] = "EbEekpKsfsuBbiF2U1rJtty7LhLbAGkY"
        headers["apikey"] = "EbEekpKsfsuBbiF2U1rJtty7LhLbAGkY"
        //        "apikey", "EbEekpKsfsuBbiF2U1rJtty7LhLbAGkY"
        APIManager.shared.callAPI(strURL: AppConstants.URL.CURRENCIES_LATEST, queryItems: queryItems, method: .get, headers: headers, parameters: parameters, success: { response in
            do {
                if let data = response.data {
                    let createResponse = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                    print(response.result)
                    success(createResponse)
                }
            } catch {
                failure(FailureMessage(error.localizedDescription))
            }
            
        }, failure: { error in
            failure(FailureMessage(error))
        })
    }
}
