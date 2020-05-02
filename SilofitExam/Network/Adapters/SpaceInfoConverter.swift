//
//  SpaceInfoConverter.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

protocol SpaceInfoConverter {
    func convert(spaceNM: SpaceNetworkResponse) -> [SpaceInfo]
}

final class SpaceInfoConverterImp: SpaceInfoConverter {
    func convert(spaceNM: SpaceNetworkResponse) -> [SpaceInfo] {
        spaceNM.spaces.map(createInfo)
    }
    
    private func createInfo(networkModel: SpaceNetworkModel) -> SpaceInfo {
        let addressInfo = getAddressInfo(networkModel)
        let status = SpaceStatus(string: networkModel.status)
        let mediaInfo = SpaceMedia(imageURLs: networkModel.image_urls)
        let features = getFeaturesInfo(networkModel)
        return .init(id: networkModel.space_id,
                     name: networkModel.name,
                     description: networkModel.description,
                     addressInfo: addressInfo,
                     mediaInfo: mediaInfo,
                     features: features,
                     status: status,
                     timeZone: networkModel.timezone)
    }
    
    private func getAddressInfo(_ networkModel: SpaceNetworkModel) -> SpaceAddress {
        let location = SpaceLocation(latitude: networkModel.latitude,
                                     longitude: networkModel.longitude)
        return .init(address: networkModel.address,
                     city: networkModel.city,
                     location: location)
    }
 
    private func getFeaturesInfo(_ networkModel: SpaceNetworkModel) -> SpaceFeature {
        .init(floor: networkModel.floor,
              maxCapacity: networkModel.max_capacity,
              amenities: networkModel.amenities,
              equipments: networkModel.equipments,
              openDays: networkModel.open_days,
              openHours: networkModel.open_hours,
              rate: networkModel.rate,
              slug: networkModel.slug)
    }
}
