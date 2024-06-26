//
//  TitleTableViewCell.swift
//  NetflixCloneProgramaticly
//
//  Created by abdullah on 4.05.2024.
//

import UIKit
import SDWebImage
class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let titlesPosterUIImageView: UIImageView = {
       
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
        
    }()
    
    
    private let playTitleButton: UIButton = {
       
        let button = UIButton()
        
        let image = UIImage(systemName:"play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
    
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        contentView.addSubview(titleLabel)
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()


    }
    
    private func applyConstraints() {
           let titlesPosterUIImageViewConstraints = [
               titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
               titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
               titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
           ]
           
           
           let titleLabelConstraints = [
               titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
               titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
           ]
           
           
           let playTitleButtonConstraints = [
               playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
               playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
           ]
           
           NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
           NSLayoutConstraint.activate(titleLabelConstraints)
           NSLayoutConstraint.activate(playTitleButtonConstraints)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureWithModel(with model: TitleViewModel) {
        
       
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else{return}
        
        titlesPosterUIImageView.sd_setImage(with: url )
        titleLabel.text = model.titleName
        
    
        
    }
    
    
    
}
