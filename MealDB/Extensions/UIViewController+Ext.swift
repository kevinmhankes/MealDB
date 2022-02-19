//
//  UIViewController+Ext.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentDBAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = DBAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = DBAlertVC(alertTitle: "Something went wrong",
                              message: "Unable to complete your task at this time. Please try again.",
                              buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = DBEmptyStateView(messageLabel: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
