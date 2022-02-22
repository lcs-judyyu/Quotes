//
//  ContentView.swift
//  Quotes
//
//  Created by Judy Yu on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Lorem Ipsum")
                .multilineTextAlignment(.leading)
                .font(.title2)
                .padding(30)
                .border(Color.black, width: 5)
            
            Image(systemName: "heart.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.gray)
            
            Button(action: {
                
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favourites")
                Spacer()
            }
            
            List {
                Text("Nothing is a waste of time if you use the experience wisely.")
                Text("If your actions inpire others to dream more, learn more, so more and become more, you are a leader.")
            }
            
            Spacer()
            
        }
        .navigationTitle("Quotes")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
