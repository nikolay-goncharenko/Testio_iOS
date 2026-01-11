//
//  ServerListStorageMock.swift
//  Testio
//
//  Created by Nick Goncharenko on 01.12.2025.
//

import Foundation
@testable import Testio

final class ServerListStorageMock: ServerListStorageProtocol {
    
    var saved: [ServerListResponseDTO] = []
    var fetched: [ServerListObject] = []
    
    func saveServerList(_ list: [ServerListResponseDTO]) {
        saved = list
    }
    
    func fetchServerList() -> [ServerListObject] {
        return fetched
    }
    
    func clearServerList() {
        saved = []
        fetched = []
    }
}
