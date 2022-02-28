//
//  SharedFunctionsAndConstants.swift
//  Quotes
//
//  Created by Judy Yu on 2022-02-27.
//

import Foundation

func getDocumentsDirectory() -> URL{
    let paths = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
    
    //return the first path
    return paths[0]
}

let savedFavouritesLabel = "savedFavourites"
