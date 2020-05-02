//
//  SpaceNetworkModel.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

struct SpaceNetworkResponse {
    let spaces: [SpaceNetworkModel]
}

struct SpaceNetworkModel: DictionaryMappable {
    let address: String
    let city: String
    let description: String
    let floor: String
    let image_urls: [String]
    let amenities: [String]
    let equipments: [String]
    let latitude: Double
    let longitude: Double
    let max_capacity: Int
    let name: String
    let open_days: String
    let open_hours: String
    let rate: Double
    let slug: String
    let space_id: String
    let square_footage: Double
    let status: String
    let timezone: String
    
    init(dict: [String : Any]) {
        address = dict.value(for: "address", defaultValue: "")
        city = dict.value(for: "city", defaultValue: "")
        description = dict.value(for: "description", defaultValue: "")
        floor = dict.value(for: "floor", defaultValue: "")
        image_urls = dict.value(for: "image_urls", defaultValue: [])
        amenities = dict.value(for: "amenities", defaultValue: [])
        equipments = dict.value(for: "equipments", defaultValue: [])
        latitude = dict.value(for: "latitude", defaultValue: 0.0)
        longitude = dict.value(for: "longitude", defaultValue: 0.0)
        max_capacity = dict.value(for: "max_capacity", defaultValue: -1)
        name = dict.value(for: "name", defaultValue: "")
        open_days = dict.value(for: "open_days", defaultValue: "")
        open_hours = dict.value(for: "open_hours", defaultValue: "")
        rate = dict.value(for: "rate", defaultValue: 0.0)
        slug = dict.value(for: "slug", defaultValue: "")
        space_id = dict.value(for: "space_id", defaultValue: "")
        square_footage = dict.value(for: "square_footage", defaultValue: 0.0)
        status = dict.value(for: "status", defaultValue: "")
        timezone = dict.value(for: "timezone", defaultValue: "")
    }
}
