//
//  Constrains_AlbumsTableVC.swift
//  Omega_TT
//
//  Created by Oleg on 11.02.2022.
//

import UIKit


extension DetailVC {
    
     func setupViews() {
        view.backgroundColor = .white
        view.addSubview(albumImage)
        
        stackView = UIStackView(arrangedSubviews: [albumLabel,
                                                   artistLabel,
                                                   releaseDateLabel,
                                                   trackLabel],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .fillProportionally)
        view.addSubview(stackView)
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            albumImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            albumImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumImage.heightAnchor.constraint(equalToConstant: 100),
            albumImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 17),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}
