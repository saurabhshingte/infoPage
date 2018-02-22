
import Foundation

struct MilSection
{
    var mainSkill: String!
    var skillData: [String]!
    var expanded: Bool!
    
    init(mainSkill: String, skillData: [String], expanded: Bool)
    {
        self.mainSkill = mainSkill
        self.skillData = skillData
        self.expanded = expanded
    }
    
}
