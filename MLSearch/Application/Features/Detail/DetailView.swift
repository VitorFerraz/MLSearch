//
//  DetailView.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 12/02/21.
//

import UIKit
import DesignSystem

struct DetailViewModel: Hashable {
    var model : ProductDetail
}

protocol DetailViewDelegate: class {
    func getViewModel() -> DetailViewModel?
}
protocol DetailViewProtocol {
    func showLoading()
    func showError(with message: String)
    func reloadData()
}

enum DetailSection {
    case main
}

typealias DetailDataSource = UICollectionViewDiffableDataSource<DetailSection, DetailViewModel>
typealias DetailSnapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailViewModel>

final class DetailView: UIView, ViewConfigurator {
    weak var delegate: DetailViewDelegate?
    private lazy var dataSource: DetailDataSource = {
        let dataSource = DetailDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, viewModel) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: DetailCollectionViewCell.self),
                    for: indexPath) as? DetailCollectionViewCell
                cell?.configureWith(viewModel: viewModel)
                return cell
            })
        return dataSource
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.setState(with: .hide)
        view.delegate = self
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: DetailCollectionViewCell.self))
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

extension DetailView: LoadingViewDelegate {
    func didTapRetry() {
     
    }
}


extension DetailView: SearchViewProtocol {
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


extension DetailView: UICollectionViewDelegateFlowLayout, UICollisionBehaviorDelegate {
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = DetailSnapshot()
        snapshot.appendSections([.main])
        guard let viewModel = delegate?.getViewModel() else { return }
        snapshot.appendItems([viewModel])
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
