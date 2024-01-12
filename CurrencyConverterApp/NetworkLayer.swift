//
//  NetworkLayer.swift
//  CurrencyConverterApp
//
//  Created by 전율 on 2023/11/08.
//

import Foundation

struct NetworkLayer {
    static func fetchJson(completion: @escaping (CurrencyModel) -> Void) {
        let urlString = "https://open.er-api.com/v6/latest/USD"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, reponse, error in
            guard let data = data else { return }
            do {
                let currencyModel =  try JSONDecoder().decode(CurrencyModel.self, from: data)
                completion(currencyModel)
            } catch {
                print("error ::: ",error)
            }
        }.resume()
    }
    
    enum error:Error {
        case badUrl
        case badStatusCode
    }
    
    static func fetchJsonAsync() async throws -> CurrencyModel  {
        let urlString = "https://open.er-api.com/v6/latest/USD"
        guard let url = URL(string: urlString) else { throw error.badUrl }
        do{
            let (data,response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw error.badStatusCode
            }
            let currencyModel =  try JSONDecoder().decode(CurrencyModel.self, from: data)
            return currencyModel
        }catch{
            print("error ::: ",error)
            throw error
        }
    }
    
}
