//
//  SearchView.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit
import DesignSystem

protocol SearchViewDelegate: class {
    func didTapSearch(text: String)
    func didTapRetry(text: String)
    func getViewModels() -> [ProductViewModel]
    func didTapProduct(_ viewModel: ProductViewModel)
}

protocol SearchViewProtocol {
    func showLoading()
    func showError(with message: String)
    func reloadData()
}

enum SearchSection {
    case main
}

typealias SearchDataSource = UICollectionViewDiffableDataSource<SearchSection, ProductViewModel>
typealias SearchSnapshot = NSDiffableDataSourceSnapshot<SearchSection, ProductViewModel>

final class SearchView: UIView, ViewConfigurator {
    weak var delegate: SearchViewDelegate?
    private lazy var dataSource: SearchDataSource = {
        let dataSource = SearchDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, viewModel) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: ProductCollectionViewCell.self),
                    for: indexPath) as? ProductCollectionViewCell
                cell?.configureWith(viewModel: viewModel)
                return cell
            })
        return dataSource
    }()
    
    var text: String?
    
    lazy var searchController: UISearchController = {
        let templateVc = SearchBarViewController()
        templateVc.view.backgroundColor = .white
        let searchController = UISearchController(searchResultsController: templateVc)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        searchController.searchBar.textContentType = .none
        searchController.searchBar.placeholder = "Digite o nome de um produto aqui"
        searchController.searchBar.barTintColor = StyleGuide.Color.primary
        searchController.searchBar.layer.borderColor = StyleGuide.Color.primary.cgColor
        searchController.searchBar.tintColor = StyleGuide.Color.Text.primary
        searchController.searchBar.searchTextField.backgroundColor = StyleGuide.Color.Background.white
        searchController.showsSearchResultsController = true
        return searchController
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.setState(with: .hide)
        view.delegate = self
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProductCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
    }
    
    func addViewHierarchy() {
        addSubview(loadingView)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        loadingView.anchor(top: safeAreaLayoutGuide.topAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor)
        
        collectionView.anchor(top: safeAreaLayoutGuide.topAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor)
    }

}

extension SearchView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        text = nil
        searchController.isActive = true
        searchController.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        self.text = text
        delegate?.didTapSearch(text: text)
        searchController.isActive = false
        searchController.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = text
    }
}

extension SearchView: LoadingViewDelegate {
    func didTapRetry() {
        guard let text = text else { return }
        delegate?.didTapRetry(text: text)
    }
}


extension SearchView: SearchViewProtocol {
    func showLoading() {
        collectionView.isHidden = true
        loadingView.setState(with: .loading)
    }
    
    func showError(with message: String) {
        collectionView.isHidden = true
        loadingView.setState(with: .error(message: message))
    }
    
    func reloadData() {
        collectionView.isHidden = false
        applySnapshot()
        loadingView.setState(with: .hide)
    }
}


extension SearchView: UICollectionViewDelegateFlowLayout, UICollisionBehaviorDelegate {
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = SearchSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(delegate?.getViewModels() ?? [])
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = dataSource.itemIdentifier(for: indexPath) else {
          return
        }
        delegate?.didTapProduct(viewModel)
    }
}
