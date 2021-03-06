//
//  SearchCategoryVC.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/29/22.
//

import UIKit

class CategoryVC: DBDataLoadingVC {
    enum Section { case main }
    
    var mealCategory: String!
    var mealCategories: [MealCategory] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, MealCategory>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemGreen
        configureCollectionView()
        getMealCategories()
        configureDataSource()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MealCategoryCell.self, forCellWithReuseIdentifier: MealCategoryCell.reuseID)
    }
    
    func getMealCategories() {
        showLoadingView()
        
        Task {
            do {
                let mealCategories = try await NetworkManager.shared.getCategories()
                updateUI(with: mealCategories)
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
    
    func updateUI(with mealCategories: [MealCategory]) {
        self.mealCategories.append(contentsOf: mealCategories)
        
        self.updateData(on: self.mealCategories)
    }
    
    func updateData(on mealCategories: [MealCategory]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MealCategory>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mealCategories)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MealCategory>(collectionView: collectionView, cellProvider: { collectionView, indexPath, mealCategory in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCategoryCell.reuseID, for: indexPath) as! MealCategoryCell
            cell.set(mealCategory: mealCategory)
            return cell
        })
    }
}

extension CategoryVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mealCategory = mealCategories[indexPath.item]
        
        let destVC = MealVC(category: mealCategory.strCategory)
        navigationController?.pushViewController(destVC, animated: true)
    }
}
