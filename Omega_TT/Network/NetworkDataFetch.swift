//
//  NetworkDataFetch.swift
//  Omega_TT
//
//  Created by Oleg on 10.02.2022.
// 

import Foundation


class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchAlbum(urlString: String, responce: @escaping(AlbumModel?, Error?) -> Void) {
        Network.shared.fetch(urlString: urlString) { result in
            
            switch result {
            case.success(let data):
                do {
                    let albums = try JSONDecoder().decode(AlbumModel.self, from: data)
                    responce(albums, nil)
                } catch let jsonError {
                    print("Error decode", jsonError)
                }
            case .failure(let error):
                print(error.localizedDescription)
                responce(nil, error)
            }
        }
        
    }
    
    func fetchTrackList(urlString: String, responce: @escaping(TracksModel?, Error?) -> Void) {
        Network.shared.fetch(urlString: urlString) { result in
            
            switch result {
            case.success(let data):
                do {
                    let albums = try JSONDecoder().decode(TracksModel.self, from: data)
                    responce(albums, nil)
                } catch let jsonError {
                    print("Error decode", jsonError)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
