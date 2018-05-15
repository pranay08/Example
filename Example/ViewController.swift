//
//  ViewController.swift
//  Example
//
//  Created by Pranay Kothlapuram on 5/15/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class Action: NSObject {
    var icon: String?
    var type: String?
    var title: String?
    
    required init(withIcon icon: String?, type: String?, title: String?) {
        super.init()
        self.icon = icon
        self.type = type
        self.title = title
    }
    
    override var description: String {
        return "icon: \(String(describing: self.icon)), type: \(String(describing: self.type)), title: \(String(describing: self.title))"
    }
}

class ActionCell: UIView, UIGestureRecognizerDelegate {
    
    var icon: UIImageView?
    var actionType: UILabel?
    var actionTitle: UILabel?
    
    var a:Action?
    var tap:UITapGestureRecognizer?
    
    required override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.addGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addGesture()
    }
    
    private func addGesture() -> Void {
        if let gestures = self.gestureRecognizers {
            for gesture in gestures {
                self.removeGestureRecognizer(gesture)
            }
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.touchTapped(_:)))
        addGestureRecognizer(gesture)
        self.tap = gesture
    }
    
    @objc func touchTapped(_ sender: UITapGestureRecognizer) {
        print("Action cell tapped!")
        guard let action = self.a else {
            return
        }
        print(action)
    }
    
    override func layoutSubviews() {
        if (icon == nil) {
            let rect = CGRect(origin: CGPoint(x: 10,y :20), size: CGSize(width: 64, height: 64))
            let imageView = UIImageView(frame: rect)
            addSubview(imageView)
            if let name = a?.icon {
                imageView.image = UIImage(named: name)
            }
            self.icon = imageView
        }
        if (actionType == nil) {
            let rect = CGRect(origin: CGPoint(x: 100,y :20), size: CGSize(width: 200, height: 16))
            let label = UILabel(frame: rect)
            label.text = a?.type
            addSubview(label)
            self.actionType = label
        }
        if (actionTitle == nil) {
            let rect = CGRect(origin: CGPoint(x: 100,y :80), size: CGSize(width: 200, height: 16))
            let label = UILabel(frame: rect)
            label.text = a?.title
            addSubview(label)
            self.actionTitle = label
        }
    }
    
    func configure( a:Action ) {
        self.a = a
    }
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var factorCopy: UITextView?
    @IBOutlet private weak var measurementLabel: UILabel?
    @IBOutlet private weak var impactLabel: UILabel?
    @IBOutlet private weak var graphView: UIView?
    @IBOutlet private weak var updatedDateLabel: UILabel?
    @IBOutlet private weak var measurementRangeLabel: UILabel?
    @IBOutlet private weak var goalTitle: UILabel?
    @IBOutlet private weak var goalCopy: UITextView?
    @IBOutlet private weak var goalName: UILabel?
    @IBOutlet private weak var goalBenefit: UILabel?
    @IBOutlet private weak var recommendedActions: UILabel?
    @IBOutlet private weak var actionsStackView: UIStackView?
    @IBOutlet private weak var actionsStackViewHeight: NSLayoutConstraint?
    private var actions: [Action] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let stackView = self.actionsStackView else {
            return
        }
        
        var action = Action.init(withIcon: "camera", type: "Type1", title: "Camera")
        self.actions.append(action)
        action = Action.init(withIcon: "facebook", type: "Type2", title: "Facebook")
        self.actions.append(action)
        action = Action.init(withIcon: "twitter", type: "Type3", title: "Twitter")
        self.actions.append(action)
        action = Action.init(withIcon: "settings", type: "Type4", title: "Settings")
        self.actions.append(action)
        
        let height: CGFloat = 100.0
        var frame = stackView.bounds
        frame.size.height = height
        for action in self.actions {
            let actionCell = ActionCell.init(frame: frame)
            actionCell.configure(a: action)
            stackView.addArrangedSubview(actionCell)
        }
        self.actionsStackViewHeight?.constant = CGFloat(self.actions.count) * height
    }

}

