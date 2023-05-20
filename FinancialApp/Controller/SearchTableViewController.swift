//
//  ViewController.swift
//  FinancialApp
//
//  Created by BilmSoft on 1.05.2023.
//

import UIKit
import Combine

class SearchTableViewController: UITableViewController {

    var apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    
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
        performSearch()
        // Do any additional setup after loading the view.
    }
    
    //MARK: functions
    
    
    func performSearch(){
      
        apiService.fetchSymbolsPublisher(keyWords: "S&P500").sink { completion in
            switch completion {
            case .failure(let error):
                    print(error.localizedDescription)
            case .finished: break
                
            }
        } receiveValue: { SearchResults in
            print(SearchResults)
        }.store(in: &subscribers) //.store(in: &subscribers): sink operatörüne eklenen değerler, subscribers isimli bir koleksiyonda saklanır. Bu, yayıncının hala aktif olduğu sürece bellekte tutulmasını sağlar ve hafıza sızıntısını önler.

      
    }
    
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

