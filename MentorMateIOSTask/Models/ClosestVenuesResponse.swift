//
//  File.swift
//  MentorMateIOSTask
//
//  Created by Mac on 11/24/21.
//

import Foundation
struct ClosestVenuesResponse: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let fsqID: String?
    let categories: [Category]?
    let distance: Int?
    let geocodes: Geocodes?
    let location: Location?
    let name: String
    let relatedPlaces: RelatedPlaces?
    let timezone: String?

    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case categories, distance, geocodes, location, name
        case relatedPlaces = "related_places"
        case timezone
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
    let icon: Icon?
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String?
    let suffix: String?

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

// MARK: - Geocodes
struct Geocodes: Codable {
    let frontDoor: FrontDoor?
    let main: FrontDoor?

    enum CodingKeys: String, CodingKey {
        case frontDoor = "front_door"
        case main
    }
}

// MARK: - FrontDoor
struct FrontDoor: Codable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
    let address, country, crossStreet, dma: String?
    let locality: String?
    let neighborhood: [String]?
    let postcode, region: String?

    enum CodingKeys: String, CodingKey {
        case address, country
        case crossStreet = "cross_street"
        case dma, locality, neighborhood, postcode, region
    }
}

// MARK: - RelatedPlaces
struct RelatedPlaces: Codable {
    let parent: Parent?
}

// MARK: - Parent
struct Parent: Codable {
    let fsqID, name: String?

    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case name
    }
}
