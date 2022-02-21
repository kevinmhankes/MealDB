//
//  MealDetailVC.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import UIKit

class MealDetailVC: DBDataLoadingVC {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let mealImageView = DBImageView(frame: .zero)
    let mealTitle = DBTitleLabel(textAlignment: .center, fontSize: 28)
    let mealInstructionLabel = DBSecondaryTitleLabel(fontSize: 22)
    let mealInstructions = DBBodyLabel(textAlignment: .left)
    let mealIngredientsLabel = DBSecondaryTitleLabel(fontSize: 22)
    let mealIngredients = DBBodyLabel(textAlignment: .left)
        
    var mealID: String!
        
    init(mealID: String) {
        super.init(nibName: nil, bundle: nil)
        self.mealID = mealID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getRecipe(mealID: mealID)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.leftBarButtonItem = doneButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1000)
        ])
    }
    
    func getRecipe(mealID: String) {
        showLoadingView()
        
        Task {
            do {
                let mealDetail = try await NetworkManager.shared.getMealDetail(for: mealID)
                updateUI(with: mealDetail)
                print(mealDetail)
                dismissLoadingView()
            } catch {
                if let dbError = error as? DBError {
                    presentDBAlert(title: "Something went wrong", message: dbError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                
                dismissLoadingView()
            }
        }
    }
    
    func layoutUI() {
        contentView.addSubviews(mealImageView, mealTitle, mealInstructionLabel, mealInstructions, mealIngredientsLabel, mealIngredients)

        let padding: CGFloat = 20
        let imageHeightWidth: CGFloat = 300

        NSLayoutConstraint.activate([
            mealTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            mealTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            mealTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            mealImageView.topAnchor.constraint(equalTo: mealTitle.bottomAnchor, constant: padding),
            mealImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mealImageView.heightAnchor.constraint(equalToConstant: imageHeightWidth),
            mealImageView.widthAnchor.constraint(equalToConstant: imageHeightWidth),

            mealInstructionLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: padding),
            mealInstructionLabel.leadingAnchor.constraint(equalTo: mealTitle.leadingAnchor),
            mealInstructionLabel.trailingAnchor.constraint(equalTo: mealTitle.trailingAnchor),
            mealInstructionLabel.heightAnchor.constraint(equalToConstant: 24),

            mealInstructions.topAnchor.constraint(equalTo: mealInstructionLabel.bottomAnchor, constant: padding),
            mealInstructions.leadingAnchor.constraint(equalTo: mealTitle.leadingAnchor),
            mealInstructions.trailingAnchor.constraint(equalTo: mealTitle.trailingAnchor),
            
            mealIngredientsLabel.topAnchor.constraint(equalTo: mealInstructions.bottomAnchor, constant: padding),
            mealIngredientsLabel.leadingAnchor.constraint(equalTo: mealTitle.leadingAnchor),
            mealIngredientsLabel.trailingAnchor.constraint(equalTo: mealTitle.trailingAnchor),
            mealIngredientsLabel.heightAnchor.constraint(equalToConstant: 24),
            
            mealIngredients.topAnchor.constraint(equalTo: mealIngredientsLabel.bottomAnchor, constant: padding),
            mealIngredients.leadingAnchor.constraint(equalTo: mealTitle.leadingAnchor),
            mealIngredients.trailingAnchor.constraint(equalTo: mealTitle.trailingAnchor),
            mealIngredients.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func updateUI(with mealDetail: MealDetail) {
        mealImageView.downloadImage(fromURL: mealDetail.strMealThumb)

        mealTitle.text = mealDetail.strMeal
        mealTitle.numberOfLines = 0

        mealInstructionLabel.text = "Instructions:"

        mealInstructions.text = mealDetail.strInstructions
        mealInstructions.numberOfLines = 0
        
        mealIngredientsLabel.text = "Ingredients:"
        
        mealIngredients.text = mealDetail.mealIngredientsToString()
        mealIngredients.numberOfLines = 0
        
        scrollView.layoutIfNeeded()
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let mealDetail = try await NetworkManager.shared.getMealDetail(for: mealID)
                addMealToFavorites(mealDetail: mealDetail)
                dismissLoadingView()
            } catch {
                if let dbError = error as? DBError {
                    presentDBAlert(title: "Something went wrong", message: dbError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                
                dismissLoadingView()
            }
        }
    }
    
    func addMealToFavorites(mealDetail: MealDetail) {
        let meal = Meal(strMeal: mealDetail.strMeal, strMealThumb: mealDetail.strMealThumb, idMeal: mealDetail.idMeal)
        
        PersistenceManager.updateWith(meal: meal, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                DispatchQueue.main.async {
                    self.presentDBAlert(title: "Success", message: "You have successfully favorited this meal! 🎉", buttonTitle: "Awesome!")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.presentDBAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}
