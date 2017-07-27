//
//  Location.swift
//  rainyshinycloudy
//
//  Created by sade on 27/7/17.
//  Copyright © 2017 sade. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitute: Double!
    var longitude: Double!
}
