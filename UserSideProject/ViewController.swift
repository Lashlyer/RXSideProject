//
//  ViewController.swift
//  UserSideProject
//
//  Created by Alvin on 2022/2/7.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import MBProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    private let compositeDisposable = CompositeDisposable()
    private lazy var userViewModel = {
        UserViewModel(UserDataDomainRepository(UserDataRepository(HttpRequest.Singleton)),
                      compositeDisposable)
    }()
    
    private lazy var hud: MBProgressHUD = {
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        loading.mode = .indeterminate
        loading.label.text = "Loading...."
        return loading
    }()
    private var userData: [UserDataResponse.User] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewInit(self.listTableView)
        readApi()

    }
    
    private func readApi() {
        _ = compositeDisposable.insert(userViewModel.readUserData().subscribe(onNext: { [weak self] status in
            switch status {
                
            case .loadstart:
                self?.hud.show(animated: true)
            case .loadEnd:
                self?.listTableView.reloadData()
                self?.hud.hide(animated: true)
            case .error(errorMessage: let errorMessage):
                break
            case .data(data: let data):
                self?.userData = data.userData
            }
            
        }, onError: { error in
            print(error)
        }))
    }
    
    private func tableViewInit(_ tableview: UITableView) {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.setValue(data: userData[indexPath.row])
        
        return cell
    }
    
    
}



