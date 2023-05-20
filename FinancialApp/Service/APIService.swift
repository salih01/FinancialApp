//
//  APIService.swift
//  FinancialApp
//
//  Created by BilmSoft on 4.05.2023.
//

import Foundation
import Combine


struct APIService {
    
    let API_KEY = "P5BU3RREP6DR7WP7"
    
    //MARK: HTTP İSTEĞİ burada yapılıyor
    func fetchSymbolsPublisher(keyWords:String) -> AnyPublisher<SearchResults,Error> {
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keyWords)&apikey=P5BU3RREP6DR7WP7"
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
