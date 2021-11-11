//
//  ListMoviesTableViewCell.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 05/10/21.
//

import UIKit

protocol ListMoviesTableViewCellProtocol: AnyObject {
    func proceedToMovie(myMovie: MyMovie)
}

class ListMoviesTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: ListMoviesTableViewCell.self)
    private var customer: Customer?
    private var myMovie: [MyMovie]? = []
    
    var delegate: ListMoviesTableViewCellProtocol?
    
    // MARK: - UILabel

    @IBOutlet weak var titleLabel: UILabel!
    
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
        EmptyCollectionViewCell.registerOn(self.moviesCollectionView)
    }
    
    func setup(customer: Customer?, myMovies: [MyMovie]?) {
        self.myMovie = myMovies
        self.customer = customer
        self.setTitle()
        moviesCollectionView.reloadData()
    }
    
    func setTitle() {
        guard let _myMovies = self.myMovie else { return }
        
        if !_myMovies.isEmpty {
            self.titleLabel.text = "Meus Filmes"
        }
    }
    
    func getEmptyCell(indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = EmptyCollectionViewCell.identifier
        let emptyCell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? EmptyCollectionViewCell

        emptyCell?.setup(title: "Opss", description: "Você ainda não adicionou tags para o controle de seus filmes clique em 'Assitir, Assistido ou Assistindo' nos detalhes dos filmes desejados")

        return emptyCell ?? UICollectionViewCell()
    }
    
    func getMovieCell(indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = MovieCollectionViewCell.identifier
        let movieCell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCollectionViewCell
        
        if let movie = self.myMovie?[indexPath.row].movie,
           let tag = self.myMovie?[indexPath.row].tag,
           let customer = self.customer {
            movieCell?.setup(customer: customer, movie: movie, tag: tag)
        }
        
        return movieCell ?? UICollectionViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ListMoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _myMovie = self.myMovie else { return 1 }
        return _myMovie.isEmpty ? 1 : _myMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let _myMovie = self.myMovie else {
            return self.getEmptyCell(indexPath: indexPath)
        }

        if _myMovie.isEmpty {
            return self.getEmptyCell(indexPath: indexPath)
        }
        
        return self.getMovieCell(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _myMovie = self.myMovie {
            self.delegate?.proceedToMovie(myMovie: _myMovie[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let normalSize = CGSize(width: 162, height: 247)
        guard let _myMovie = self.myMovie else { return normalSize }
        
        if _myMovie.isEmpty {
            return CGSize(width: 320, height: 420)
        }
        
        return normalSize
    }
}
