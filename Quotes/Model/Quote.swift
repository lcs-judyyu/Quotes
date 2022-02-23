//
//  Quote.swift
//  Quotes
//
//  Created by Judy Yu on 2022-02-22.
//

import Foundation

struct Quote: Decodable {
    let quoteText: String
    let quoteAuthor: String
    let senderName: String
    let senderLink: String
    let quoteLink: String
}
