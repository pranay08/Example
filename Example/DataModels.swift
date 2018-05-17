//
//  DataModels.swift
//  Example
//
//  Created by Pranay Kothlapuram on 5/16/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

extension Date {
    public static func date(fromISOString isoString: String?) -> Date? {
        if let string = isoString {
            let dateFormatter = DateFormatter.init()
            let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
            dateFormatter.locale = enUSPosixLocale
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            
            let date = dateFormatter.date(from: string)
            return date
        }
        return nil
    }
}

class MedicalCondition {
    private(set) var level: String?
    private(set) var score: String?
    private(set) var measurementUnits: String?
    private(set) var impact: String?
    private(set) var description: String?
    private(set) var lastUpdatedDate: Date?
    
    init(withDictionary dictionary:[String: Any]?) {
        self.level = dictionary?["level"] as? String
        self.score = dictionary?["score"] as? String
        self.measurementUnits = dictionary?["measurementUnits"] as? String
        self.impact = dictionary?["impact"] as? String
        self.description = dictionary?["description"] as? String
        self.lastUpdatedDate = Date.date(fromISOString: dictionary?["lastUpdated"] as? String)
    }
    
    public class func highCholesterol() -> MedicalCondition {
        let cholesterol = ["level": "High",
                           "score" : "170",
                           "measurementUnits": "mg/dL",
                           "impact": "Big Impact",
                           "description" : "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\n\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.",
                           "lastUpdated": "2018-05-16T23:39:49-07:00"]
        return MedicalCondition.init(withDictionary: cholesterol)
    }
}

class Goal {
    private(set) var goalTitle: String?
    private(set) var goalTarget: String?
    private(set) var benefit: String?
    private(set) var score: String?
    private(set) var description: String?
    
    init(withDictionary dictionary:[String: Any]?) {
        self.goalTitle = dictionary?["goalTitle"] as? String
        self.goalTarget = dictionary?["goalTarget"] as? String
        self.benefit = dictionary?["benefit"] as? String
        self.score = dictionary?["score"] as? String
        self.description = dictionary?["description"] as? String
    }
    
    public class func reduceCholesterolGoal() -> Goal {
        let reduceCholesterol = ["goalTitle": "Cholesterol Goal",
                                 "goalTarget" : "Reduce to 60 mg/dL",
                                 "benefit": "Big Benefit",
                                 "score": "+58 Points",
                                 "description" : "Lowering your LDL Cholesterol to 50 would significantly reduce your cardiovascular risk."]
        return Goal.init(withDictionary: reduceCholesterol)
    }
}

class Action {
    private(set) var icon: String?
    private(set) var title: String?
    private(set) var description: String?
    
    required init(withDictionary dictionary: [String: Any]?) {
        self.icon = dictionary?["icon"] as? String
        self.title = dictionary?["title"] as? String
        self.description = dictionary?["description"] as? String
    }
    
    public class func newDoctorAction() -> Action {
        let doctor = ["icon": "stethoscope",
                      "title": "Doctor",
                      "description": "Talk with your Doctor about Statins"]
        return Action.init(withDictionary: doctor)
    }
    
    public class func newTestAction() -> Action {
        let test = ["icon": "test_tube",
                    "title": "Test",
                    "description": "Get Cholesterol Test Updated"]
        return Action.init(withDictionary: test)
    }
    
    public class func exampleAction() -> Action {
        let example = ["icon": "settings",
                       "title": "Example",
                       "description": "Some example action"]
        return Action.init(withDictionary: example)
    }
}

class ResearchArticle {
    private(set) var publisher: String?
    private(set) var title: String?
    private(set) var description: String?
    private(set) var iconURL: String?
    private(set) var lastUpdatedDate: Date?
    
    init(withDictionary dictionary:[String: Any]?) {
        self.publisher = dictionary?["publisher"] as? String
        self.title = dictionary?["title"] as? String
        self.description = dictionary?["description"] as? String
        self.iconURL = dictionary?["iconURL"] as? String
        self.lastUpdatedDate = Date.date(fromISOString: dictionary?["lastUpdated"] as? String)
    }
    
    public class func newHarvardResearchArticle() -> ResearchArticle {
        let harvardResearch = ["publisher": "Harvard Health",
                               "title" : "Rethinking Good Cholesterol",
                               "description": "A high HDL cholesterol level may not be as beneficial as once believed",
                               "lastUpdated": "2018-05-16T23:39:49-07:00"]
        return ResearchArticle.init(withDictionary: harvardResearch)
    }
    
    public class func exampleResearchArticle() -> ResearchArticle {
        let example = ["publisher": "Some Publisher",
                       "title" : "Lorem Ipsum",
                       "description": "dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                       "lastUpdated": "2018-05-16T23:39:49-07:00"]
        return ResearchArticle.init(withDictionary: example)
    }
}
