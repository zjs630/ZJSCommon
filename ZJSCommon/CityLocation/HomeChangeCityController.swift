//
//  HomeChangeCityController.swift
//  tsbbtClient
//
//  Created by zjs on 2020/7/24.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

/// 切换城市页面
class HomeChangeCityController: UIViewController {
    
    var listData: [[[String:String]]] = []
    var letters: [String] = []
    
    let headerView = ChangeCityHeaderView()
    let citySearchController = HomeCitySearchController()
    let sqlManager = MySQLLiteManager.shared
    private var tableView = UITableView(frame: CGRect(x: 0, y: UIScreen.topSafeHight, width: UIScreen.width, height: UIScreen.height - UIScreen.topSafeHight), style: .plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

    private func loadData() {
        let firstLetters = sqlManager.getAllGroupWord()
        listData = sqlManager.getAllGroupedCitys(with: firstLetters)
        letters = ["定位",""] + firstLetters
        tableView.reloadData()
        let city = LocationManager.shared.getCityInfo()
        headerView.updateUI(selected: city.selectedCity, location: city.locationCity)
    }
    
     @objc private func reLocation() {
        headerView.currentLoactionLabel.text = "定位中"
        let manager:LocationManager = LocationManager.shared
        manager.faild = {
            self.headerView.currentLoactionLabel.text = "定位失败，请重试"
        }
        manager.success = { (_,_,locality) in
            self.headerView.currentLoactionLabel.text = locality ?? ""
            manager.selectedLocation = nil // 顺序不可错
            manager.delegate?.userSelectedOrLocatedPosition(city: locality ?? "")
            self.navigationController?.popViewController(animated: true)
        }
        manager.startLocation()
    }

}
// MARK: - tableview dataSource delegate
extension HomeChangeCityController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseid")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseid")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            cell?.textLabel?.textColor = UIColor(0x2F2F33)
        }
        let dic = listData[indexPath.section][indexPath.row]
        cell?.textLabel?.text = dic["c_fullname"]
        return cell!
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = listData[indexPath.section][indexPath.row]
        LocationManager.shared.selectedLocation = (data["c_fullname"] ?? "", data["c_code"] ?? "")
        navigationController?.popViewController(animated: true)
    }
    // MARK: -  索引
    func sectionIndexTitles(for _: UITableView) -> [String]? {
        return letters
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index - 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return letters[section + 2]
    }

}

extension HomeChangeCityController: UITextFieldDelegate {
    
}

extension HomeChangeCityController: BackSearchNavigationBarProtocol {
    
    func textFieldTextDidChange(notify: Notification) {
        
        guard let textField = notify.object as? UITextField,
            let text = textField.text, text.count > 0 else {
                citySearchController.matchList = []
                citySearchController.view.isHidden = true
                return
        }
        if (textField.markedTextRange == nil) {
            citySearchController.view.isHidden = false
            let nText = text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            citySearchController.matchList = sqlManager.searchCity(with: nText)
        }
    }
    
    var searchDelegate: UITextFieldDelegate {
        return self
    }
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        view.addSubview(tableView)

        let matchView = citySearchController.view
        matchView?.isHidden = true
        citySearchController.delegate = self
        view.addSubview(matchView!)
        matchView!.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
        
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: 164)
        let tap = UITapGestureRecognizer(target: self, action: #selector(reLocation))
        headerView.cornerView.addGestureRecognizer(tap)
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .singleLine
        addNavigationBar()

    }
}
