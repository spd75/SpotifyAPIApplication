//
//  SearchViewController.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/13/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    let padding: CGFloat = 30
    let reuseIdentifier = "searchCellReuse"
    
    var tableView: UITableView!
    var searchBar: UITextField!
    var trackInfo: [Track]! = []
    
    override func viewDidLoad() {
        searchBar = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.text = "Search Song Popularity"
        searchBar.layer.cornerRadius = 25
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.black.cgColor
        searchBar.layer.shadowRadius = 2
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchBar.font = Constants.getTextFont()
        searchBar.backgroundColor = .white
        searchBar.textColor = .black
        searchBar.textAlignment = .natural
        searchBar.clearsOnBeginEditing = true
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        
        searchBar.layer.shadowRadius = 5
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        searchBar.leftView = paddingView
        searchBar.leftViewMode = .always
        
        view.addSubview(searchBar)
        
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(cgColor: Constants.lightGray)
        
        tableView.register(SearchTableCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        view.backgroundColor = UIColor(cgColor: Constants.lightGray2)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: padding),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NetworkHandler.searchSpotify(searchString: textField.text ?? "") { tracks in
            self.trackInfo = []
            self.trackInfo = tracks
            self.tableView.reloadData()
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
}



extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchTableCell
        let searchTrackResult = self.trackInfo[indexPath.row]
        
        cell.selectionStyle = .none
        cell.getValues(track: searchTrackResult)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trackInfo.count
    }
}



extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.searchTableHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

