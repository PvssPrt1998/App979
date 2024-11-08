import Foundation
import CoreData


extension CategoryAnimate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryAnimate> {
        return NSFetchRequest<CategoryAnimate>(entityName: "CategoryAnimate")
    }

    @NSManaged public var animate: Bool

}

extension CategoryAnimate : Identifiable {

}
