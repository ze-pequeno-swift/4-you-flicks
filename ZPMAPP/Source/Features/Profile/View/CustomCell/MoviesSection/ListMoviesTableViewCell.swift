//
//  ListMoviesTableViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import UIKit

protocol ListMoviesTableViewCellProtocol: AnyObject {
    func proceedToMovie()
}

class ListMoviesTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: ListMoviesTableViewCell.self)
    private var customer: Customer?
    private var myMovie: [MyMovie]? = []
    
    var delegate: ListMoviesTableViewCellProtocol?
    
    // MARK: - CollectionView

    @IBOutlet weak private var moviesCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.roundCornersAll(cornerRadius: 10)
        
        MovieCollectionViewCell.registerOn(self.moviesCollectionView)
    }
    
    func setup(customer: Customer?, myMovies: [MyMovie]?) {
        self.myMovie = myMovies
        self.customer = customer
        moviesCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ListMoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myMovie?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = MovieCollectionViewCell.identifier
        let movieCell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCollectionViewCell
        
        if let movie = self.myMovie?[indexPath.row].movie,
           let tag = self.myMovie?[indexPath.row].tag,
           let customer = self.customer {
            movieCell?.setup(customer: customer, movie: movie, tag: tag)
        }
        
        return movieCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.proceedToMovie()
    }
}
