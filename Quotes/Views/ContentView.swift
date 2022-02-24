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
                                           quoteAuthor: "Michelangelo")
    
    @State var favourites: [Quote] = []

    @State var currentQuoteAddedToFavourites: Bool = false
    
    //MARK: Computed Properties
    
    var body: some View {
        VStack(spacing: 20) {
            
            VStack(spacing: 30) {
                Text(currentQuote.quoteText)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                HStack {
                    Spacer()
                    Text("- " + currentQuote.quoteAuthor)
                        .multilineTextAlignment(.trailing)
                        .font(.title3)
                }
            }
                .padding(25)
                .border(Color.black, width: 5)
            
            Image(systemName: "heart.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.gray)
            
            Button(action: {
                Task {
                   await loadNewQuotes()
                }
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favourites")
                    .bold()
                Spacer()
            }
            
            List {
                Text("Nothing is a waste of time if you use the experience wisely.")
                Text("If your actions inpire others to dream more, learn more, so more and become more, you are a leader.")
            }
            
            Spacer()
            
        }
        .task {
          await loadNewQuotes()
        }
        .navigationTitle("Quotes")
        .padding()
    }
    //MARK: Functions
    func loadNewQuotes() async {
        let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en")!
        var request = URLRequest(url: url)
      
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(for: request)
                        
            currentQuote = try JSONDecoder().decode(Quote.self, from: data)
            
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            print(error)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
