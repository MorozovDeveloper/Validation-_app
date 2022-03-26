//
//  AlbumsTableViewCell.swift
//  Omega_TT
//
//  Created by Oleg on 08.02.2022.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {
    
    private var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var albumName: UILabel = {
        let label = UILabel()
        label.text = "Album name"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var artistName: UILabel = {
        let label = UILabel()
        label.text = "Artist name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var trackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "12 tracks"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView = UIStackView()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        albumImage.layer.cornerRadius = albumImage.frame.width / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SetupViews
    private func setupViews() {
        self.selectionStyle = .none
        
        self.addSubview(albumImage)
        self.addSubview(albumName)
        
        stackView = UIStackView(arrangedSubviews: [artistName, trackCountLabel],
                                axis: .horizontal,
                                spacing: 10,
                                distribution: .equalCentering)
        self.addSubview(stackView)
       
    }
    
    //MARK: СonfigureCell
    func configureCell(album: Album) {
        if let urlString = album.artworkUrl100 {
            Network.shared.fetch(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumImage.image = image
                case .failure(let error):
                    self?.albumImage.image = nil
                    print(error)
                }
            }
        } else {
            albumImage.image = nil
        }
        
        albumName.text = album.collectionName
        artistName.text = album.artistName
        trackCountLabel.text = "\(album.trackCount) tracks"
    }
    
    //MARK: SetConstraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            albumImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            albumImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            albumImage.heightAnchor.constraint(equalToConstant: 60),
            albumImage.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            albumName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            albumName.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 10),
            albumName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}
