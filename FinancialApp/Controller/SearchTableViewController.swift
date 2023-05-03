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
        sc.searchResultsUpdater = self // arama yapıldığında güncelleme işlemi
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false // arka plan buhulaştırma işlemi
        return sc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    //MARK: functions
    
    private func setupNavigationBar(){
        navigationItem.searchController = searchController
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
        
    }


}
extension SearchTableViewController : UISearchResultsUpdating,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

}

