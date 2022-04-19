//
//  restaurant.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/03/31.
//

import Foundation
import MapKit

struct RestaurantResponseDTO: Decodable {
    let info: Info

    enum CodingKeys: String, CodingKey {
        case info = "CrtfcUpsoInfo"
    }
    
}

struct Info: Decodable {
    let totalCount: Int
    let code: Code
    let detail: [Detail]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "list_total_count"
        case code = "RESULT"
        case detail = "row"
    }
    
    struct Code: Codable {
        let code, message: String

        enum CodingKeys: String, CodingKey {
            case code = "CODE"
            case message = "MESSAGE"
        }
    }
    
    struct Detail: Decodable {
        let crtfcUpsoMgtSno: Int
        let upsoNm, cggCode, cggCodeNm: String
        let cobCodeNm, bizcndCodeNm, ownerNm, crtfcGbn: String
        let crtfcGbnNm, crtfcChrNm, crtfcYmd: String
        let useYn, mapIndictYn, crtfcClass, longitude: String
        let latitude, telNo, rdnDetailAddr, rdnAddrCode: String
        let rdnCodeNm, bizcndCode, cobCode, crtfcSno: String
        let crtTime, crtUSR, updTime, foodMenu: String
        let gntNo, crtfcYn: String

        enum CodingKeys: String, CodingKey {
            case crtfcUpsoMgtSno = "CRTFC_UPSO_MGT_SNO"
            case upsoNm = "UPSO_NM"
            case cggCode = "CGG_CODE"
            case cggCodeNm = "CGG_CODE_NM"
            case cobCodeNm = "COB_CODE_NM"
            case bizcndCodeNm = "BIZCND_CODE_NM"
            case ownerNm = "OWNER_NM"
            case crtfcGbn = "CRTFC_GBN"
            case crtfcGbnNm = "CRTFC_GBN_NM"
            case crtfcChrNm = "CRTFC_CHR_NM"
            case crtfcYmd = "CRTFC_YMD"
            case useYn = "USE_YN"
            case mapIndictYn = "MAP_INDICT_YN"
            case crtfcClass = "CRTFC_CLASS"
            case longitude = "X_CNTS"
            case latitude = "Y_DNTS"
            case telNo = "TEL_NO"
            case rdnDetailAddr = "RDN_DETAIL_ADDR"
            case rdnAddrCode = "RDN_ADDR_CODE"
            case rdnCodeNm = "RDN_CODE_NM"
            case bizcndCode = "BIZCND_CODE"
            case cobCode = "COB_CODE"
            case crtfcSno = "CRTFC_SNO"
            case crtTime = "CRT_TIME"
            case crtUSR = "CRT_USR"
            case updTime = "UPD_TIME"
            case foodMenu = "FOOD_MENU"
            case gntNo = "GNT_NO"
            case crtfcYn = "CRTFC_YN"
        }
    }
}

extension RestaurantResponseDTO {
    func toDomain(_ restaurant: RestaurantResponseDTO) -> [RestaurantMKAnnotation] {
        restaurant.info.detail.map {
            return .init(title: $0.upsoNm, subtitle: $0.foodMenu, locationName: $0.rdnCodeNm, type: $0.cobCodeNm, coordinate: CLLocationCoordinate2D(latitude: Double($0.latitude) ?? .zero, longitude: Double($0.longitude) ?? .zero), phoneNumber: $0.telNo)
        }
    }
}
