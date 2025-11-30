//
//  ServerListViewModel.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import Foundation

final class ServerListViewModel {
    
    // MARK: - Coordinator reference
    internal weak var navigator: ServerListNavigation?
    
    // MARK: - Internal closure with server list
    internal var onFetched: (([ServerListObject]) -> Void)?
    
    // MARK: - Repository & Keychain instances
    private let repository = ServerListRepository()
    private let keychain = KeychainStorage()
    
    // MARK: - Fetching server list handlers
    internal func fetchServerList() {
        repository.getSortedServerList(by: .originalOrder) { [weak self] list in
            self?.onFetched?(list)
        }
    }
    
    internal func fetchServersSortedByDistance() {
        repository.getSortedServerList(by: .distance) { [weak self] list in
            self?.onFetched?(list)
        }
    }
    
    internal func fetchServersSortedByName() {
        repository.getSortedServerList(by: .name) { [weak self] list in
            self?.onFetched?(list)
        }
    }
    
    // MARK: - Clear keychain storage
    internal func clearAuthToken() {
        keychain.delete(KeychainConfig.tokenKey)
    }
}
