import SwiftUI;

class StandardGameViewModel: ObservableObject {
    @Published var gameItem: GameItem?
    @Published var wrongAnswersArray: [WrongAnswer] = [];
}
