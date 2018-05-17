//
//  ResearchView.swift
//  Example
//
//  Created by Pranay Kothlapuram on 5/16/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

protocol ResearchViewDelegate: NSObjectProtocol {
    func researchViewTapped(_ view: ResearchView?, researchArticle: ResearchArticle?) -> Void
}

class ResearchView: UIView {
    
    @IBOutlet private weak var iconImageView: UIImageView?
    @IBOutlet private weak var publisherLabel: UILabel?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var lastUpdatedLabel: UILabel?
    weak var delegate: ResearchViewDelegate?
    private(set) weak var researchArticle: ResearchArticle?
    
    public class func loadNib(withOwner owner: Any?, options: [AnyHashable: Any]?) -> ResearchView? {
        return Bundle.main.loadNibNamed("ResearchView", owner: owner, options: nil)?.first as? ResearchView
    }
    
    public func configure(withResearchArticle researchArticle: ResearchArticle?, delegate: ResearchViewDelegate?) -> Void {
        self.researchArticle = researchArticle
        self.layer.borderColor = UIColor.black.cgColor
        // if let icon = researchArticle?.iconURL {
            // download your image here and set it.
        // }
        self.publisherLabel?.text = researchArticle?.publisher
        self.titleLabel?.text = researchArticle?.title
        self.descriptionLabel?.text = researchArticle?.description
        if let date = researchArticle?.lastUpdatedDate {
            let formatter = DateFormatter.init()
            formatter.dateFormat = "M/d/yy"
            self.lastUpdatedLabel?.text = formatter.string(from: date)
        }
        
        if (delegate != nil) {
            self.delegate = delegate
            
            self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.handleTapGesture(_:))))
        }
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer?) -> Void {
        self.delegate?.researchViewTapped(self, researchArticle: self.researchArticle)
    }
}
