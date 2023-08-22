//
//  NYCListViewVC.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation
import UIKit

class NYCListViewVC: UIViewController {
    // UI Components
    
    @IBOutlet var reloadBtn: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    // Variables
    let searchController = UISearchController(searchResultsController: nil)

    
    private let listViewModel = NYCListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listViewModel.reloadTableData = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        self.title = "NYC Public School"
        listViewModel.fetchSchoolList()
        setupSearchController()
    }
    
    // MARK: - Private instance methods
    
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Schools"
        searchController.searchBar.tintColor = UIColor.white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        listViewModel.filterSchoolList(searchText: searchText)
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    @objc func callNumber(_ sender: UIButton){
    
        
        var nycHighSchoolList: NYCHighSchools
        
        if isFiltering() {
            nycHighSchoolList = listViewModel.filteredSchoolList[sender.tag]
        } else {
            nycHighSchoolList = listViewModel.schoolList[sender.tag]
        }
        
        let schoolPhoneNumber = nycHighSchoolList.phNum
        let obj = CustomObject()
        obj.makePhoneCall(schoolPhoneNumber)
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        print("Reloading...")
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.listViewModel.fetchSchoolList()
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass the selected school with sat score to the destinatiion view controller
        if segue.identifier == AppConstants.ViewIdentifiers.HSWithSATScoreSegue{
            let highSchoolWithSATScoreVC = segue.destination as! NYCSchoolDetailVC
            if let highSchoolWithSATScore = sender as? NYCHighSchools {
                print(highSchoolWithSATScore)
                highSchoolWithSATScoreVC.nycHighSchool = highSchoolWithSATScore
                print(highSchoolWithSATScoreVC.nycHighSchool)
            }
        }
    }
    
    
}

extension NYCListViewVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


// MARK: UITableViewDataSource and UITableViewDelegate Extensions
extension NYCListViewVC: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isFiltering() {
            //CellAnimator.animate(cell, withDuration: 0.6, animation: CellAnimator.AnimationType(rawValue: 5)!)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return self.listViewModel.filteredSchoolList.count
        }
        
        return self.listViewModel.schoolList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NYCSHTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: AppConstants.Cells.nycListCell, for: indexPath) as! NYCSHTableViewCell
      
        tableView.rowHeight = 195
        
        var nycHighSchool: NYCHighSchools
        
        if isFiltering() {
            nycHighSchool = self.listViewModel.filteredSchoolList[indexPath.row]
        } else {
            nycHighSchool = self.listViewModel.schoolList[indexPath.row]
        }
        
        if let schoolName = nycHighSchool.schoolName {
            cell.schoolNameLbl.text = schoolName
        }
        
       
        let address = listViewModel.getCompleteAddressWithoutCoordinate(nycHighSchool.address)
        cell.schoolAddrLbl.text = address
        
        if let phoneNum = nycHighSchool.phNum{
            cell.schoolPhoneNumLbl.text = phoneNum
            cell.schoolPhoneNumBtn.tag = indexPath.row
            cell.schoolPhoneNumBtn.addTarget(self, action: #selector(self.callNumber(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    //MARK: - UITable View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var nycHighSchoolList: NYCHighSchools
        
        if isFiltering() {
            nycHighSchoolList = listViewModel.filteredSchoolList[indexPath.row]
        } else {
            nycHighSchoolList = listViewModel.schoolList[indexPath.row]
        }
        
        let selectedHighSchool = nycHighSchoolList
        self.performSegue(withIdentifier: AppConstants.ViewIdentifiers.HSWithSATScoreSegue, sender: selectedHighSchool)
        
    }
}

