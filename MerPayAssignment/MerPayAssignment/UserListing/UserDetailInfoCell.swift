//
//  UserDetailInfo.swift
//  ChatBot
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class UserDetailInfoCell: UITableViewCell {

    //MARK:- IBOutlet
    @IBOutlet weak var profilePicView: UIView?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var centerUserNameContraint: NSLayoutConstraint?
    @IBOutlet weak var topUserNameContraint: NSLayoutConstraint!
    
    //MARK:- Public
    var model : UserInfoCellViewModel? = nil {
        didSet {
            userNameLabel?.text = "@" + (model?.userName ?? "")
            var url : URL?
            if let link = model?.userProfilePicLink {
                url = URL(string: link)
            }
            profilePicView?.setImage(with: url, and: model?.userName ?? "")
            setDetails(text: model?.lastChat ?? "")
        }
    }
    
    //MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicView?.layer.masksToBounds = true
        profilePicView?.layer.cornerRadius = (profilePicView?.bounds.width ?? 0) / 2
        initialiseCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        detailLabel?.text = nil
        userNameLabel?.text = nil
        profilePicView?.removeAllSubviews()
        initialiseCell()
    }
    
    //MARK:- Private methods
    private func initialiseCell() {
        detailLabel?.isHidden = true
        setLabelToTop(false)
        profilePicView?.removeAllSubviews()
    }
    
    private func setDetails(text: String) {
        detailLabel?.text = text.isEmpty ? nil : text
        detailLabel?.isHidden = text.isEmpty
        setLabelToTop(!text.isEmpty)
    }
    
    private func setLabelToTop(_ bool: Bool) {
        topUserNameContraint?.isActive = bool
        centerUserNameContraint?.isActive = !bool
    }
}
