//
//  SchoolVC.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import UIKit
import Combine

final class SchoolVC: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 100)
        layout.minimumInteritemSpacing = 10
        let v = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var viewModel: SchoolVCViewModel
    var observers: Set<AnyCancellable> = []
    
    init(school: School) {
        self.viewModel = SchoolVCViewModel(school: school)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init: coder not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(ScoreCell.self, forCellWithReuseIdentifier: ScoreCell.reuseID)
        collectionView.dataSource = self
    }
    
    private func setupObservers() {
        viewModel.$scores
            .receive(on: DispatchQueue.main)
            .sink { [weak self] scores in
                self?.collectionView.reloadData()
                if scores.isEmpty {
                    self?.title = "No scores available"
                } else {
                    self?.title = "Scores"
                }
            }
            .store(in: &observers)
    }
    
}

// MARK: - CollectionView Datasource
extension SchoolVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.scores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let scoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: ScoreCell.reuseID, for: indexPath) as! ScoreCell
        if let score = viewModel.scores[safe: indexPath.item] {
            scoreCell.viewModel = ScoreCellViewModel(score: score)
        }
        return scoreCell
    }
    
}
