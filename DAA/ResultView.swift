import SwiftUI

struct ResultView: View {
    
    var totalScore: Int
    var correctAnswers: Int
    var wrongAnswers: Int
    
    var wrongAnswersArray: [WrongAnswer]
    var onExitToMenu: () -> Void;
    var onPlayAgain: () -> Void;
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button(action: {
                    onExitToMenu()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)
            
            Spacer()
            
            // Title
            Text("Time is up!")
                .font(.system(size: 40, weight: .medium))
                .foregroundColor(.white)
                .padding(.top, 30)
            
            Text("Your score is: \(totalScore)")
                .font(.title2)
                .foregroundColor(.white.opacity(0.9))
            
            // Play Again Button
            Button(action: {
                onPlayAgain()
            }) {
                Text("Play again!")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(30)
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 30)
            
            // Score Dashboard
            HStack(spacing: 0) {
                scoreBox(title: "No. of correct\nanswers", value: "\(correctAnswers)", color: .green)
                scoreBox(title: "No. of wrong\nanswers", value: "\(wrongAnswers)", color: .red)
                scoreBox(title: "Overall score", value: "\(totalScore)", color: .gray)
            }
            .frame(height: 120)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(wrongAnswersArray) { item in
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("* Question \(item.questionNumber)")
                                .font(.headline)
                            
                            // Screenshot-style box
                            VStack {
                                Text(item.question)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                                Text(item.yourAnswer.replacingOccurrences(of: "Your answer: ", with: ""))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white)
                                    )
                            }
                            .frame(width: 140)
                            .padding()
                            .background(Color.themeBlue)
                            .cornerRadius(10)
                            
                            Text(item.correctAnswer)
                                .foregroundColor(.green)
                            
                            Text(item.yourAnswer)
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading) // 👈 IMPORTANT
                        .padding(.vertical)
                        .padding(.leading, 16)
                        
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .ignoresSafeArea(edges: .bottom)
        }
        .frame(maxWidth: .infinity)
        .background(Color.themeBlue.ignoresSafeArea())
    }
    
    // Reusable score box
    func scoreBox(title: String, value: String, color: Color) -> some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.caption)
                .frame(height: 50)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(color)
            
            Text(value)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .background(Color.white.opacity(0.8))
        }
        .border(Color.white, width: 1)
    }
}
