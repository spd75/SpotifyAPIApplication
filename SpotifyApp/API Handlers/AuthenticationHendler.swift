//
//  AuthenticationHendler.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/4/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation
import CommonCrypto
import Alamofire
import OAuthSwift
import CryptoKit


class AuthenticationHandler {
    public static var timer: Timer = Timer()
    
    public static let client_id = "203c7674f42f4e068d6ea6038e48c388"
    public static let redirect_uri = "http://www.blankwebsite.com/"
    public static var code_challenge = ""
    public static var code_verifier: String = ""
    public static var code = ""
    
    public static var authToken = ""
    public static var refreshToken = ""
    public static var tokenType = ""
    public static var authTokenWithBearer = ""
    
    
    public static func SHA(string: String) -> String {
        let x = SHA256.hash(data: Data(string.utf8))
        let y = Data(x)
        let z = AuthenticationHandler.toBase64URL(data: y)
        return z
    }
    
    
    
    
    public static func toBase64URL(data: Data) -> String {
        var result = data.base64EncodedString()
        result = result.replacingOccurrences(of: "+", with: "-")
        result = result.replacingOccurrences(of: "/", with: "_")
        result = result.replacingOccurrences(of: "=", with: "")
        return result
    }
    
    
    
    
    public static func genCodeVerifier() -> String {
        let count = Int.random(in: 50...125)
        var finString = ""
        
        for _ in 0...count {
            let d = Int.random(in: 0...2)
            let addition = d == 0 ? Int.random(in: 48...57) : d == 1 ? Int.random(in: 65...90) : Int.random(in: 97...122)
            finString += String(UnicodeScalar(UInt8(addition)))
        }
        
        return finString
    }
    
    
    
    
    public static func requestLogin(onCompletion: @escaping (_ request: String) -> Void) {
        let endpoint = "https://accounts.spotify.com/authorize"
        
        AuthenticationHandler.code_verifier = AuthenticationHandler.genCodeVerifier()
        AuthenticationHandler.code_challenge = AuthenticationHandler.SHA(string: AuthenticationHandler.code_verifier)
        
        
        let parameters = [
            "client_id": AuthenticationHandler.client_id,
            "response_type": "code",
            "redirect_uri": AuthenticationHandler.redirect_uri,
            "code_challenge_method": "S256",
            "code_challenge": AuthenticationHandler.code_challenge
        ]
    
        AF.request(endpoint, method: .get, parameters: parameters).responseString(completionHandler: { response in
            switch response.request {
            case .none:
                print("no request")
            case .some(let data):
                onCompletion("\(data)")
            }
            
            
        })
        
    }
    
    
    public static func getAuthToken() {
        
        let endpoint = "https://accounts.spotify.com/api/token"
        
        let header: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters = [
            "client_id": AuthenticationHandler.client_id,
            "grant_type": "authorization_code",
            "code": AuthenticationHandler.code,
            "redirect_uri": AuthenticationHandler.redirect_uri,
            "code_verifier": AuthenticationHandler.code_verifier
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, headers: header).responseJSON(completionHandler: { response in
            let decoder = JSONDecoder()
            if let jsonConvert = try? decoder.decode(Auth.self, from: response.data!) {
                AuthenticationHandler.authToken = jsonConvert.access_token
                AuthenticationHandler.refreshToken = jsonConvert.refresh_token
                AuthenticationHandler.tokenType = jsonConvert.token_type
                AuthenticationHandler.authTokenWithBearer = "Bearer \(jsonConvert.access_token)"
                
                AuthenticationHandler.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(jsonConvert.expires_in / 10), repeats: true, block: { _ in
                    AuthenticationHandler.getRefreshedAuthToken()
                    AuthenticationHandler.timer.invalidate()
                })
            } else {
                print("error")
            }
        })
        
        
    }
    
    
    public static func getAuthToken(completion: @escaping () -> Void) {
        
        let endpoint = "https://accounts.spotify.com/api/token"
        
        let header: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters = [
            "client_id": AuthenticationHandler.client_id,
            "grant_type": "authorization_code",
            "code": AuthenticationHandler.code,
            "redirect_uri": AuthenticationHandler.redirect_uri,
            "code_verifier": AuthenticationHandler.code_verifier
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, headers: header).responseJSON(completionHandler: { response in
            let decoder = JSONDecoder()
            if let jsonConvert = try? decoder.decode(Auth.self, from: response.data!) {
                AuthenticationHandler.authToken = jsonConvert.access_token
                AuthenticationHandler.refreshToken = jsonConvert.refresh_token
                AuthenticationHandler.tokenType = jsonConvert.token_type
                AuthenticationHandler.authTokenWithBearer = "Bearer \(jsonConvert.access_token)"
                
                AuthenticationHandler.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(jsonConvert.expires_in / 10), repeats: true, block: { _ in
                    AuthenticationHandler.getRefreshedAuthToken()
                    AuthenticationHandler.timer.invalidate()
                })
                
                completion()
                
                AuthenticationHandler.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(jsonConvert.expires_in / 10), repeats: true, block: { _ in
                    AuthenticationHandler.getRefreshedAuthToken()
                    AuthenticationHandler.timer.invalidate()
                })
            } else {
                print("error")
            }
        })
        
        
    }
    
    
    
    
    public static func getRefreshedAuthToken() {
        let endpoint = "https://accounts.spotify.com/api/token"
        
        let header: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters = [
            "grant_type": "refresh_token",
            "refresh_token": AuthenticationHandler.refreshToken,
            "client_id": AuthenticationHandler.client_id,
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, headers: header).responseJSON(completionHandler: { response in
            let decoder = JSONDecoder()
            if let jsonConvert = try? decoder.decode(Auth.self, from: response.data!) {
                AuthenticationHandler.authToken = jsonConvert.access_token
                AuthenticationHandler.refreshToken = jsonConvert.refresh_token
                AuthenticationHandler.tokenType = jsonConvert.token_type
                AuthenticationHandler.authTokenWithBearer = "Bearer \(jsonConvert.access_token)"
                
                AuthenticationHandler.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(jsonConvert.expires_in / 10), repeats: true, block: { _ in
                    AuthenticationHandler.getRefreshedAuthToken()
                    AuthenticationHandler.timer.invalidate()
                })
            } else {
                print("breh")
            }
        })
        
    }
    
}
