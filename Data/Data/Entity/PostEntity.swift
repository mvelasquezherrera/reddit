//
//  PostEntity.swift
//  Data
//
//  Created by Marcelo Stefano Velasquez Herrera on 14/04/22.
//

import Foundation
import Domain

struct PostEntity: Codable {
    let kind: String?
    let data: PostDataEntity?
}

struct PostDataEntity: Codable {
    let after: String?
    let dist: Int?
    let modhash: String?
    let geo_filter: String?
    let children: [PostChildrenEntity]?
    let before: String?
}

struct PostChildrenEntity: Codable {
    let kind: String?
    let data: PostDataChildrenEntity?
}

struct PostDataChildrenEntity: Codable {
    let url: String?
    let title: String?
    let score: Int?
    let num_comments: Int?
}

// MARK: - MAPPER
extension PostDataChildrenEntity {
    
    static func mapperPostDataChildrenEntity(entity: PostDataChildrenEntity?) -> PostDataChildrenModel {
        return PostDataChildrenModel(url: entity?.url, title: entity?.title, score: entity?.score, num_comments: entity?.num_comments)
    }
    
}

extension PostChildrenEntity {
    
    static func mapperPostChildrenEntity(entity: [PostChildrenEntity]?) -> [PostChildrenModel] {
        
        guard let data = entity else { return [PostChildrenModel]()}
        
        let list = data.map {
            PostChildrenModel(kind: $0.kind, data: PostDataChildrenEntity.mapperPostDataChildrenEntity(entity: $0.data))
        }
        
        return list
        
    }
    
}

extension PostDataEntity {
    
    static func mapperPostDataEntity(entity: PostDataEntity?) -> PostDataModel {
        return PostDataModel(after: entity?.after, dist: entity?.dist, modhash: entity?.modhash, geo_filter: entity?.geo_filter, children: PostChildrenEntity.mapperPostChildrenEntity(entity: entity?.children), before: entity?.before)
    }
    
}

extension PostEntity {
    
    static func mapperPostEntity(entity: PostEntity?) -> PostModel {
        return PostModel(kind: entity?.kind, data: PostDataEntity.mapperPostDataEntity(entity: entity?.data))
    }
    
}
