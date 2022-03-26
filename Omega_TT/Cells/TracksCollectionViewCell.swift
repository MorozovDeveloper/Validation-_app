//
//  SongsCollectionViewCell.swift
//  Omega_TT
//
//  Created by Oleg on 08.02.2022.
//

import UIKit

class TracksCollectionViewCell: UICollectionViewCell {
    
    let songName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setConstrains() {
        self.addSubview(songName)
        NSLayoutConstraint.activate([
            songName.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            songName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            songName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            songName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    
}
