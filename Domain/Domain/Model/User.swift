//
//  User.swift
//  Domain
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import Foundation

public struct User {
    
    public var nombres: String
    public var apellidos: String
    public var correo: String
    public var usuario: String
    
    public init(nombres: String, apellidos: String, correo: String, usuario: String) {
        self.nombres = nombres
        self.apellidos = apellidos
        self.correo = correo
        self.usuario = usuario
    }
   
}

// MARK:- ENCODE AND DECODE
extension User: Encodable, Decodable {
    
    static func encode(user: User) -> String {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            let userString = String(data: jsonData, encoding: .utf8)
            return userString ?? ""
        }
        catch {
            return ""
        }
    }
    
    static func decode(jsonUser: String) -> User? {
        let jsonDecoder = JSONDecoder()
        guard let dataUser = jsonUser.data(using: .utf8) else { return nil }
        return try? jsonDecoder.decode(User.self, from: dataUser)
        
    }

}
