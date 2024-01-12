//
//  Model.swift
//  CurrencyConverterApp
//
//  Created by 전율 on 2023/11/03.
//

import Foundation

/*
    {
    "result": "success",
    "provider": "https://www.exchangerate-api.com",
    "documentation": "https://www.exchangerate-api.com/docs/free",
    "terms_of_use": "https://www.exchangerate-api.com/terms",
    "time_last_update_unix": 1698969751,
    "time_last_update_utc": "Fri, 03 Nov 2023 00:02:31 +0000",
    "time_next_update_unix": 1699056621,
    "time_next_update_utc": "Sat, 04 Nov 2023 00:10:21 +0000",
    "time_eol_unix": 0,
    "base_code": "USD",
    "rates": {
        "USD": 1,
        "AED": 3.6725,
        "XAF": 617.648564,
        }
    }
 */

struct CurrencyModel:Codable {
    let result: String?
    let provider: String?
    let baseCode: String?
    let rates: [String:Double]?
    let time: Int?
    
    enum CodingKeys: String, CodingKey {
        case result
        case provider
        case baseCode = "base_code" // 별칭 변경
        case rates
        case time = "time_last_update_unix"
    }
    
}
