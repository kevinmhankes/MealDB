//
//  MealCategoryCell.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import UIKit

class MealCategoryCell: UICollectionViewCell {
    static let reuseID = "MealCategoryCell"
    
    let mealCategoryImageView = DBAvatarImageView(frame: .zero)
    let categoryLabel = DBTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(mealCategory: MealCategory) {
        mealCategoryImageView.downloadImage(fromURL: mealCategory.strCategoryThumb)
        categoryLabel.text = mealCategory.strCategory
    }
    
    private func configure() {
        addSubview(mealCategoryImageView)
        addSubview(categoryLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            mealCategoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mealCategoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mealCategoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mealCategoryImageView.heightAnchor.constraint(equalTo: mealCategoryImageView.widthAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: mealCategoryImageView.bottomAnchor, constant: 12),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
