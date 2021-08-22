//
//  ContentView.swift
//  Bullseye
//
//  Created by Dmitry on 19.08.2021.
//

import SwiftUI

struct ContentView: View {
    // Properties
    
    // User interface views
    @State private var alertIsVisible = false
    @State private var sliderValue = 50.0
    @State private var target = Int.random(in: 1...100)
    @State private var score = 0
    @State private var round = 1
    
    private let midnightBlue = Color(red: 0, green: 0.2, blue: 0.4)
    
    private var sliderRounded: Int {
        Int(sliderValue.rounded())
    }
    private var sliderTargetDifference: Int {
        abs(sliderRounded - target)
    }
    
    // User interface content and layout
    var body: some View {
        NavigationView {
            VStack {
                Spacer().navigationBarTitle("🎯 Bullseye 🎯")
                // Target row
                HStack {
                    Text("Put the bullseye as close as you can to:")
                        .modifier(LabelStyle())
                    Text("\(target)")
                        .modifier(ValueStyle())
                }
                
                Spacer()
                // Slider row
                HStack {
                    Text("1")
                        .modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor(.green)
                        .animation(.easeOut)
                    Text("100")
                        .modifier(LabelStyle())
                }
                
                Spacer()
                // Button row
                Button(action: {
                    self.alertIsVisible = true
                }) {
                    Text("Hit me!").modifier(ButtonLargeTextStyle())
                }
                .background(Image("Button")
                                .modifier(Shadow())
                )
                .alert(isPresented: self.$alertIsVisible) {
                    showAlert()
                }
                
                Spacer()
                // Score row
                HStack {
                    Button(action: {
                        startNewGame()
                    }) {
                        HStack {
                            Image("StartOverIcon")
                            Text("Start over").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button"))
                    .modifier(Shadow())
                    Spacer()
                    Text("Score:")
                        .modifier(LabelStyle())
                    Text("\(score)")
                        .modifier(ValueStyle())
                    Spacer()
                    Text("Round:")
                        .modifier(LabelStyle())
                    Text("\(round)")
                        .modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image("InfoIcon")
                            Text("Info").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button"))
                    .modifier(Shadow())
                }
                .padding(.bottom, 20)
                .accentColor(midnightBlue)
            }
            .onAppear() {
                startNewGame()
            }
            .background(Image("Background"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Methods
    private func showAlert() -> Alert {
        return Alert(title: Text(alertTitle()),
                     message: Text("The slider's value is \(sliderRounded).\n" +
                                    "The target value is \(target).\n" +
                                    "You scored \(pointsForCurrentRound()) points this round."),
                     dismissButton: .default(Text("Awesome!")) {
                        startNewRound()
                     })
    }
    
    private func alertTitle() -> String {
        let title: String
        if sliderTargetDifference == 0 {
            title = "Perfect!"
        } else if sliderTargetDifference < 5 {
          title = "You almost had it"
        } else if sliderTargetDifference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    private func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let points: Int
        
        if sliderTargetDifference == 0 {
            points = 200
        } else if sliderTargetDifference == 1 {
            points = 150
        } else {
            points = maximumScore - sliderTargetDifference
        }
        return points
    }
    
    private func startNewGame() {
        score = 0
        round = 1
        resetSliderAndTarget()
    }
    
    private func startNewRound() {
        score += pointsForCurrentRound()
        round += 1
        resetSliderAndTarget()
    }
    
    private func resetSliderAndTarget() {
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
}

struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(.black)
    }
}

struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(.black)
    }
}

struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 24))
            .foregroundColor(.yellow)
            .modifier(Shadow())
    }
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(.white)
            .modifier(Shadow())
    }
}

struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black, radius: 5, x: 2, y: 2)
    }
}

