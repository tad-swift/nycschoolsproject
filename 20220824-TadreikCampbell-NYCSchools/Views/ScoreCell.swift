//
//  ScoreCell.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import UIKit
import Combine

class ScoreCell: UICollectionViewCell {
    
    static let reuseID = "score-cell-id"
    
    private let writingLbl: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let mathLbl: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let readingLbl: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var viewModel: ScoreCellViewModel! {
        didSet {
            setupObservers()
        }
    }
    private(set) var observers: Set<AnyCancellable> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemGroupedBackground
        contentView.addSubviews(readingLbl, writingLbl, mathLbl)
        NSLayoutConstraint.activate([
            readingLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            readingLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            readingLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            writingLbl.topAnchor.constraint(equalTo: readingLbl.bottomAnchor, constant: 8),
            writingLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            writingLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            mathLbl.topAnchor.constraint(equalTo: writingLbl.bottomAnchor, constant: 8),
            mathLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mathLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mathLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupObservers() {
        viewModel.$reading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.readingLbl.text = "Reading: \($0)"
            }
            .store(in: &observers)
        viewModel.$writing
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.writingLbl.text = "Writing: \($0)"
            }
            .store(in: &observers)
        viewModel.$math
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.mathLbl.text = "Math: \($0)"
            }
            .store(in: &observers)
    }
    
}
