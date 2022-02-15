//
//  DBMealDetailHeader.swift
//  MealDB
//
//  Created by Kevin Hankes on 2/15/22.
//

import UIKit

class DBMealDetailHeader: UIViewController {

    let mealImageView = DBImageView(frame: .zero)
    let mealTitle = DBTitleLabel(textAlignment: .center, fontSize: 34)
    let mealInstructions = DBBodyLabel(textAlignment: .left)
    
    var mealDetail: MealDetail!
    
    init(mealDetail: MealDetail) {
        super.init(nibName: nil, bundle: nil)
        self.mealDetail = mealDetail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(mealImageView, mealTitle, mealInstructions)
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        mealImageView.downloadImage(fromURL: mealDetail.strMealThumb)
        mealTitle.text = mealDetail.strMeal
        mealInstructions.text = mealDetail.strInstructions
        mealInstructions.numberOfLines = 0
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let imageHeightWidth: CGFloat = 150
        
        NSLayoutConstraint.activate([
            mealTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            mealTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mealTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mealTitle.heightAnchor.constraint(equalToConstant: 30),
            
            mealImageView.topAnchor.constraint(equalTo: mealTitle.bottomAnchor, constant: padding),
            mealImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mealImageView.heightAnchor.constraint(equalToConstant: imageHeightWidth),
            mealImageView.widthAnchor.constraint(equalToConstant: imageHeightWidth),
            
            mealInstructions.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: padding),
            mealInstructions.leadingAnchor.constraint(equalTo: mealTitle.leadingAnchor),
            mealInstructions.trailingAnchor.constraint(equalTo: mealTitle.trailingAnchor),
            mealInstructions.heightAnchor.constraint(equalToConstant: 500)
        ])
    }

}
