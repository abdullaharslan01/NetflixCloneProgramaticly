//
//  UpcomingViewController.swift
//  NetflixCloneProgramaticly
//
//  Created by abdullah on 1.05.2024.
//

import UIKit

protocol UpComingViewControllerInterface{
    
    func configureViewController()
    func configureTableView()
    func fetchUpComing()

}


class UpcomingViewController: UIViewController {

    private var upcomingTableView: UITableView!
     var titles: [Title] = [Title]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        fetchUpComing()

    }

}


extension UpcomingViewController: UpComingViewControllerInterface {
    func fetchUpComing() {
        APICaller.shared.getUpcomingMovies {[weak self] result in
            switch result {
            case .success(let titles):
                
                self?.titles = titles
            
                DispatchQueue.main.async {
                    self?.upcomingTableView.reloadData()
                }
                
                break
            case .failure(_):
                break
            }
        }
    }
    
    func configureTableView() {
        
        upcomingTableView = UITableView(frame: .zero, style: .grouped)
        upcomingTableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        view.addSubview(upcomingTableView)
        upcomingTableView.translatesAutoresizingMaskIntoConstraints = false
        upcomingTableView.pinToEdgesOf(view: view)
        
        upcomingTableView.delegate  = self
        upcomingTableView.dataSource = self
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Upcoming"

    }
    
    
}

extension UpcomingViewController: UITableViewDelegate,UITableViewDataSource{
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
