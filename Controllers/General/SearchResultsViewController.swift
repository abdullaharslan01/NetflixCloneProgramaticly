//
//  SearchResultTableViewCell.swift
//  NetflixCloneProgramaticly
//
//  Created by abdullah on 4.05.2024.
//

import UIKit

class SearchResultsViewController: UIViewController {

    
    public var titles: [Title] = [Title]()
    
    
    public let searchResultsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:  (.dWith / 3 ) - 10, height: 200)
        
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
       return collectionView
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        searchResultsCollectionView.pinToEdgesOf(view: view)
        
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self

        
    }

}


extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as! TitleCollectionViewCell
        
    
        
       cell.configure(with: titles[indexPath.item].poster_path ?? "//placeholder")
        
        return cell
    }
    
    
}
