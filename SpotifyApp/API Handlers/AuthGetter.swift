//
//  AuthClass.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/10/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation


struct Auth: Codable {
    var access_token: String
    var token_type: String
    var expires_in: Int
    var refresh_token: String
    var scope: String
}
