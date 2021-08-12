//
//  ContentView.swift
//  Guess the flag
//
//  Created by Aleksey Fedorov on 11.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        print("You are tapped in the button: \(self.countries[number])")
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color .black, lineWidth: 1))
                            .shadow(color: .black, radius: 10)
            }
        }
                Text("Your score is: \(score) points")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding(2)
                                    .font(.title)
                Spacer()
        }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message:
                    Text("Your score is: \(score)"), dismissButton:
                        .default(Text("Continue")) {
                  self.askQuestion()
        })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            print("Correct")
        } else {
            scoreTitle = "Wrong the flag: \(countries[correctAnswer])"
            print("Wrong")
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
