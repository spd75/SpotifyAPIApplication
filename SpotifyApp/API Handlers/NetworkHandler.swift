//
//  NetworkHandler.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/4/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation
import Alamofire


class NetworkHandler {
    public static let spotifySearchEndpoint = "https://api.spotify.com/v1/search"
    public static let spotifySongEndpoint = "https://api.spotify.com/v1/tracks/"
    public static let spotifyUserEndpoint = "https://api.spotify.com/v1/me"
    public static let authorization = "Bearer BQCmcuTWGRJAKBxOsZjWnaXH9V8C2GB3KlebywWkMHsD7TFwmkgibs521a8CAXiectyBJMnw1UzyMR--zFpjFDPi4qhadetuA9MjcxN6q4fwgMIAJ4QX6dsyWHVmpsB_mXQ_lSHnaUV8upqeXJAc6FGWU8vS"
    
    public static var gotProfile = false
    
    
    public static func getUserProfile(completion: @escaping () -> Void)  {
        let header: HTTPHeaders = [
            "Authorization": AuthenticationHandler.authTokenWithBearer
        ]
        
        
        AF.request(spotifyUserEndpoint, method: .get, headers: header).validate().response { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                if let userStruct = try? decoder.decode(UserGetter.self, from: data!) {
                    UserInfo.name = userStruct.display_name
                    UserInfo.id = userStruct.id
                    getUserPlaylists(user: userStruct, completion: { playlists in
                        UserInfo.playlists = UserInfo.sortPlaylistsAlphabetial(playlistsArr: playlists)
                        completion()
                    })
                   
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    public static func getUserPlaylists(user: UserGetter, completion: @escaping ([Playlist]) -> Void) {
        let endpoint = "https://api.spotify.com/v1/users/\(user.id)/playlists"
        
        let header: HTTPHeaders = [
            "Authorization": AuthenticationHandler.authTokenWithBearer
        ]
        
        let parameters = [
            "limit": "30"
        ]
        
        AF.request(endpoint, method: .get, parameters: parameters, headers: header).validate().response { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                if let playlistArrStruct = try? decoder.decode(UserPlaylists.self, from: data!) {
                    var allPlaylists: [Playlist] = []
                    for playlist in playlistArrStruct.items {
                        getSpecificPlaylists(playlistEndpoint: playlist.href, completion: { playlistFetched in
                            allPlaylists.append(playlistFetched)
                        })
                    }
                    _ = Timer.scheduledTimer(withTimeInterval: 0.35, repeats: false, block: {_ in
                        completion(allPlaylists)
                    })
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    public static func getSpecificPlaylists(playlistEndpoint: String, completion: @escaping (Playlist) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": AuthenticationHandler.authTokenWithBearer
        ]
        
        AF.request(playlistEndpoint, method: .get, headers: header).validate().response { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                if let playlistStruct = try? decoder.decode(Playlist.self, from: data!) {
                    completion(playlistStruct)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    static func fetchImage(imageURL: String, completion: @escaping ((UIImage) -> Void)) {
        AF.request(imageURL, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(image)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    public static func searchSpotify(searchString: String, completion: @escaping ([Track]) -> Void) {

        let header: HTTPHeaders = [
            "Authorization": AuthenticationHandler.authTokenWithBearer
        ]

        let parameters: [String: Any] = [
            "q": searchString,
            "type": "track",
            "limit": 15
        ]

        AF.request(NetworkHandler.spotifySearchEndpoint, method: .get, parameters: parameters, headers: header).validate().response(completionHandler: { response in
            switch response.result {
            case .success(let data):
                let json = JSONDecoder()
                if let tracksData = try? json.decode(TrackSearch.self, from: data!) {
                    print("Got songs")
                    completion(tracksData.tracks.items)
                } else {
                    print("Failure")
                }
            case .failure(let error):
                debugPrint(error)
            }
        })
    }
    
    
    public static func getSong(id: String) {
        let endpoint = spotifySongEndpoint + id
        
        let header: HTTPHeaders = [
            "Authorization": authorization
        ]
        
        let parameters = [
            "id": id
        ]
        
        AF.request(endpoint, method: .get, parameters: parameters, headers: header).validate().response(completionHandler: { response in
        })
    }
    
}
