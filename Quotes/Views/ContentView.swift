//
//  ContentView.swift
//  Quotes
//
//  Created by Judy Yu on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Stored Properties
    @Environment(\.scenePhase) var scenePhase
    
    @State var currentQuote: Quote = Quote(quoteText: "The greatest danger for most of us is not that our aim is too high and we miss it, but that it is too low and we reach it.",
                                           quoteAuthor: "Michelangelo")
    
    @State var favourites: [Quote] = []
    
    @State var currentQuoteAddedToFavourites: Bool = false
    
    @State var repeatedFavourite: Bool = false
    
    //MARK: Computed Properties
    
    var body: some View {
        VStack(spacing: 20) {
            
            VStack(spacing: 30) {
                Text(currentQuote.quoteText)
                    .minimumScaleFactor(0.5)
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
                .foregroundColor(currentQuoteAddedToFavourites == true ? .red : .secondary)
                .onTapGesture {
                    if currentQuoteAddedToFavourites == false {
                        if favourites.contains(currentQuote) {
                            repeatedFavourite = true
                            currentQuoteAddedToFavourites = false
                        } else {
                            favourites.append(currentQuote)
                            currentQuoteAddedToFavourites = true
                        }
                        
                    } else {
                        favourites.removeLast()
                        currentQuoteAddedToFavourites = false
                    }
                }
            
            Text("You have added this quote to favourites.")
                .font(.body)
                .opacity(repeatedFavourite ? 1.0 : 0.0)
            
            Button(action: {
                Task {
                    await loadNewQuotes()
                }
                currentQuoteAddedToFavourites = false
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favourites")
                    .bold()
                Spacer()
            }
            
            List (favourites, id: \.self){ currentFavourite in
                Text(currentFavourite.quoteText)
            }
            
            Spacer()
            
        }
        .task {
            await loadNewQuotes()
            
            loadFavourites()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active{
                print("Active")
            } else {
                print("Background")
                
                //permanently save the favourite list
                persistFavourites()
            }
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
    
    func persistFavourites() {
        //get a location to save data
        let filename = getDocumentsDirectory().appendingPathComponent(savedFavouritesLabel)
        print(filename)
        
        //try to encodr data to JSON
        do {
            let encoder = JSONEncoder()
            
            //configure the encoder to "pretty print" the JSON
            encoder.outputFormatting = .prettyPrinted
            
            //Encode the list of favourites
            let data = try encoder.encode(favourites)
            
            //write JSON to a file in the filename location
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            //see the data
            print("Save data to the document directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
            print("Unable to write list of favourites to the document directory")
            print("=========")
            print(error.localizedDescription)
        }
    }
    
    func loadFavourites() {
        let filename = getDocumentsDirectory().appendingPathComponent(savedFavouritesLabel)
        print(filename)
        
        do {
            //load raw data
            let data = try Data(contentsOf: filename)
            
            print("Save data to the document directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
            //decode JSON into Swift native data structures
            //NOTE: [] are used since we load into an array
            favourites = try JSONDecoder().decode([Quote].self, from: data)
            
        } catch {
            print("Could not loas the data from the stored JSON file")
            print("=========")
            print(error.localizedDescription)
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
