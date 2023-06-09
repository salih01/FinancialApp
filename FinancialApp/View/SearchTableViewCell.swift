//
//  SearchTableViewCell.swift
//  FinancialApp
//
//  Created by BilmSoft on 3.05.2023.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var assetNameLabel:UILabel!
    @IBOutlet weak var assetSymbolLabel: UILabel!
    @IBOutlet weak var assetTypeLabel:UILabel!
    
    
    
    func configure(searchResult:SearchResult){
        
        
        assetNameLabel.text   = searchResult.name
        assetSymbolLabel.text = searchResult.symbol
        assetTypeLabel.text   = searchResult.type
        
        
    }
    
    
}
