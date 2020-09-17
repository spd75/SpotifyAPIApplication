//
//  PlaylistCollectionView.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/14/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    let padding: CGFloat = 14
    
    var nameLabel: UILabel!
    var artistsLabel: UILabel!
    var popLabel: UILabel!
    var trackImage: UIImageView!
    var emtpyViewHolder: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackImage = UIImageView()
        trackImage.translatesAutoresizingMaskIntoConstraints = false
        trackImage.layer.shadowOpacity = 1
        trackImage.contentMode = .scaleAspectFit
        trackImage.layer.shadowOffset = CGSize(width: 0, height: 1)
        trackImage.layer.shadowRadius = 2
        contentView.addSubview(trackImage)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Constants.mtSerBold10
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        contentView.addSubview(nameLabel)
        
        artistsLabel = UILabel()
        artistsLabel.translatesAutoresizingMaskIntoConstraints = false
        artistsLabel.font = Constants.mtSerReg10
        artistsLabel.textColor = .white
        contentView.addSubview(artistsLabel)
        
        popLabel = UILabel()
        popLabel.translatesAutoresizingMaskIntoConstraints = false
        popLabel.font = Constants.mtSerBold10
        popLabel.textColor = .white
        popLabel.numberOfLines = 3
        contentView.addSubview(popLabel)
        
        contentView.backgroundColor = UIColor(cgColor: Constants.lightGray)
        
        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            trackImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trackImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20),
            trackImage.widthAnchor.constraint(equalToConstant: Constants.screenWidth * 0.3 + 40),
            trackImage.heightAnchor.constraint(equalToConstant: Constants.screenWidth * 0.3 + 40)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: trackImage.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: trackImage.leadingAnchor, constant: 1),
            nameLabel.trailingAnchor.constraint(equalTo: trackImage.trailingAnchor, constant: -1)
        ])

        NSLayoutConstraint.activate([
            artistsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding / 4),
            artistsLabel.leadingAnchor.constraint(equalTo: trackImage.leadingAnchor, constant: 1),
            artistsLabel.trailingAnchor.constraint(equalTo: trackImage.trailingAnchor, constant: -1)
        ])
        
        NSLayoutConstraint.activate([
            popLabel.topAnchor.constraint(equalTo: artistsLabel.bottomAnchor, constant: padding / 4),
            popLabel.leadingAnchor.constraint(equalTo: trackImage.leadingAnchor, constant: 1),
            popLabel.trailingAnchor.constraint(equalTo: trackImage.trailingAnchor, constant: -1)
        ])
        

        
    }
    
    func getValues(track: Track) {
        nameLabel.text = track.name
        NetworkHandler.fetchImage(imageURL: track.album.images[1].url, completion: { image in
            self.trackImage.image = image
        })
        artistsLabel.text = genArtistString(track: track)
        popLabel.text = "Popularity: \(track.getPopularity())"
    }
    
    
    private func genArtistString(track: Track) -> String {
        var finalString = ""
        for i in 0..<track.artists.count {
            finalString += track.artists[i].name
            if i < track.artists.count - 1{
                finalString += ", "
            }
        }
        return finalString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

