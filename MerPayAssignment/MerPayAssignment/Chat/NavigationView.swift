//
//  NavigationView.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    var profilePicView: UIView?
    var titleLabel: UILabel?
    var subTitleLabel: UILabel?
    
    let widthHeight = 48
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        profilePicView = UIView(frame: .zero)
        titleLabel = UILabel(frame: .zero)
        subTitleLabel = UILabel(frame: .zero)
        
        self.addSubview(profilePicView!)
        self.addSubview(titleLabel!)
        self.addSubview(subTitleLabel!)
        
        addContraints()
        
        profilePicView?.layer.masksToBounds = true
        profilePicView?.layer.cornerRadius = CGFloat(widthHeight / 2)
    }
    
    var user: User? {
        didSet {
            titleLabel?.text = "@" + (user?.login ?? "")
            if let url = user?.avatarUrl, let initials = user?.login?.prefix(2) {
                profilePicView?.setImage(with: url, or: String(initials))
            }
        }
    }
    
    func setName(name: String) {
        subTitleLabel?.text = name
    }
    
    private func addContraints() {
        profilePicView?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict : [String : UIView] = ["pic" : profilePicView!,
                                            "title" : titleLabel!,
                                            "subTitle" : subTitleLabel!]
        var constraints : [NSLayoutConstraint]
        var vfl = "H:|-[pic(\(widthHeight))]-[title]-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: .alignAllTop, metrics:  nil, views: viewDict)
        self.addConstraints(constraints)
        
        vfl = "H:|-[pic]-[subTitle]-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: .alignAllBottom, metrics:  nil, views: viewDict)
        self.addConstraints(constraints)
        
        vfl = "V:|-[pic(\(widthHeight))]-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: .alignAllLeading, metrics:  nil, views: viewDict)
        self.addConstraints(constraints)
        
        vfl = "V:|-[title]-[subTitle]-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: .alignAllLeading, metrics:  nil, views: viewDict)
        self.addConstraints(constraints)
    }
    
}
