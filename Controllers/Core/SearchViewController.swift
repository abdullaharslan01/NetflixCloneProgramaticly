//
//  SearchViewController.swift
//  NetflixCloneProgramaticly
//
//  Created by abdullah on 1.05.2024.
//

import UIKit

protocol SearchViewControllerInterface{
    
   func configureViewController()
   func configureTableView()
   func searchMovie()

}



class SearchViewController: UIViewController {
    private var searchTableView: UITableView!

    private let searchController: UISearchController = {
        let searchContreller = UISearchController(searchResultsController: SearchResultsViewController())
        searchContreller.searchBar.placeholder = "Search fo a Movie or a Tv Show"
        
        searchContreller.searchBar.searchBarStyle = .minimal
        
        
        return searchContreller
    }()
    
    var titles: [Title] = [Title]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
        
        searchMovie()
        

    }
    

   
}

extension SearchViewController: SearchViewControllerInterface{
    func searchMovie() {
      
            APICaller.shared.getDiscoverMovies {[weak self] result in
                switch result {
                case .success(let titles):
                    
                    self?.titles = titles
                
                    DispatchQueue.main.async {
                        self?.searchTableView.reloadData()
                    }
                    
                    break
                case .failure(_):
                    break
                }
            }
        
    }
    
    func configureTableView() {
        searchTableView = UITableView(frame: .zero, style: .grouped)
        searchTableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        view.addSubview(searchTableView)
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.pinToEdgesOf(view: view)
        
        searchTableView.delegate  = self
        searchTableView.dataSource = self
    }
    
    func configureViewController() {
        navigationItem.searchController = searchController
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Search"
        navigationController?.navigationBar.tintColor = .label
        
        
        searchController.searchResultsUpdater = self
        
    }
    
    
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier) as! TitleTableViewCell
        
       
        let title = titles[indexPath.row]
       
        cell.configureWithModel(with: TitleViewModel(titleName: title.original_title ?? title.original_name ?? "Not founded", posterURL: title.poster_path ?? "/placeholder") )
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        print(searchBar.text ?? "")
        // Kullancının girdiği yazının kontrolünü yapıyoruz ve bu sayfaya bağlı olan controllere searchBar üzerinden ulaşıyoruz.
        guard let query = searchBar.text,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                    break
                case .failure( _):
                    break
                }
            }
        }
        
    }
    
    
}
