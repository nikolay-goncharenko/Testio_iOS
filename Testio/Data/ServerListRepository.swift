//
//  ServerListRepository.swift
//  Testio
//
//  Created by Nick Goncharenko on 30.11.2025.
//

final class ServerListRepository {
    
    // MARK: - Server list sort options
    enum ServerListSort {
        case originalOrder
        case distance
        case name
    }
    
    // MARK: - Private instances
    private let storage = ServerListStorage()
    private let service = ServerListService()
    
    // MARK: - Internal handlers
    internal func getSortedServerList(
        by sort: ServerListSort,
        completion: @escaping ([ServerListObject]) -> Void
    ) {
        getServerList { list in
            completion(self.sort(list, by: sort))
        }
    }
    
    internal func clearCache() {
        storage.clearServerList()
    }
    
    // MARK: - Private handlers
    private func getServerList(completion: @escaping ([ServerListObject]) -> Void) {
        service.fetchServerList { [weak self] result in
            if let self {
                switch result {
                case .success(let list):
                    storage.saveServerList(list)
                    let objects = storage.fetchServerList()
                    completion(objects)
                case .failure:
                    let cached = storage.fetchServerList()
                    completion(cached)
                }
            }
        }
    }
    
    private func sort(_ list: [ServerListObject], by sort: ServerListSort) -> [ServerListObject] {
        switch sort {
        case .originalOrder:
            return list.sorted { $0.originalOrder < $1.originalOrder }
        case .distance:
            return list.sorted { $0.distance < $1.distance }
        case .name:
            return list.sorted { $0.name.lowercased() < $1.name.lowercased() }
        }
    }
}
