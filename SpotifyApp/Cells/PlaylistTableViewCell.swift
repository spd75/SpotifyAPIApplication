//
//  PlaylistTableViewCell.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/15/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import UIKit


class PlaylistTableViewCell: UITableViewCell {
    
    var playlistName: String = ""
    var playlist: [TrackInfo]! = []
    public static let reuseIdentifier = "playlistCellReuse"
    public static let reuseHeaderIdentifier = "playlistHeaderReuse"
    
    
    var collectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionHeadersPinToVisibleBounds = true
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = UIColor(cgColor: Constants.lightGray)
        collectionView.register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: PlaylistTableViewCell.reuseIdentifier)
        collectionView.register(PlaylistHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistTableViewCell.reuseHeaderIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.playlistTableHeight)
        ])
    }
    
    func setPlaylist(playlistName: String, playlist: [TrackInfo]) {
        self.playlistName = playlistName
        self.playlist = playlist
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}



extension PlaylistTableViewCell: UICollectionViewDelegate {
    
}



extension PlaylistTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.playlist.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistTableViewCell.reuseIdentifier, for: indexPath) as! PlaylistCollectionViewCell
        
        cell.getValues(track: self.playlist[indexPath.item].track)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistTableViewCell.reuseHeaderIdentifier, for: indexPath) as! PlaylistHeaderView
        header.setText(playlistName: self.playlistName)
        
        return header
    }
    
}


extension PlaylistTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionViewLayout.invalidateLayout()
        return CGSize(width: Constants.size, height: Constants.playlistTableHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 5, height: 10)
    }

}
