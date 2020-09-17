//
//  PlaylistTableHeader.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/15/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import UIKit


class PlaylistTableHeaderView: UITableViewHeaderFooterView {
    
    public static let reuseIdentifier = "playlistTableHeaderReuse"
    let padding: CGFloat = Constants.screenWidth * 0.024
    
    var paddingView: UIView!
    var contentTitle: UILabel!
    var explanationText: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        paddingView = UIView()
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        paddingView.backgroundColor = UIColor(cgColor: Constants.lightGray)
        paddingView.layer.zPosition = -5
        contentView.addSubview(paddingView)
        
        contentTitle = UILabel()
        contentTitle.translatesAutoresizingMaskIntoConstraints = false
        contentTitle.font = Constants.mtSerMed32
        contentTitle.textColor = .white
        contentTitle.text = "Your Playlists"
        contentTitle.layer.zPosition = 1
        contentTitle.backgroundColor = .clear
        contentView.addSubview(contentTitle)
        
        explanationText = UILabel()
        explanationText.translatesAutoresizingMaskIntoConstraints = false
        explanationText.font = Constants.getTextFont()
        explanationText.textColor = .white
        explanationText.layer.zPosition = 1
        explanationText.numberOfLines = 0
        explanationText.backgroundColor = .clear
        explanationText.textAlignment = .center
        contentView.addSubview(explanationText)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            paddingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            paddingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            paddingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            paddingView.heightAnchor.constraint(equalToConstant: Constants.screenHeight * 0.03 + 35)
        ])
        
        NSLayoutConstraint.activate([
            contentTitle.topAnchor.constraint(equalTo: paddingView.topAnchor, constant: 16),
            contentTitle.centerXAnchor.constraint(equalTo: paddingView.centerXAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            explanationText.topAnchor.constraint(equalTo: contentTitle.bottomAnchor, constant: 8),
            explanationText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
            explanationText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding * 2)
        ])

    }
    
    func updateText(text: String) {
        explanationText.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
