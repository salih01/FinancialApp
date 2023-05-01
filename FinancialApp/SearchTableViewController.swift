//
//  ViewController.swift
//  FinancialApp
//
//  Created by BilmSoft on 1.05.2023.
//

import UIKit

class SearchTableViewController: UITableViewController {

    private lazy var searchController:UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        
        return sc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
extension SearchTableViewController : UISearchResultsUpdating,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    
    
}

