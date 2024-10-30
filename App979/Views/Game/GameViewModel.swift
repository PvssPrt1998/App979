import Foundation

final class GameViewModel: ObservableObject {
    
    let dc: DContr
    let action: () -> Void
    
    var words: Array<Word> = []
    var showedSuperword: Bool = false
    var lastWasSuperword: Bool = false
    var superwordValue: Int = Int.random(in: 1...5)
    @Published var superwordCounter: Int = 0
    
    var buttonsDisabled: Bool = false
    
    @Published var currentWord = Word(categoryTitle: "Error", word: "Invalid word")
    @Published var nextWord: Word?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let totalTime: Int
    @Published var remainingTime: Int
    
    init(dc: DContr, action: @escaping () -> Void) {
        self.dc = dc
        totalTime = dc.roundTime
        remainingTime = dc.roundTime
        self.action = action
        words = dc.gameWords
        if words.isEmpty {
            setupWords()
        } else {
            currentWord = words.removeFirst()
            if !words.isEmpty {
                nextWord = words.removeFirst()
            }
        }
    }
    
    func previewTest() {
        words.append(Word(categoryTitle: "Category1", word: "Word1"))
        words.append(Word(categoryTitle: "Category2", word: "Word2"))
        words.append(Word(categoryTitle: "Category3", word: "Word3"))
        words.append(Word(categoryTitle: "Category4", word: "Word4"))
        words.append(Word(categoryTitle: "Category5", word: "Word5"))
        currentWord = words.removeFirst()
        nextWord = words.removeFirst()
    }
    
    func strokeTimer() {
        if remainingTime >= 1 {
            remainingTime -= 1
        } else {
            if !dc.lastWordForEveryone {
                prepareWordsForNextRound()
                action()
            }
        }
    }
    
    func prepareWordsForNextRound() {
        if let nextWord = nextWord {
            words.insert(nextWord, at: 0)
        }
        dc.gameWords = words
    }
    
    func setupWords() {
        dc.categories.forEach { category in
            if category.selected {
                switch dc.complexity {
                case .easy:
                    dc.words[category.wordsId].easy.forEach { word in
                        words.append(Word(categoryTitle: category.title, word: word))
                    }
                case .medium:
                    dc.words[category.wordsId].medium.forEach { word in
                        words.append(Word(categoryTitle: category.title, word: word))
                    }
                case .hard:
                    dc.words[category.wordsId].hard.forEach { word in
                        words.append(Word(categoryTitle: category.title, word: word))
                    }
                }
            }
        }
        words.shuffle()
        currentWord = words.removeFirst()
        if words.count >= 1 {
            nextWord = words.removeFirst()
        } else { nextWord = nil }
        
    }
    
    func rightAnswer() {
        dc.setAnswerSound(true)
        if dc.superWord {
            superwordCounter += 1
        }
        if lastWasSuperword {
            dc.currentPlayer?.score += 5
            lastWasSuperword = false
        } else {
            dc.currentPlayer?.score += 1
        }
        dc.answeredWords.append((currentWord, true))
        if words.count >= 1 {
            if dc.lastWordForEveryone && remainingTime == 0 {
                prepareWordsForNextRound()
                action()
            } else {
                toNextCard()
            }
        } else {
            if nextWord != nil {
                currentWord = nextWord!
                nextWord = nil
            } else {
                prepareWordsForNextRound()
                action()
            }
        }
    }
    func skip() {
        dc.setAnswerSound(false)
        if dc.superWord {
            superwordCounter += 1
        }
        if dc.takeAwayPoints {
            dc.currentPlayer?.score -= 1
        }
        dc.answeredWords.append((currentWord, false))
        if words.count >= 1 {
            if dc.lastWordForEveryone && remainingTime == 0 {
                prepareWordsForNextRound()
                action()
            } else {
                toNextCard()
            }
        } else {
            if nextWord != nil {
                currentWord = nextWord!
                nextWord = nil
            } else {
                prepareWordsForNextRound()
                action()
            }
        }
    }
    func toNextCard() {
        if let nextWord = nextWord {
            currentWord = nextWord
        }
        nextWord = words.removeFirst()
    }
    
    func backPrepare() {
        dc.answeredWords = []
        dc.gameWords = []
        dc.commands = []
        dc.complexity = .medium
        dc.roundTime = 30
        dc.takeAwayPoints = false
        dc.currentPlayer = nil
        
        for index in 0..<dc.categories.count {
            dc.categories[index].selected = false
        }
    }
}
