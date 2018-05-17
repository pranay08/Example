//
//  ViewController.swift
//  Example
//
//  Created by Pranay Kothlapuram on 5/15/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ActionViewDelegate, ResearchViewDelegate {
    
    @IBOutlet private weak var measurementLabel: UILabel?
    @IBOutlet private weak var unitsLabel: UILabel?
    @IBOutlet private weak var updatedDateLabel: UILabel?
    @IBOutlet private weak var impactLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var moreDetailsButton: UIButton?
    @IBOutlet private weak var goalTitle: UILabel?
    @IBOutlet private weak var goalTarget: UILabel?
    @IBOutlet private weak var goalName: UILabel?
    @IBOutlet private weak var goalBenefit: UILabel?
    @IBOutlet private weak var goalBenefitScore: UILabel?
    @IBOutlet private weak var goalDescription: UILabel?
    @IBOutlet private weak var actionsStackView: UIStackView?
    @IBOutlet private weak var actionsStackViewHeight: NSLayoutConstraint?
    @IBOutlet private weak var showAllActionsButton: UIButton?
    @IBOutlet private weak var relatedResearchStackView: UIStackView?
    @IBOutlet private weak var relatedResearchStackViewHeight: NSLayoutConstraint?
    @IBOutlet private weak var showAllResearchButton: UIButton?
    private let medicalCondition: MedicalCondition = MedicalCondition.highCholesterol()
    private let goal: Goal = Goal.reduceCholesterolGoal()
    private var actions: [Action] = []
    private var researchArticles: [ResearchArticle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.actions.append(Action.newDoctorAction())
        self.actions.append(Action.newTestAction())
        self.actions.append(Action.exampleAction())
        self.actions.append(Action.exampleAction())
        self.actions.append(Action.exampleAction())
        
        self.researchArticles.append(ResearchArticle.newHarvardResearchArticle())
        self.researchArticles.append(ResearchArticle.exampleResearchArticle())
        self.researchArticles.append(ResearchArticle.exampleResearchArticle())
        self.researchArticles.append(ResearchArticle.exampleResearchArticle())
        
        self.configureViewWithData()
    }
    
    private func configureViewWithData() -> Void {
        var components: [String] = []
        if let level = self.medicalCondition.level {
            components.append(level)
        }
        if let score = self.medicalCondition.score {
            components.append(score)
        }
        self.measurementLabel?.text = components.joined(separator: " ")
        if let date = self.medicalCondition.lastUpdatedDate {
            let formatter = DateFormatter.init()
            formatter.dateFormat = "M/d/yy"
            self.updatedDateLabel?.text = formatter.string(from: date)
        }
        self.unitsLabel?.text = self.medicalCondition.measurementUnits
        self.impactLabel?.text = self.medicalCondition.impact
        self.descriptionLabel?.text = self.medicalCondition.description
        //self.moreDetailsButton?.isHidden
        var height: CGFloat = 0.0
        for (index, action) in self.actions.enumerated() {
            if (index == 2) {
                break
            }
            if let actionView = ActionView.loadNib(withOwner: self, options: nil) {
                actionView.configure(withAction: action, delegate: self)
                self.actionsStackView?.addArrangedSubview(actionView)
                height += actionView.frame.height
            }
        }
        self.actionsStackViewHeight?.constant = height
        self.showAllActionsButton?.isHidden = (self.actions.count <= 2)
        
        height = 0.0
        for (index, researchArticle) in self.researchArticles.enumerated() {
            if (index == 1) {
                break
            }
            if let researchView = ResearchView.loadNib(withOwner: self, options: nil) {
                researchView.configure(withResearchArticle: researchArticle, delegate: self)
                self.relatedResearchStackView?.addArrangedSubview(researchView)
                height += researchView.frame.height
            }
        }
        self.relatedResearchStackViewHeight?.constant = height
        self.showAllResearchButton?.isHidden = (self.researchArticles.count <= 1)
    }
    
    @IBAction private func show(moreDetails sender: UIButton?) -> Void {
        UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.descriptionLabel?.numberOfLines = 0
            self?.descriptionLabel?.lineBreakMode = .byWordWrapping
            self?.view.layoutIfNeeded()
        }) { (finished) in
            sender?.isHidden = true
        }
    }
    
    @IBAction private func show(allActions sender: UIButton?) -> Void {
        if (self.actionsStackView?.arrangedSubviews.count == self.actions.count) {
            return
        }
        if var height: CGFloat = self.actionsStackViewHeight?.constant {
            for (index, action) in self.actions.enumerated() {
                if (index < 2) {
                    continue
                }
                if let actionView = ActionView.loadNib(withOwner: self, options: nil) {
                    actionView.alpha = 0.0
                    actionView.configure(withAction: action, delegate: self)
                    self.actionsStackView?.addArrangedSubview(actionView)
                    height += actionView.frame.height
                }
            }
            self.actionsStackViewHeight?.constant = height
            UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
                self?.actionsStackView?.arrangedSubviews.forEach({ (subView) in
                    subView.alpha = 1.0
                })
                self?.view.layoutIfNeeded()
            }) { (finished) in
                sender?.isHidden = true
            }
        }
    }
    
    @IBAction private func show(allResearch sender: UIButton?) -> Void {
        if (self.relatedResearchStackView?.arrangedSubviews.count == self.researchArticles.count) {
            return
        }
        if var height = self.relatedResearchStackViewHeight?.constant {
            for (index, researchArticle) in self.researchArticles.enumerated() {
                if (index < 1) {
                    continue
                }
                if let researchView = ResearchView.loadNib(withOwner: self, options: nil) {
                    researchView.alpha = 0.0
                    researchView.configure(withResearchArticle: researchArticle, delegate: self)
                    self.relatedResearchStackView?.addArrangedSubview(researchView)
                    height += researchView.frame.height
                }
            }
            self.relatedResearchStackViewHeight?.constant = height
            UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
                self?.relatedResearchStackView?.arrangedSubviews.forEach({ (subView) in
                    subView.alpha = 1.0
                })
                self?.view.layoutIfNeeded()
            }) { (finished) in
                sender?.isHidden = true
            }
        }
    }
    
    // MARK: - ActionViewDelegate
    
    func actionViewTapped(_ view: ActionView?, action: Action?) -> Void {
        // do your thing
    }
    
    // MARK: - ResearchViewDelegate
    
    func researchViewTapped(_ view: ResearchView?, researchArticle: ResearchArticle?) -> Void {
        // do your thing
    }

}

