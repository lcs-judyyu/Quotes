//
//  ContentView.swift
//  Quotes
//
//  Created by Judy Yu on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Stored Properties
    @State var currentQuote: Quote = Quote(quoteText: "The greatest danger for most of us is not that our aim is too high and we miss it, but that it is too low and we reach it.",
                                           quoteAuthor: "Michelangelo",
                                           senderName: "",
                                           senderLink: "",
                                           quoteLink: "http://forismatic.com/en/1f8428d277/")

    //MARK: Computed Properties
    
    var body: some View {
        VStack(spacing: 20) {
            
            VStack {
                Text(currentQuote.quoteText)
                    .multilineTextAlignment(.leading)
                    .font(.title2)
                HStack {
                    Spacer()
                    Text(currentQuote.quoteAuthor)
                        .multilineTextAlignment(.trailing)
                        .font(.title3)
                }
            }
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
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
