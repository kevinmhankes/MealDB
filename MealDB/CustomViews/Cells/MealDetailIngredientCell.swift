//
//  MealDetailIngredientCell.swift
//  MealDB
//
//  Created by Kevin Hankes on 2/18/22.
//

import UIKit

class MealDetailIngredientCell: UITableViewCell {

    static let reuseID = "MealDetailIngredientCell"
    let ingredientLabel = DBBodyLabel(textAlignment: .left)
    let measurementLabel = DBBodyLabel(textAlignment: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(for ingredient: Ingredient) {
        ingredientLabel.text = ingredient.ingredient
        measurementLabel.text = ingredient.measurement
    }
    
    private func configure() {
        addSubviews(ingredientLabel, measurementLabel)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            ingredientLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ingredientLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            ingredientLabel.heightAnchor.constraint(equalToConstant: 22),
            ingredientLabel.widthAnchor.constraint(equalToConstant: 120),
            
            measurementLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            measurementLabel.leadingAnchor.constraint(equalTo: ingredientLabel.trailingAnchor, constant: padding * 2),
            measurementLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            measurementLabel.heightAnchor.constraint(equalToConstant: 22)
            
        ])
    }

}
