//
//  PlaylistHeaderView.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/15/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import UIKit


class PlaylistHeaderView: UICollectionReusableView {
    
    var label: UILabel!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.mtSerMed24
        label.textColor = .white
        
        addSubview(label)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.screenWidth * 0.05),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])
    }
    
    func setText(playlistName: String) {
        label.text = playlistName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
