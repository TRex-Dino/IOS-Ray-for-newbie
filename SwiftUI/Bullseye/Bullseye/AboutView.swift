//
//  AboutView.swift
//  Bullseye
//
//  Created by Dmitry on 22.08.2021.
//

import SwiftUI

struct AboutView: View {
    private let beige = Color(red: 1, green: 0.84, blue: 0.7)
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯")
                    .modifier(AboutHeadingStyle())
                    .navigationBarTitle("About Bullseye")
                Text("""
                This is Bullseye, the game where you can win points and earn fame by dragging a slider.
                Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.
                Enjoy!
                """)
                    .modifier(AboutBodyStyle())
            }
            .background(beige)
        }
        .background(Image("Background"))
    }
}

struct AboutHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 30))
            .foregroundColor(.black)
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
}

struct AboutBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(.black)
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
    }
}
