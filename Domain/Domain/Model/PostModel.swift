//
//  PostModel.swift
//  Domain
//
//  Created by Marcelo Stefano Velasquez Herrera on 14/04/22.
//

import Foundation

public class PostModel {
    
    public var kind: String?
    public var data: PostDataModel?
    
    public init(kind: String?, data: PostDataModel?) {
        self.kind = kind
        self.data = data
    }
        
}

public class PostDataModel {
    
    public var after: String?
    public var dist: Int?
    public var modhash: String?
    public var geo_filter: String?
    public var children: [PostChildrenModel]?
    public var before: String?
    
    public init(after: String?, dist: Int?, modhash: String?, geo_filter: String?, children: [PostChildrenModel]?, before: String?) {
        self.after = after
        self.dist = dist
        self.modhash = modhash
        self.geo_filter = geo_filter
        self.children = children
        self.before = before
    }
    
}

public class PostChildrenModel {
    
    public var kind: String?
    public var data: PostDataChildrenModel?
    
    public init(kind: String?, data: PostDataChildrenModel?) {
        self.kind = kind
        self.data = data
    }
    
}

public class PostDataChildrenModel {
    
    public var url: String?
    public var title: String?
    public var score: Int?
    public var num_comments: Int?
    
    public init(url: String?, title: String?, score: Int?, num_comments: Int?) {
        self.url = url
        self.title = title
        self.score = score
        self.num_comments = num_comments
    }
    
}
