

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}


protocol HomeViewControllerInterface {
    func configureViewController()
    func configureTableView()
    func configureNavbar()
    func getTrendingMovies()
}



class HomeViewController: UIViewController {

    private var tableView: UITableView!
    
    let sectionTitles: [String] = ["Trending Movies","Trending Tv","Popular","Upcoming Movies","Top rated"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureNavbar()
        getTrendingMovies()
        
    }
    
    
    
}



extension HomeViewController: HomeViewControllerInterface{
    func getTrendingMovies() {
        
       
        
    }
    
    func configureNavbar() {
        
        let leftTitleButton = UIBarButtonItem(title: "For Abdullah", style: .plain, target: self, action: nil)
        let personButton =   UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil)
        
        let playButton =  UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        
      
        navigationController?.navigationBar.tintColor = .white

        navigationItem.leftBarButtonItem = leftTitleButton
        
        navigationItem.rightBarButtonItems = [
       
           personButton, playButton
        
        ]
            
    
        
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
       

    }
    
    
    
    func configureTableView() {
        
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinToEdgesOf(view: view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        let headerView = HeroHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: .dHeight / 2))
        
        tableView.tableHeaderView = headerView
        
    }
    
    
}




extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let title):
                    cell.configure(with: title)
                case .failure(_): break
                
                }
            }
            break
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs { result in
                switch result {
                case .success(let title):
                    cell.configure(with: title)
                case .failure(_): break
                
                }
            }
            break
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { result in
                switch result {
                case .success(let title):
                    cell.configure(with: title)
                case .failure(_): break
                
                }
            }
            break
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let title):
                    cell.configure(with: title)
                case .failure(_): break
                
                }
            }
            break
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { result in
                switch result {
                case .success(let title):
                    cell.configure(with: title)
                case .failure(_): break
                
                }
            }
            break
        default:
            break
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
                
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        header.textLabel?.textColor = .label
        
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        
        
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
        
    }
    

}


extension HomeViewController: CollectionTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            
            let vc = TitlePreviewViewController()
            
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
       
    }
    
    
}
