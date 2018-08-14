//
//  UserDetailInfo.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class UserDetailInfoCell: UITableViewCell {

    @IBOutlet weak var profilePicView: UIView?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var centerUserNameContraint: NSLayoutConstraint?
    @IBOutlet weak var topUserNameContraint: NSLayoutConstraint!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicView?.layer.masksToBounds = true
        profilePicView?.layer.cornerRadius = (profilePicView?.bounds.width ?? 0) / 2
        initialiseCell()
    }
    
    func initialiseCell() {
        detailLabel?.isHidden = true
        setLabelToTop(false)
        profilePicView?.removeAllSubviews()
    }
    
    func setDetails(text: String) {
        detailLabel?.text = text.isEmpty ? nil : text
        detailLabel?.isHidden = text.isEmpty
        setLabelToTop(!text.isEmpty)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        detailLabel?.text = nil
        userNameLabel?.text = nil
        profilePicView?.removeAllSubviews()
        initialiseCell()
    }
    
    private func setLabelToTop(_ bool: Bool) {
        topUserNameContraint?.isActive = bool
        centerUserNameContraint?.isActive = !bool
    }
}
