//
//  NavigationView.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

/// Shows the navigation icon and the details.
class NavigationView: UIView {
    
    //MARK:- Vars
    //MARK: Private
    private var profilePicView: UIView?
    private var titleLabel: UILabel?
    private var subTitleLabel: UILabel?
    private let widthHeight = 34
    
    //MARK: Public
    var model : HeaderViewModel? {
        didSet {
            titleLabel?.text = "@" + (model?.titleText ?? "")
            var url : URL?
            if let string = model?.profilePicLink {
                url = URL(string: string)
            }
            profilePicView?.setImage(with: url, and: model?.titleText ?? "")
            subTitleLabel?.text = model?.subTitleText
        }
    }
    
    //MARK: Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK:- Public
    func setSubtitle(text: String) {
        subTitleLabel?.text = text
    }
    
    //MARK: Private methods
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
        
        setupLabels()
    }
    
    private func setupLabels() {
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        subTitleLabel?.font = UIFont.systemFont(ofSize: 12)
        subTitleLabel?.textColor = UIColor.gray
    }
    
    private func addContraints() {
        profilePicView?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict : [String : UIView] = ["pic" : profilePicView!,
                                            "title" : titleLabel!,
                                            "subTitle" : subTitleLabel!]
        var constraints : [NSLayoutConstraint]
        var vfl = "H:|-0-[pic(\(widthHeight))]-[title]-0-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: .alignAllTop, metrics:  nil, views: viewDict)
        self.addConstraints(constraints)
        
        vfl = "H:|-0-[pic]-[subTitle]-0-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: .alignAllBottom, metrics:  nil, views: viewDict)
        self.addConstraints(constraints)
        
        vfl = "V:|-0-[pic(\(widthHeight))]-0-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: .alignAllLeading, metrics:  nil, views: viewDict)
        self.addConstraints(constraints)
        
        vfl = "V:|-0-[title]-4-[subTitle]-0-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: .alignAllLeading, metrics:  nil, views: viewDict)
        self.addConstraints(constraints)
        
        layoutIfNeeded()
    }
    
}
