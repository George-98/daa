import Foundation

struct MenuItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let games: [GameItem]
}

struct GameItem {
    let id: GameType
    let title: String
    let show_leaderboard_breakdown: Bool
    let show_leaderboard_screenshot: Bool
    let game_time_limit: Int?
    let total_score_id: String
    let correct_answers_id: String
    let wrong_answers_id: String
    let gameInstructions: [String]
}

struct GameResult: Equatable {
    let score: Int
    let correct: Int
    let wrong: Int
}

struct WrongAnswer: Identifiable {
    let id = UUID()
    let questionNumber: Int
    let question: String
    let correctAnswer: String
    let yourAnswer: String
}

enum GameType {
    case numeracy1
    case verbalReasoning1
}

struct VRQuestion {
    let statement: String   // Add this line
    let question: String
    let options: [String]
    let correctAnswer: String
}

struct House {
    let name: String
    let location: String
    let distanceToWork: String
    let bedrooms: Int
    let hasGarden: Bool
    let distanceToShops: String
}
