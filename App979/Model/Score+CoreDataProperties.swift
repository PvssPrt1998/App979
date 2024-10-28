import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var title: String
    @NSManaged public var totalScore: Int32

}

extension Score : Identifiable {

}
