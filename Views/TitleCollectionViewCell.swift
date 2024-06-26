//
//  TitleCollectionViewCell.swift
//  NetflixCloneProgramaticly
//
//  Created by abdullah on 3.05.2024.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public func configure(with model:String) {
        
     
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else{return}
        
        posterImageView.backgroundColor = .clear
      posterImageView.sd_setImage(with: url)
    }
    
    
}
