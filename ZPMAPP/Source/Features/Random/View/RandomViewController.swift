//
//  RandomViewController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 25/08/21.
//

import UIKit

protocol SelectedGenreMovie: AnyObject {
    func genreMovie(genre: String)
}

class RandomViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var objectView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var chooseGenreTextField: UITextField!
    
    @IBOutlet weak var chooseNoteTextField: UITextField!
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var genreButton: UIButton!
    
    @IBOutlet weak var noteButton: UIButton!
    
    let pickerData = ["Dramas", "Comédia", "Filmes para família", "Romance", "Ação", "Documentários", "Terror", "Fantasia", "Animes", "Musical", "Policial"]
    
    let pickerData2 = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    let randomController = RandomController()
    
    var selectedGenre: Bool = false
    
    var selectedNote: Bool = false
    
    var genre: String?
    
    weak var delegate: SelectedGenreMovie?
    
    var sortedMovie: Movie?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomController.delegate = self
        setupUI()
        setupActions()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        headerView.roundCorners(cornerRadius: 8.0, typeCorners: [.topLeft, .topRight])
        goButton.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
        objectView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
    }

    @IBAction private func sortedMovie(_ sender: UIButton) {
        guard let genre = genre else { return }
        
        showLoading()
        self.randomController.fetchRandomList(genreSelected: genre)
        hideLoading()
    
        print("PASSANDO FILME PARA RANDOM >> \(sortedMovie)")
        proceedToSuggestion()
    }
    
    private func setupActions() {
        chooseGenreTextField.attributedPlaceholder = NSAttributedString(string: "   Escolha um gênero", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        chooseNoteTextField.attributedPlaceholder = NSAttributedString(string: "   Escolha uma nota mínima", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        chooseGenreTextField.isUserInteractionEnabled = false
        chooseNoteTextField.isUserInteractionEnabled = false
        genreButton.addTarget(self, action: #selector(didSelectedGenreField), for: .touchUpInside)
        
        noteButton.addTarget(self, action: #selector(didSelectedNoteField), for: .touchUpInside)
    }
    
    @objc
    func didSelectedGenreField() {
        selectedGenre = true
        
        let picker = ZPPickerBuilder()
            .set(delegate: self)
            .set(title: "Genêros")
            .set(pickerData: pickerData)
            .set(confirmLabel: "Selecionar")
            .set(cancelLabel: "Cancelar")
            .build()

        self.present(picker, animated: true)
    }
    
    @objc
    func didSelectedNoteField() {
        selectedNote = true
        
        let picker = ZPPickerBuilder()
            .set(delegate: self)
            .set(title: "Nota mínima - TMDB")
            .set(pickerData: pickerData2)
            .set(confirmLabel: "Selecionar")
            .set(cancelLabel: "Cancelar")
            .build()

        self.present(picker, animated: true)
    }
    
    func set(genreField withGenre: String?) {
        chooseGenreTextField.text = withGenre
    }
    
    func set(noteField withNote: String?) {
        chooseNoteTextField.text = withNote
    }
    
    private func proceedToSuggestion() {
        let identifier = "SuggestionViewController"
        let randomController = UIStoryboard(name: "Random", bundle: nil)
        guard let viewController = randomController.instantiateViewController(identifier: identifier)
                as? SuggestionViewController else { return }
        
        viewController.sortedMovie = sortedMovie
        
        present(viewController, animated: true)
    }

}

extension RandomViewController: ZPPickerDelegate {
    
    func didSelectPicker(atRow row: Int, withKey key: String) {
        
        if selectedGenre {
            selectedGenre.toggle()
            
            let genre = pickerData[row]
            set(genreField: genre)
            self.genre = genre
//            delegate?.genreMovie(genre: genre)
            print("-- genero \(genre)")
        }
        
        if selectedNote {
            selectedNote.toggle()
            
            let note = pickerData2[row]
            set(noteField: note)
            randomController.get(note: note)
            print("-- nota \(note)")
        }
    }
}

extension RandomViewController: RandomControllerProtocol {
    func get(sortedMovie: Movie?) {
        self.sortedMovie = sortedMovie
    }
}
