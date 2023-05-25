//
//  ViewController.swift
//  FinancialApp
//
//  Created by BilmSoft on 1.05.2023.
//

import UIKit
import Combine

class SearchTableViewController: UITableViewController {
    //MARK: ENUM
    private enum Mode {
        case onboarding
        case search
    }
    

    var apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    @Published private var searchQuery = String() //@Published özniteliği, değeri yayınlamak ve yayıncı-abone modelini kullanmak için hızlı ve basit bir yol sağlar. Değerin değiştiğini otomatik olarak algılayabilir ve dinleyicilere bu değişiklikleri bildirebilirsiniz.
    @Published private var mode :Mode = .onboarding
    private var searchResults:SearchResults?
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
        //performSearch()
        observeForm()
        // Do any additional setup after loading the view.
    }
    
    //MARK: functions

    private func observeForm(){
        $searchQuery.debounce(for: .milliseconds(50), scheduler: RunLoop.main)// arama süresi her 750 milisaniye de arama güncellenecek
            .sink { searchQuery in
                self.apiService.fetchSymbolsPublisher(keyWords: searchQuery).sink { completion in
                    switch completion {
                    case .failure(let error):
                            print(error.localizedDescription)
                    case .finished: break
                        
                    }
                } receiveValue: { searchResults in
                    self.searchResults = searchResults
                    self.tableView.reloadData()
                }.store(in: &self.subscribers)
            }.store(in: &subscribers) //.store(in: &subscribers): sink operatörüne eklenen değerler, subscribers isimli bir koleksiyonda saklanır. Bu, yayıncının hala aktif olduğu sürece bellekte tutulmasını sağlar ve hafıza sızıntısını önler.
        
        $mode.sink { [unowned self] (mode) in
            switch mode {
            case .onboarding:
                let redView = UIView()
                redView.backgroundColor = .red
                self.tableView.backgroundView = redView
            
            case .search:
                self.tableView.backgroundColor = nil
                
            }
        }.store(in: &subscribers)



    }
    
    private func setupNavigationBar(){
        navigationItem.searchController = searchController
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        if let searchResults = self.searchResults {
            let searchResult = searchResults.items[indexPath.row]
            cell.configure(searchResult: searchResult)
        }
        
        return cell
        
    }


}
extension SearchTableViewController : UISearchResultsUpdating,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else { return }
        self.searchQuery = searchQuery
        print(searchQuery)
    }
}

