//
//  DBAvatarImageView.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import UIKit

class DBImageView: UIImageView {

    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeholderImage

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFit
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String) {
        Task { image = await NetworkManager.shared.downloadImage(fromURLString: url) ?? placeholderImage }
    }
}
