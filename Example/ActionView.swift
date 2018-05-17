//
//  ActionView.swift
//  Example
//
//  Created by Pranay Kothlapuram on 5/16/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

protocol ActionViewDelegate: NSObjectProtocol {
    func actionViewTapped(_ view: ActionView?, action: Action?) -> Void
}

class ActionView: UIView {
    
    @IBOutlet private weak var iconImageView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    private(set) weak var action: Action?
    weak var delegate: ActionViewDelegate?
    
    public class func loadNib(withOwner owner: Any?, options: [AnyHashable: Any]?) -> ActionView? {
        return Bundle.main.loadNibNamed("ActionView", owner: owner, options: nil)?.first as? ActionView
    }
    
    public func configure(withAction action: Action?, delegate: ActionViewDelegate?) -> Void {
        self.action = action
        self.layer.borderColor = UIColor.black.cgColor
        if let icon = action?.icon {
            self.iconImageView?.image = UIImage.init(named: icon)
        }
        self.titleLabel?.text = action?.title
        self.descriptionLabel?.text = action?.description
        
        if (delegate != nil) {
            self.delegate = delegate
            self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.handleTapGesture(_:))))
        }
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer?) -> Void {
        self.delegate?.actionViewTapped(self, action: self.action)
    }
}
