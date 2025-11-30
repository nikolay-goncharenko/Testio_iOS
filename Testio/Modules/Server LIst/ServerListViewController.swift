//
//  ServerListViewController.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

final class ServerListViewController: BaseViewController {
    
    // MARK: - ViewModel instance
    private let viewModel: ServerListViewModel
    
    // MARK: - Server list storage
    private var serverList: [ServerListObject] = []
    
    // MARK: - Components definition
    private let navigationHeaderView = NavigationHeaderView()
    
    private var collectionViewLayout: UICollectionViewLayout {
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(44)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: collectionViewLayout)
        .registerHeader(ServersListHeader.self)
        .registerCell(ServersListCell.self)
        .background(color: .clear)
        .dataSource(self)
    
    // MARK: - Initializer
    init(viewModel: ServerListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    override func setupSubviews() {
        view.background(color: R.color.softPearl())
        view.addSubviews([navigationHeaderView, collectionView])
    }
    
    override func setupLayout() {
        navigationHeaderView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(46)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func setupHandlers() {
        navigationHeaderView.filterBtnDidTouch = { [weak self] in
            if let self {
                viewModel.navigator?.showBottomActionSheet {
                    self.viewModel.fetchServersSortedByDistance()
                } byServer: {
                    self.viewModel.fetchServersSortedByName()
                }
            }
        }
        
        navigationHeaderView.signOutBtnDidTouch = { [weak self] in
            if let self {
                viewModel.navigator?.openSignInScreen()
                viewModel.clearAuthToken()
            }
        }
    }
    
    // MARK: - Binding
    override func bindViewModel() {
        viewModel.fetchServerList()
        viewModel.onFetched = { [weak self] list in
            if let self {
                serverList = list
                collectionView.reloadData()
            }
        }
    }
}

// MARK: - ServerListViewController extensions
extension ServerListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableHeader(indexPath) as ServersListHeader
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serverList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(indexPath) as ServersListCell
        let server = serverList[indexPath.item]
        
        cell.setServerValue(server.name)
        cell.setDistanceValue("\(server.distance) km")
        
        return cell
    }
}
