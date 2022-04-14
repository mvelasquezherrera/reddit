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
}

class PostViewController: BaseViewController {

    @IBOutlet weak var postTable: UITableView!
    
    var presenter: PostPresenterProtocol!
    var configurator = PostConfigurator()
    var viewData: ViewData?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        presenter.viewDidLoad()
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
        postTable.layoutIfNeeded()
        postTable.rowHeight = UITableView.automaticDimension
        postTable.separatorStyle = .none
        postTable.backgroundColor = .white
        postTable.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
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
    
}

// MARK: - UITableViewDataSource y UITableViewDelegate
extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        
        cell.urlImgPost = ""
        cell.titlePost = ""
        cell.nameImgArrowUp = ""
        cell.scorePost = ""
        cell.nameImgArrowDown = ""
        cell.countCommentsPost = ""
        cell.nameImgComment = ""
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

