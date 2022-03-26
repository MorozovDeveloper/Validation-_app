//
//  AlbumsViewController.swift
//  Omega_TT
//
//  Created by Oleg on 08.02.2022.
//

import Foundation
import UIKit


class AlbumsTableVC: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
     let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var album = [Album]()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setConstrains()
        setNavigationBar()
        setupSearchController()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    //MARK: SetNavigationBar
    private func setNavigationBar() {
        navigationItem.title = "Albums"
        navigationItem.searchController = searchController
        
        let userInfoButton = createCustomButton(selector: #selector(userInfoButtonTapped))
        navigationItem.rightBarButtonItem = userInfoButton
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    //MARK: UserInfoButtonTapped
    @objc private func userInfoButtonTapped() {
        let userInfoViewController = UserInfoVC()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    //MARK: FetchAlbums
    private func fetchAlbums(albumName: String){
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) {[weak self] albumModel, error in
            
            if error == nil {
                guard let albumModel = albumModel else {return}
                if albumModel.results != [] {
                    _ = albumModel.results.sorted { firstName,secondName in
                        return firstName.collectionName.compare(secondName.collectionName) == ComparisonResult.orderedAscending} //сортировка
                    self?.album = albumModel.results
                    self?.tableView.reloadData()
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}

//MARK: UITableViewDataSource
extension AlbumsTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlbumsTableViewCell
        
        let album = album[indexPath.row]
        cell.configureCell(album: album)
        
        return cell
    }
}

//MARK: UITableViewDelegate
extension AlbumsTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAlbumViewController = DetailVC()
        let album = album[indexPath.row]
        detailAlbumViewController.album = album
        detailAlbumViewController.title = album.artistName
        
        navigationController?.pushViewController(detailAlbumViewController, animated: true)
    }
}

//MARK: UISearchBarDelegate
extension AlbumsTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != ""{
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.fetchAlbums(albumName: text!)
            })
        }
    }
}


