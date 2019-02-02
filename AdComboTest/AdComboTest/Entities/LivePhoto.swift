//
//  LivePhoto.swift
//  AdComboTest
//
//  Created by Роман Тищенко on 01/02/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

class LivePhoto: Decodable {
    
    init(smallUrl: String, largeUrl: String, movieUrl: String) {
        self.smallUrl = smallUrl
        self.largeUrl = largeUrl
        self.movieUrl = movieUrl
    }
    
    var smallUrl: String
    var largeUrl: String
    var movieUrl: String
}
