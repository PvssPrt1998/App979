import Foundation

final class MainViewModel: ObservableObject {
    
    let dc: DContr
    
    @Published var categories: Array<Category>
    
    init(dc: DContr) {
        self.dc = dc
        categories = dc.categories
    }
    
    func selectCategory(_ category: Category) {
        if category.title == "All categories" {
            if isAllSelected == true {
                for index in 0..<categories.count {
                    categories[index].selected = false
                }
            } else {
                for index in 0..<categories.count {
                    categories[index].selected = true
                }
            }
        } else {
            guard let index = categories.firstIndex(where: {$0.title == category.title}) else { return }
            categories[index].selected.toggle()
            if isAllSelected == false {
                guard let index1 = categories.firstIndex(where: {$0.title == "All categories"}) else { return }
                categories[index1].selected = false
            }
        }
    }
    
    private var isAllSelected: Bool {
        var bool = true
        categories.forEach { category in
            if category.selected == false {
                bool = false
                return
            }
        }
        return bool
    }
    var isAnySelected: Bool {
        var bool = false
        categories.forEach { category in
            if category.selected == true {
                bool = true
                return
            }
        }
        return bool
    }
    
    func playButtonPressed() {
        dc.categories = categories
    }
    
    func cardAmountForCategory(_ category: Category) -> Int {
        var amount = 0
        
        if category.title == "All categories" {
            categories.forEach { cat in
                amount += dc.words[cat.wordsId].easy.count
                amount += dc.words[cat.wordsId].medium.count
                amount += dc.words[cat.wordsId].hard.count
            }
        } else {
            amount += dc.words[category.wordsId].easy.count
            amount += dc.words[category.wordsId].medium.count
            amount += dc.words[category.wordsId].hard.count
        }
        
        return amount
    }
}
