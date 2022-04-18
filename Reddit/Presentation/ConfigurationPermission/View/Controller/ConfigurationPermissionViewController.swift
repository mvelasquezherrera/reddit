//
//  ConfigurationPermissionViewController.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 17/04/22.
//

import UIKit

protocol ConfigurationPermissionViewControllerProtocol: class {
    func reloadData()
    func startLoadingAnimation()
    func finishLoadingAnimation()
    func cancelButtonAction()
}

class ConfigurationPermissionViewController: BaseViewController {

    @IBOutlet weak var configurationPermissionCollection: UICollectionView!
    
    private let startLoading = UINib(nibName: "CustomLoadingView", bundle: nil).instantiate(withOwner: self, options: nil).first as! CustomLoadingView
    
    private let refreshControl = UIRefreshControl()
    let searchController = UISearchController(searchResultsController: nil)
    
    var presenter: ConfigurationPermissionPresenterProtocol!
    var configurator = ConfigurationPermissionConfigurator()
    var viewData: ViewData?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configureconfigurationPermissionCollectionView()
    }
    
}

// MARK: - SETUP VIEW
extension ConfigurationPermissionViewController {
    
    func setupView() {
        configurator.configure(viewController: self)
        configureUI()
    }
    
    func setupNavigation() {
        title = ""
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureconfigurationPermissionCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        configurationPermissionCollection.backgroundColor = .white
        configurationPermissionCollection.register(ConfigurationPermissionCollectionViewCell.nib(), forCellWithReuseIdentifier: ConfigurationPermissionCollectionViewCell.identifier)
        configurationPermissionCollection.delegate = self
        configurationPermissionCollection.dataSource = self
        configurationPermissionCollection.layoutIfNeeded()
        configurationPermissionCollection.isPagingEnabled = true
        configurationPermissionCollection.showsHorizontalScrollIndicator = false
        configurationPermissionCollection.collectionViewLayout = flowLayout
    }
    
    private func setConstraints(forView view: UIView, toView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: toView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: toView, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
    
}

// MARK: - OBJC
extension ConfigurationPermissionViewController {
    
    @objc func didTapBackButton() {
        
    }
    
}

// MARK: - IBACTION
extension ConfigurationPermissionViewController {
    
    
    
}

// MARK: - PROTOCOL METHODS
extension ConfigurationPermissionViewController: ConfigurationPermissionViewControllerProtocol {
    
    func reloadData() {
        configurationPermissionCollection.reloadData()
    }
    
    func cancelButtonAction() {
        
        let offSet = configurationPermissionCollection.contentOffset.x
        let widthCollection = configurationPermissionCollection.frame.width
        
        if offSet != widthCollection * (CGFloat(presenter.getNumberOfItems() - 1)) {
            
            UIView.animate(withDuration: 0.3) {
                self.configurationPermissionCollection.contentOffset.x += widthCollection
            }
            
        } else {
            presenter.dismissConfiguration()
        }
        
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ConfigurationPermissionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConfigurationPermissionCollectionViewCell.identifier, for: indexPath) as! ConfigurationPermissionCollectionViewCell
        
        let data = presenter.getDataOfItems(row: indexPath.row)
        
        cell.view = self
        cell.presenter = presenter
        cell.row = indexPath.row
        
        cell.nameImgPermission = data.imgNamePermission ?? ""
        cell.titlePermission = data.titlePermission ?? ""
        cell.descriptionPermission = data.descriptionPermission ?? ""
        cell.titleBtnAllow = data.titleBtnAllow ?? ""
        cell.titleBtnCancel = data.titleBtnCancel ?? ""
        
        cell.backgroundColor = .red
        
        return cell
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ConfigurationPermissionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - CustomLoadingViewDelegate
extension ConfigurationPermissionViewController: CustomLoadingViewDelegate {
    
    func startLoadingAnimation() {
        finishLoadingAnimation()
        self.view.bringSubviewToFront(startLoading)
        self.view.addSubview(startLoading)
        setConstraints(forView: startLoading, toView: self.view)
        startLoading.startLoadingAnimation()
    }
    
    func finishLoadingAnimation() {
        startLoading.finishLoadingAnimation()
        startLoading.removeFromSuperview()
    }
    
}
