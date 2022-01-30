//
//  MealCell.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import UIKit

class MealCell: UITableViewCell {
    
    static let reuseID = "MealCell"

    let mealImageView = DBImageView(frame: .zero)
    let mealLabel = DBTitleLabel(textAlignment: .left, fontSize: 16)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(meal: Meal) {
        mealImageView.downloadImage(fromURL: meal.strMealThumb)
        mealLabel.text = meal.strMeal
    }
    
    private func configure() {
        addSubviews(mealImageView, mealLabel)
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            mealImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mealImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            mealImageView.heightAnchor.constraint(equalToConstant: 60),
            mealImageView.widthAnchor.constraint(equalToConstant: 60),
            
            mealLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mealLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 24),
            mealLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            mealLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
