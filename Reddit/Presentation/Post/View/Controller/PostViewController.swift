//
//  PostViewController.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import UIKit

protocol PostViewControllerProtocol: class {
    func reloadData()
    func hideTableview(isHide: Bool)
    func startLoadingAnimation()
    func finishLoadingAnimation()
    func endRefreshing()
    func showEmptyView(show: Bool)
    func cleanSearchText()
}

class PostViewController: BaseViewController {

    @IBOutlet weak var postTable: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var imgEmptyView: UIImageView!
    @IBOutlet weak var lblTitleEmptyView: UILabel!
    @IBOutlet weak var lblDescriptionEmptyView: UILabel!
    
    private let startLoading = UINib(nibName: "CustomLoadingView", bundle: nil).instantiate(withOwner: self, options: nil).first as! CustomLoadingView
    
    private let refreshControl = UIRefreshControl()
    let searchController = UISearchController(searchResultsController: nil)
    
    var presenter: PostPresenterProtocol!
    var configurator = PostConfigurator()
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
        configurePostTableView()
        configureEmptyView()
    }
    
}

// MARK: - SETUP VIEW
extension PostViewController {
    
    func setupView() {
        configurator.configure(viewController: self)
        configureUI()
    }
    
    func setupNavigation() {
        title = "Posts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configurePostTableView() {
        postTable.delegate = self
        postTable.dataSource = self
        postTable.rowHeight = UITableView.automaticDimension
        postTable.separatorStyle = .none
        postTable.backgroundColor = .white
        postTable.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
        postTable.reloadData()
        configureRefreshControl()
        configureSearchController()
    }
    
    func configureRefreshControl() {
        if #available(iOS 10.0, *) {
            postTable.refreshControl = refreshControl
        } else {
            postTable.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshPost(_:)), for: .valueChanged)

    }
    
    private func configureSearchController() {
        searchController.loadViewIfNeeded()
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Ingrese el título"
        searchController.hidesNavigationBarDuringPresentation = false
        
    }
    
    func configureEmptyView() {
        
        showEmptyView(show: false)
        emptyView.backgroundColor = .white
        
        imgEmptyView.image = UIImage(named: "imgEmptyViewPost")
        
        lblTitleEmptyView.text = "No Results"
        lblTitleEmptyView.font = UIFont(name: "HelveticaNeue-Regular", size: 20)
        lblTitleEmptyView.textColor = ColorPalette.DesignSystem.titleColor
        lblTitleEmptyView.numberOfLines = 0
        lblTitleEmptyView.textAlignment = .center
        
        lblDescriptionEmptyView.text = "Sorry, there are no results for this search. Please try another phrase"
        lblDescriptionEmptyView.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
        lblDescriptionEmptyView.textColor = ColorPalette.DesignSystem.descriptionColor
        lblDescriptionEmptyView.numberOfLines = 0
        lblDescriptionEmptyView.textAlignment = .center
        
    }
    
    func showEmptyView(show: Bool) {
        emptyView.isHidden = !show
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
extension PostViewController {
    
    @objc func didTapBackButton() {
        
    }
    
    @objc private func refreshPost(_ sender: Any) {
        // Fetch Weather Data
        presenter.getListPost(isPull: true)
    }
    
}

// MARK: - IBACTION
extension PostViewController {
    
    
    
}

// MARK: - PROTOCOL METHODS
extension PostViewController: PostViewControllerProtocol {
    
    func reloadData() {
        postTable.reloadData()
    }
    
    func hideTableview(isHide: Bool) {
        
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func cleanSearchText() {
        searchController.searchBar.text = ""
    }
    
}

// MARK: - UITableViewDataSource y UITableViewDelegate
extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        
        let data = presenter.getDataOfRows(row: indexPath.row).data
        
        cell.urlImgPost = data?.url ?? ""
        cell.titlePost = data?.title ?? ""
        cell.nameImgArrowUp = "imgArrowUp"
        cell.scorePost = String(data?.score ?? 0)
        cell.nameImgArrowDown = "imgArrowDown"
        cell.countCommentsPost = String(data?.num_comments ?? 0)
        cell.nameImgComment = "imgCountComments"
        
        cell.isUserInteractionEnabled = false
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - CustomLoadingViewDelegate
extension PostViewController: CustomLoadingViewDelegate {
    
    func startLoadingAnimation() {
        finishLoadingAnimation()
        self.view.bringSubviewToFront(startLoading)
        self.view.addSubview(startLoading)
        setConstraints(forView: startLoading, toView: self.view)
        startLoading.startLoadingAnimation()
    }
    
    func finishLoadingAnimation() {
        startLoading.finishLoadingAnimation()
        endRefreshing()
        startLoading.removeFromSuperview()
    }
    
}

// MARK: - UISearchResultsUpdating, UISearchBarDelegate
extension PostViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text!
        
        presenter.updateSearchResultsTable(searchText: searchText)
        postTable.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.actionSearchBarCancelButtonClicked()
        postTable.reloadData()
    }
    
}
