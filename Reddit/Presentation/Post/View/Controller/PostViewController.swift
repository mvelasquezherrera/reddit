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
}

class PostViewController: BaseViewController {

    @IBOutlet weak var postTable: UITableView!
    
    private let startLoading = UINib(nibName: "CustomLoadingView", bundle: nil).instantiate(withOwner: self, options: nil).first as! CustomLoadingView
    
    private let refreshControl = UIRefreshControl()
    
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
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configurePostTableView()
    }
    
}

// MARK: - SETUP VIEW
extension PostViewController {
    
    func setupView() {
        configurator.configure(viewController: self)
        configureUI()
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.view.backgroundColor = .clear
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.setLeftBarButton(back, animated: false)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
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
    }
    
    func configureRefreshControl() {
        if #available(iOS 10.0, *) {
            postTable.refreshControl = refreshControl
        } else {
            postTable.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshPost(_:)), for: .valueChanged)

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
