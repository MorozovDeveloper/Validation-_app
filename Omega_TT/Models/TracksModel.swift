//
//  SongsModel.swift
//  Omega_TT
//
//  Created by Oleg on 10.02.2022.
//

import Foundation


struct TracksModel: Decodable {
    
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
