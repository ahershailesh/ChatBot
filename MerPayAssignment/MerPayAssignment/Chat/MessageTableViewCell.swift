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

    //MARK:- Private Variables
    private var messageLabel : UILabel?
    private var messageView : UIView?
    
    private var leftContraint : NSLayoutConstraint?
    private var rightContraint : NSLayoutConstraint?
    
    private let CHAT_BUBBLE_WIDTH = UIScreen.main.bounds.width * 0.8
    
    private var messageType : MessageType = .sent {
        didSet {
            comstomizeView(for: messageType)
        }
    }
    
    //MARK:- Public Variables
    var messageViewModel : MessageViewModel? {
        didSet {
            guard let model = messageViewModel else {  return  }
            messageLabel?.text = model.text
            messageType = model.type
        }
    }
    
    //MARK:- Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel?.text = nil
    }
    
    
    //MARK:- Private methods - setup
    private func setupView() {
        messageLabel = UILabel(frame: .zero)
        messageView = UIView(frame: .zero)
        
        messageView?.addSubview(messageLabel!)
        contentView.addSubview(messageView!)
        
        messageView?.clipsToBounds = true
        messageView?.layer.cornerRadius = 8
        
        messageLabel?.numberOfLines = 0
        messageLabel?.backgroundColor = .clear
        
        selectionStyle = .none
        
        addConstraints()
    }
    
    
    private func addConstraints() {
        guard let messageView = messageView, let label = messageLabel else {
            return
        }
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //MessageView constraints
        var contraint = NSLayoutConstraint(item: messageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8)
        contentView.addConstraint(contraint)
        
        leftContraint = NSLayoutConstraint(item: messageView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 8)
        contentView.addConstraint(leftContraint!)
        
        rightContraint = NSLayoutConstraint(item: messageView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -8)
        
        contraint = NSLayoutConstraint(item: messageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CHAT_BUBBLE_WIDTH)
        contentView.addConstraint(contraint)
        
        contraint = NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: messageView, attribute: .bottom, multiplier: 1, constant: 8)
        contentView.addConstraint(contraint)
        
        
        //label contraints
        contraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: messageView, attribute: .top, multiplier: 1, constant: 8)
        messageView.addConstraint(contraint)
        
        contraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: messageView, attribute: .leading, multiplier: 1, constant: 8)
        messageView.addConstraint(contraint)
        
        contraint = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: messageView, attribute: .trailing, multiplier: 1, constant: -8)
        messageView.addConstraint(contraint)
        
        contraint = NSLayoutConstraint(item: messageView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 8)
        messageView.addConstraint(contraint)
    }
    
    private func comstomizeView(for type: MessageType) {
        switch type {
        case .recieved: cumstomizeViewForLeftAlignment()
        case .sent: cumstomizeViewForRightAlignment()
        }
    }
    
    private func cumstomizeViewForLeftAlignment() {
        rightContraint?.isActive = false
        leftContraint?.isActive = true
        messageView?.backgroundColor = ColorHex.aliceBlue.getColor()
        messageLabel?.textColor = ColorHex.black.getColor()
    }
    
    private func cumstomizeViewForRightAlignment() {
        leftContraint?.isActive = false
        rightContraint?.isActive = true
        messageView?.backgroundColor = ColorHex.ebonyBlue.getColor()
        messageLabel?.textColor = ColorHex.white.getColor()
    }
}
