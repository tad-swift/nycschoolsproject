//
//  ViewController.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/24/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: view.bounds, collectionViewLayout: .init())
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return v
    }()
    
    let viewModel = HomeViewModel()
    var observers: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
    }
    
    private func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "NYC Schools"
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupObservers() {
        viewModel.$schools
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &observers)
    }
    
}

// MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let school = viewModel.schools[safe: indexPath.item] {
            Navigator.showSchool(school)
        }
    }
    
    // infinite scrolling. Better user experience than using PrefetchDataSource
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item >= viewModel.schools.count - 3 {
            viewModel.fetchNextSchools()
        }
    }
}

// MARK: - CollectionView Datasource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.schools.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let schoolCell = collectionView.dequeueReusableCell(withReuseIdentifier: SchoolCollectionViewCell.reuseID, for: indexPath) as! SchoolCollectionViewCell
        if let school = viewModel.schools[safe: indexPath.item] {
            schoolCell.viewModel = SchoolCellViewModel(school: school)
        }
        return schoolCell
    }
    
}

