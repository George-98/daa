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
    let highscore: Bool
    let show_global_leaderboard: Bool
    let show_leaderboard_breakdown: Bool
    let show_leaderboard_screenshot: Bool
    let show_answers_dash: Bool
    let game_time_limit: Int?
    let score_type: String?
    let high_score_data_name: String?
    let previous_score_data_name: String?
    let storyboard_id: String
    let leaderboard_id: String?
    let total_score_id: String
    let correct_answers_id: String
    let wrong_answers_id: String
    let gameInstructions: [String]
}
