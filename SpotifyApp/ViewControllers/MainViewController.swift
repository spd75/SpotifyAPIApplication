//
//  ViewController.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/4/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation
import UIKit
import WebKit


protocol UpdateCollection {
    func updateCollectionType()
}

class MainViewController: UIViewController, UpdateCollection {
    
    let padding: CGFloat = Constants.mainViewPadding
    
    var toAuthButton: UIButton!
    var searchButton: UIButton!
    var backgroundGradient: UIView!
    var tableView: UITableView!
    var paddingView: UIView!
    var contentTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLay = CAGradientLayer()
        gradientLay.frame = view.bounds
        gradientLay.colors = [Constants.lightGray, Constants.darkerGray]
        gradientLay.shouldRasterize = true
        gradientLay.zPosition = -100
        view.layer.addSublayer(gradientLay)
        
        toAuthButton = UIButton()
        toAuthButton.translatesAutoresizingMaskIntoConstraints = false
        toAuthButton.addTarget(self, action: #selector(changeAuthButtonAppearance), for: .touchDown)
        toAuthButton.addTarget(self, action: #selector(revertAuthButtonAppearance), for: .touchUpOutside)
        toAuthButton.addTarget(self, action: #selector(openAuthViewController), for: .touchUpInside)
        toAuthButton.backgroundColor = .white
        toAuthButton.setTitleColor(.black, for: .normal)
        toAuthButton.setTitle("Sign in", for: .normal)
        toAuthButton.titleLabel?.font = Constants.mtSerMed24
        toAuthButton.layer.shadowColor = UIColor.black.cgColor
        toAuthButton.layer.shadowOpacity = 1
        toAuthButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        toAuthButton.layer.shadowRadius = 2
        toAuthButton.layer.cornerRadius = Constants.buttonCornerRadius
        view.addSubview(toAuthButton)

        searchButton = UIButton()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(changeSearchButtonAppearance), for: .touchDown)
        searchButton.addTarget(self, action: #selector(revertAuthButtonAppearance), for: .touchUpOutside)
        searchButton.addTarget(self, action: #selector(openSearchViewController), for: .touchUpInside)
        searchButton.backgroundColor = Constants.spotifyGreen
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.setTitle("Search Songs", for: .normal)
        searchButton.titleLabel?.font = Constants.mtSerMed24
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOpacity = 1
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchButton.layer.shadowRadius = 2
        searchButton.layer.cornerRadius = Constants.buttonCornerRadius
        view.addSubview(searchButton)
        
        tableView = UITableView(frame: CGRect(), style: .grouped)
        tableView.backgroundColor = UIColor(cgColor: Constants.lightGray)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(PlaylistTableViewCell.self, forCellReuseIdentifier: PlaylistTableViewCell.reuseIdentifier)
        tableView.register(PlaylistTableHeaderView.self, forHeaderFooterViewReuseIdentifier: PlaylistTableHeaderView.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)

        self.title = "Spotify Popularity"
    
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            toAuthButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            toAuthButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            toAuthButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            toAuthButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: toAuthButton.bottomAnchor, constant: padding / 2.6),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        
    }
    
    @objc func changeAuthButtonAppearance() {
        toAuthButton.backgroundColor = UIColor(cgColor: Constants.darkerGray)
        toAuthButton.layer.shadowOpacity = 0
        toAuthButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        toAuthButton.layer.shadowRadius = 0
    }
    
    @objc func revertAuthButtonAppearance() {
        toAuthButton.backgroundColor = .white
        toAuthButton.layer.shadowOpacity = 1
        toAuthButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        toAuthButton.layer.shadowRadius = 2
    }
    
    @objc func openAuthViewController() {
        revertAuthButtonAppearance()
        let signInContoller = SignInViewController()
        signInContoller.delegate = self
        present(signInContoller, animated: true, completion: nil)
    }
    

    @objc func changeSearchButtonAppearance() {
        searchButton.backgroundColor = Constants.spotifyLightGreen
        searchButton.layer.shadowOpacity = 0
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchButton.layer.shadowRadius = 0
    }
    
    @objc func revertSearchButtonAppearance() {
        searchButton.backgroundColor = Constants.spotifyGreen
        searchButton.layer.shadowOpacity = 1
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchButton.layer.shadowRadius = 2
    }
    
    @objc func openSearchViewController() {
        revertSearchButtonAppearance()
        if UserInfo.name != "" && AuthenticationHandler.authToken != "" {
            let searchViewController = SearchViewController()
            self.navigationController?.pushViewController(searchViewController, animated: true)
        }
    }
    
    func updateCollectionType() {
        tableView.reloadData()
    }

}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfo.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playlist = UserInfo.playlists[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.reuseIdentifier, for: indexPath) as! PlaylistTableViewCell
        
        cell.selectionStyle = .none
        cell.setPlaylist(playlistName: playlist.name, playlist: playlist.tracks.items)
        cell.reloadData()
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: PlaylistTableHeaderView.reuseIdentifier) as! PlaylistTableHeaderView
        
        if UserInfo.name == "" {
            view.updateText(text: "You are currently not signed in. You must sign in to search for song popularity and view the popularity of songs on your playlists.")
        } else if UserInfo.playlists.count == 0 {
            view.updateText(text: "You seem to have no created playlists. To view the popularity of your favorite songs, add playlists under your spotify account.")
        } else {
            view.updateText(text: "The popularity ratings of your favorite songs are listed below.")
        }
        
        return view
    }
    
    
}


extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UserInfo.name == "" || UserInfo.playlists.count == 0 {
            return Constants.screenHeight * 0.5
        }
        
        return 140
    }
    
    
}








 
