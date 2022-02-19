//
//  DBEmptyStateView.swift
//  MealDB
//
//  Created by Kevin Hankes on 2/18/22.
//

import UIKit

class DBEmptyStateView: UIView {

    let messageLabel = DBTitleLabel(textAlignment: .center, fontSize: 28)
    let placeholderImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(messageLabel: String) {
        self.init(frame: .zero)
        self.messageLabel.text = messageLabel
    }
    
    private func configure() {
        addSubviews(messageLabel, placeholderImageView)
        configureMessageLabel()
        configurePlaceholderImageView()
    }
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ?  -80 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configurePlaceholderImageView() {
        placeholderImageView.image = Images.placeholderImage
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let placeholderImageBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        
        NSLayoutConstraint.activate([
            placeholderImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            placeholderImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            placeholderImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            placeholderImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: placeholderImageBottomConstant)
        ])
    }

}
