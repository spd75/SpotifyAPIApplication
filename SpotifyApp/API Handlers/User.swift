//
//  User.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/13/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation


class UserInfo {
    public static var name: String = ""
    public static var id: String = ""
    public static var playlists: [Playlist] = []
    
    static func sortPlaylistsAlphabetial(playlistsArr: [Playlist]) -> [Playlist] {
        var newPlaylistArr: [Playlist] = []
        var nameArr: [String] = []
        
        for playlist in playlistsArr {
            nameArr.append(playlist.name)
        }
        nameArr = nameArr.sorted()
        
       var j = 0
        while newPlaylistArr.count < playlistsArr.count {
            var i = 0
            var added = false

            while !added && i < playlistsArr.count {
                if playlistsArr[i].name == nameArr[j] {
                    newPlaylistArr.append(playlistsArr[i])
                    added = true
                }
                i += 1
            }
            j += 1
        }
        print(newPlaylistArr)
        return newPlaylistArr
    }
}
