import Foundation

struct MenuItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let games: [GameItem]
}

struct GameItem {
    let id: String
    let title: String
    let show_leaderboard_breakdown: Bool
    let show_leaderboard_screenshot: Bool
    let game_time_limit: Int?
    let total_score_id: String
    let correct_answers_id: String
    let wrong_answers_id: String
    let gameInstructions: [String]
}
