//
//  SwiftGetter.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/13/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation

class UserGetter: Codable {
    var display_name: String
    var external_urls: [String: String]
    var href: String
    var id: String
}
