//
//  SpotifyGetter.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/4/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation


// The structs below are used for getting all the user playlists

struct UserPlaylists: Codable {
    var items: [UserPlaylist]
}

struct UserPlaylist: Codable {
    var description: String
    var href: String
    var images: [Image]
    var name: String
    var tracks: PlaylistTrackInfo
    var uri: String
}

struct Image: Codable {
    var height: Int
    var url: String
    var width: Int
}

struct PlaylistTrackInfo: Codable {
    var href: String
    var total: Int
}



// The structs below are used to breakdown a specific playlist

struct Playlist: Codable {
    var name: String
    var id: String
    var tracks: ItemsInTracks
}

struct ItemsInTracks: Codable {
    var items: [TrackInfo]
}

struct TrackInfo: Codable {
    var track: Track
}

struct Track: Codable {
    var album: Album
    var artists: [Artist]
    var duration_ms: Int
    var id: String
    var name: String
    var popularity: Int
    var uri: String
    
    func getPopularity() -> String {
        if popularity >= 94 {
            return "Billboard Hit"
        } else if popularity >= 90 {
            return "Billboard Potential"
        } else if popularity >= 80 {
            return "Hit"
        } else if popularity >= 70 {
            return "Well-Known"
        } else if popularity >= 60 {
            return "Average"
        } else if popularity >= 45 {
            return "Unpopular"
        } else if popularity >= 20 {
            return "Very Unpopular"
        } else if popularity >= 1 {
            return "Unheard-of"
        }
        
        return "Undetermined"
    }
}

struct Album: Codable {
    var href: String
    var id: String
    var images: [Image]
    var release_date: String
    var name: String
}

struct Artist: Codable {
    var href: String
    var id: String
    var name: String
    var uri: String
}


// The struct below is used only for a search

struct TrackSearch: Codable {
    var tracks: ItemsInTracksForSearch
}

struct ItemsInTracksForSearch: Codable {
    var items: [Track]
}


