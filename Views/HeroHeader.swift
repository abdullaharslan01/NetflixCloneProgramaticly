//
//  HeroHeader.swift
//  NetflixCloneProgramaticly
//
//  Created by abdullah on 2.05.2024.
//

import UIKit

class HeroHeader: UIView {

    
    private let playButton: UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
        
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
         button.setTitle("Download", for: .normal)
         button.layer.borderColor = UIColor.white.cgColor
         button.layer.borderWidth = 1
         button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5

         return button
    }()
    
    
    
    private let heroImageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named:"heroImage")
        
        return imageView
        
    }()
    
    
    private func addGradient(){
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    

        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)

       applyConstraints()
            
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    func applyConstraints(){
        
        let playButtonConstaints = [
        
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .dWith/12),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: .dWith / 3)
        ]
        let downloadButtonConstaints = [
        
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * (.dWith/12)),
            
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            downloadButton.widthAnchor.constraint(equalToConstant: .dWith / 3 )
        ]
        NSLayoutConstraint.activate(playButtonConstaints)
        NSLayoutConstraint.activate(downloadButtonConstaints)
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
