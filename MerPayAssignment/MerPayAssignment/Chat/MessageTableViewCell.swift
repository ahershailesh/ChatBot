//
//  MessageTableVIewCellTableViewCell.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

enum MessageAlignment {
    case left
    case right
}

class MessageTableViewCell: UITableViewCell {

    var messageLabel : UILabel?
    var messageView : UIView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var alignment : MessageAlignment = .right {
        didSet {
            removeConstraints(constraints)
            addConstraints()
            comstomizeView(for: alignment)
        }
    }
    
    private func setupView() {
        messageLabel = UILabel(frame: .zero)
        messageView = UIView(frame: .zero)
        
        messageView?.addSubview(messageLabel!)
        contentView.addSubview(messageView!)
        
        messageLabel?.text = "You use this method to add cap insets to an image or to change the existing cap insets of an image. In both cases, you get back a new image and the original image remains untouched. For example, you can use this method to create a background image for a button with borders and corners: when the button is resized"
        messageLabel?.numberOfLines = 0
        messageLabel?.backgroundColor = .clear
        addConstraints()
    }
    
    private func addConstraints() {
        guard let messageView = messageView, let label = messageLabel else {
            return
        }
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        var vfl : String
        
        switch alignment {
            case .left  :   vfl = "H:|-[view(200)]"
            case .right :   vfl = "H:[view(200)]-|"
        }
        
        //label contraints
        var contraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: messageView, attribute: .top, multiplier: 1, constant: 8)
        messageView.addConstraint(contraint)
        
        contraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: messageView, attribute: .leading, multiplier: 1, constant: 8)
        messageView.addConstraint(contraint)
        
        contraint = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: messageView, attribute: .trailing, multiplier: 1, constant: 8)
        messageView.addConstraint(contraint)
        
        contraint = NSLayoutConstraint(item: messageView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 8)
        messageView.addConstraint(contraint)
        
        //MessageView constraints
        contraint = NSLayoutConstraint(item: messageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8)
        contentView.addConstraint(contraint)
        
        let attribute : NSLayoutAttribute = alignment == .left ? .leading : .trailing
        
        contraint = NSLayoutConstraint(item: messageView, attribute: attribute, relatedBy: .equal, toItem: contentView, attribute: attribute, multiplier: 1, constant: 8)
        contentView.addConstraint(contraint)
        
        contraint = NSLayoutConstraint(item: messageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        contentView.addConstraint(contraint)
        
        contraint = NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: messageView, attribute: .bottom, multiplier: 1, constant: 8)
        contentView.addConstraint(contraint)
    }
    
    private func comstomizeView(for alignment: MessageAlignment) {
        switch alignment {
        case .left: cumstomizeViewForLeftAlignment()
        case .right: cumstomizeViewForRightAlignment()
        }
    }
    
    private func cumstomizeViewForLeftAlignment() {
        messageView?.backgroundColor = ColorHex.snuff.getColor()
        messageLabel?.backgroundColor = ColorHex.black.getColor()
    }
    
    private func cumstomizeViewForRightAlignment() {
        messageView?.backgroundColor = ColorHex.jaksonsPurple.getColor()
        messageLabel?.backgroundColor = ColorHex.white.getColor()
    }
}
