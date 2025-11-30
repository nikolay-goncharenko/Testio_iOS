//
//  ServerListObject.swift
//  Testio
//
//  Created by Nick Goncharenko on 29.11.2025.
//

import RealmSwift

final class ServerListObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var distance: Int
    @Persisted var originalOrder: Int
}
