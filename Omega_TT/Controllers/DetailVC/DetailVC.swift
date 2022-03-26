//
//  DetailAlbumViewController.swift
//  Omega_TT
//
//  Created by Oleg on 08.02.2022.
//

import UIKit


class DetailVC: UIViewController  {
    
     let albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let albumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Name album"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "Name artist"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let artistDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let trackLabel: UILabel = {
        let label = UILabel()
        label.text = "12 tracks"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.register(TracksCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
     var stackView = UIStackView()
    
    var album: Album?
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegate()
        setModel()
        fetchSong(album: album)
        setModel()
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: SetModel
    private func setModel() {
        guard let album = album else {return}
        albumLabel.text = album.collectionName
        artistLabel.text = album.artistName
        trackLabel.text = "\(album.trackCount) tracks"
        releaseDateLabel.text = setDateFormatter(date: album.releaseDate)
        
        guard let url = album.artworkUrl100 else {return}
        setImage(urlString: url)
    }
    
    //MARK: SetDateFormatter
    private func setDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backendDate = dateFormatter.date(from: date) else {return ""}
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from: backendDate)
        return date
    }
    
    //MARK: SetImage
    private func setImage(urlString: String?){
        if let url = urlString {
            Network.shared.fetch(urlString: url) { [weak self] result in
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
    }
    
    //MARK: FetchSong
    private func fetchSong(album: Album?){
        guard let album = album else {return}
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        
        NetworkDataFetch.shared.fetchTrackList(urlString: urlString) { [weak self] songModel, error in
            if error == nil {
                guard let songModel = songModel else {return}
                self?.songs = songModel.results
                self?.collectionView.reloadData()
            } else {
                print("Error localizedDescription")
            }
        }
    }
}

//MARK: UICollectionView
extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TracksCollectionViewCell
        let song = songs[indexPath.row].trackName
        cell.songName.text = song
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.frame.width,
            height: 20
        )
    }
}


