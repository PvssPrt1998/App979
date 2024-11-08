import Foundation
import CoreData


extension TestWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestWord> {
        return NSFetchRequest<TestWord>(entityName: "TestWord")
    }

    @NSManaged public var word: String
}

extension TestWord : Identifiable {

}
