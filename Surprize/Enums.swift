//
//  Enums.swift
//  Surprize
//
//  Created by Keegan Campbell on 4/28/17.
//  Copyright © 2017 Keegan Campbell. All rights reserved.
//

import Foundation

enum ImageCategories {
    case nature
    case water
    case mountains
    case space
    case jungle
    case forest
}

func getStringImageCategory(category: ImageCategories) -> String {
    switch category {
    case .nature:
        return "nature"
    case .water:
        return "water"
    case .mountains:
        return "mountains"
    case .space:
        return "space"
    case .jungle:
        return "jungle"
    case .forest:
        return "forest"
    }
}
