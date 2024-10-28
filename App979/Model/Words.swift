import Foundation

struct Words {
    let id: Int
    
    let easy: Array<String>
    let medium: Array<String>
    let hard: Array<String>
}

enum Complexity {
    case easy
    case medium
    case hard
}
