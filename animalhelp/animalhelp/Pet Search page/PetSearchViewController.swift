//
//  PetSearchViewController.swift
//  animalhelp
//
//  Created by Aamir  on 04/01/18.
//  Copyright © 2018 AamirAnwar. All rights reserved.
//

import Foundation
import UIKit


class PetSearchViewController:BaseViewController, PetSearchViewModelDelegate {
    
    let kMissingPetCellReuseIdentifier = "MissingPetTableViewCell"
    
    let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
    let searchBar = UISearchBar(frame: CGRect.zero)
    var viewModel:PetSearchViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let title = NSMutableAttributedString(string: "Pet Search\n", attributes: [NSAttributedStringKey.foregroundColor:CustomColorTextBlack,NSAttributedStringKey.font:CustomFontTitleBold,NSAttributedStringKey.paragraphStyle:paragraphStyle])
        title.append(NSAttributedString(string: "Delhi", attributes:[NSAttributedStringKey.foregroundColor:CustomColorMainTheme,NSAttributedStringKey.font:CustomFontHeadingSmall,NSAttributedStringKey.paragraphStyle:paragraphStyle]))
        customNavBar.setAttributedTitle(title)
        self.customNavBar.enableRightButtonWithTitle("Info")
        self.createSearchBar()
        createTableView()
        self.viewModel.searchForMissingPets()
    }
    
    func createSearchBar() {
        self.view.addSubview(self.searchBar)
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search"
        self.searchBar.backgroundColor = UIColor.white
        self.searchBar.searchBarStyle = .minimal
//        self.searchBar.barTintColor = CustomColorMainTheme
        self.searchBar.tintColor = CustomColorMainTheme
//        self.searchBar.backgroundImage = UIImage()
        self.searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.customNavBar.snp.bottom)
            make.leading.equalToSuperview().offset(kSidePadding)
            make.trailing.equalToSuperview().inset(kSidePadding)
        }
    }
    
    func createTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tablecell")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 20, right: 0)
        self.tableView.register(MissingPetTableViewCell.self, forCellReuseIdentifier: self.kMissingPetCellReuseIdentifier)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func didUpdateMissingPets() {
        self.tableView.reloadData()
    }
    
}

extension PetSearchViewController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension PetSearchViewController:UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.missingPets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pet = self.viewModel.missingPets[indexPath.row]
        return self.getMissingPetCell(tableView, pet: pet)
    }
    
    func getMissingPetCell(_ tableView:UITableView, pet:MissingPet) -> MissingPetTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMissingPetCellReuseIdentifier) as! MissingPetTableViewCell
        cell.setMissingPet(pet)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < self.viewModel.missingPets.count else {
            return
        }
        let missingPetDetailVC = MissingPetDetailViewController()
        missingPetDetailVC.pet = self.viewModel.missingPets[indexPath.row]
        self.navigationController?.pushViewController(missingPetDetailVC, animated: true)
        
    }
}
