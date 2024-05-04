//
//  CollectionViewTableViewCell.swift
//  NetflixCloneProgramaticly
//
//  Created by abdullah on 1.05.2024.
//

import UIKit


protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}



class CollectionViewTableViewCell: UITableViewCell {

    
    weak var delegate: CollectionTableViewCellDelegate?
    
    static let identifier = "CollectionViewTableViewCell"
    
    private var titles: [Title] = [Title]()

    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()

        layout.collectionView?.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
   
    override init(style:UITableViewCell.CellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCollectionViewCell()
       
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
        }
        
        
    }

}


extension CollectionViewTableViewCell {
    
    func configureCollectionViewCell(){
        
        contentView.addSubview(collectionView)
        collectionView.pinToEdgesOf(view: contentView)
    
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}



extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as! TitleCollectionViewCell
        
        
        guard let poster_path = titles[indexPath.item].poster_path else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: poster_path)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_name ?? title.original_title else {
            return
        }
        
        APICaller.shared.getMovie(with: titleName + " trailler") { [weak self] result in
            switch result {
            case .success(let videoElement):

                let title = self?.titles[indexPath.row]

                guard let strongSelf = self else {return}
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title?.overview ?? "")
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)

                break
            case .failure(_):
                break
            }
        }
        
    }
    
    
    
    
}
