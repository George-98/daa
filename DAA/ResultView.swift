import SwiftUI

struct ResultView: View {
    
    var totalScore: Int
    var correctAnswers: Int
    var wrongAnswers: Int
    
    var onExitToMenu: () -> Void
    var onPlayAgain: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            
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
            
            // Score Dashboard
            HStack(spacing: 0) {
                scoreBox(title: "No. of correct\nanswers", value: "\(correctAnswers)", color: .green)
                scoreBox(title: "No. of wrong\nanswers", value: "\(wrongAnswers)", color: .red)
                scoreBox(title: "Overall score", value: "\(totalScore)", color: .gray)
            }
            .frame(height: 120)
            .padding(.horizontal)
            
            // Wrong Answer Example
            VStack(alignment: .leading, spacing: 10) {
                Text("* Question 1")
                    .font(.headline)
                
                VStack {
                    Text("14 × 5")
                        .font(.title)
                    
                    Text("5")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke())
                }
                .frame(width: 120)
                .padding()
                .background(Color.themeBlue)
                .cornerRadius(10)
                
                Text("Correct answer: 70")
                    .foregroundColor(.green)
                
                Text("Your answer: 5")
                    .foregroundColor(.red)
            }
            .padding()
            
            Spacer()
        }
        .background(Color.themeBlue.ignoresSafeArea())
    }
    
    // Reusable score box
    func scoreBox(title: String, value: String, color: Color) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(5)
                .frame(maxWidth: .infinity)
                .background(color)
            
            Text(value)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.8))
        }
        .border(Color.white, width: 1)
    }
}
