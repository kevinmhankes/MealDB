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
    
    let mealDetailHeader = UIView()
    
    var mealName: String!
    var mealID: String!
    
    var mealDetail: MealDetail!
    
    init(mealID: String, mealName: String) {
        super.init(nibName: nil, bundle: nil)
        self.mealID = mealID
        title = mealName
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
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
    func getRecipe(mealID: String) {
        showLoadingView()
        
        Task {
            do {
                let mealDetail = try await NetworkManager.shared.getMealDetail(for: mealID)
                configureUIElements(with: mealDetail)
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
    
    func configureUIElements(with mealDetail: MealDetail) {
        self.add(childVC: DBMealDetailHeader(mealDetail: mealDetail), to: self.mealDetailHeader)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        contentView.addSubview(mealDetailHeader)
        
        mealDetailHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mealDetailHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            mealDetailHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            mealDetailHeader.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            mealDetailHeader.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.frame
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}
