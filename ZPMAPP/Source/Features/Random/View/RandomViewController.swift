//
//  RandomViewController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 25/08/21.
//

import UIKit

class RandomViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var objectView: UIView!
    
    @IBOutlet private var headerView: UIView!
    
    @IBOutlet private var chooseGenreTextField: UITextField!
    
    @IBOutlet private var chooseNoteTextField: UITextField!
    
    @IBOutlet private var goButton: UIButton!
    
    @IBOutlet private var genreButton: UIButton!
    
    @IBOutlet private var noteButton: UIButton!
    
    // MARK: - Private Properties
    
    private var selectedGenre: Bool = false
    
    private var selectedNote: Bool = false
    
    // MARK: - Public Properties
    
    let randomController = RandomController()
    
    var sortedMovie: Movie?
    
    var genre: String?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoginIfNeeded()
        self.setupUI()
        self.setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoginIfNeeded()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        headerView.roundCorners(cornerRadius: 8.0, typeCorners: [.topLeft, .topRight])
        goButton.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
        objectView.roundCorners(cornerRadius: 8.0, typeCorners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
    }

    @IBAction private func sortedMovie(_ sender: UIButton) {
        guard let genre = genre else { return }
        randomController.fetchRandomList(genreSelected: genre) { success in
            switch success {
                case true:
                    self.proceedToSuggestion()
                case false:
                    self.showMessage(title: "Não conseguimos encontrar nenhuma recomendação", message: "Altere o genêro ou nota para realizar uma nova busca")
            }

        }
    }
    
    private func setupActions() {
        chooseGenreTextField.attributedPlaceholder = NSAttributedString(string: "   Escolha um gênero", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        chooseNoteTextField.attributedPlaceholder = NSAttributedString(string: "   Escolha uma nota mínima", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        chooseGenreTextField.isUserInteractionEnabled = false
        chooseNoteTextField.isUserInteractionEnabled = false
        
        genreButton.addTarget(self, action: #selector(didSelectedGenreField), for: .touchUpInside)
        noteButton.addTarget(self, action: #selector(didSelectedNoteField), for: .touchUpInside)
        
        randomController.delegate = self
    }
    
    @objc
    private func didSelectedGenreField() {
        selectedGenre = true
        
        let picker = ZPPickerBuilder()
            .set(delegate: self)
            .set(title: "Genêros")
            .set(pickerData: randomController.pickerDataGenre)
            .set(confirmLabel: "Selecionar")
            .set(cancelLabel: "Cancelar")
            .build()

        present(picker, animated: true)
    }
    
    @objc
    private func didSelectedNoteField() {
        selectedNote = true
        
        let picker = ZPPickerBuilder()
            .set(delegate: self)
            .set(title: "Nota mínima - TMDB")
            .set(pickerData: randomController.pickerDataNote)
            .set(confirmLabel: "Selecionar")
            .set(cancelLabel: "Cancelar")
            .build()

        present(picker, animated: true)
    }
    
    private func set(genreField withGenre: String?) {
        chooseGenreTextField.text = withGenre
    }
    
    private func set(noteField withNote: String?) {
        chooseNoteTextField.text = withNote
    }
    
    private func proceedToSuggestion() {
        let identifier = "SuggestionViewController"
        let randomController = UIStoryboard(name: "Random", bundle: nil)
        guard let viewController = randomController.instantiateViewController(identifier: identifier)
                as? SuggestionViewController else { return }


        switch checkIfSortedMovieHasValue() {
        case true:
            viewController.sortedMovie = sortedMovie
            viewController.controllerSuggestion.movie = sortedMovie
            present(viewController, animated: true)
        case false:
            self.showMessage(title: "Ops", message: "Não conseguimos encontrar nenhuma recomendação")
        }
    }

    private func checkIfSortedMovieHasValue() -> Bool {
        return sortedMovie != nil
    }
    
    private func showLoginIfNeeded() {
        if self.randomController.userIsLogged() {
            return
        }
        proceedToLogin()
    }
    
    private func proceedToLogin() {
        let identifier = String(describing: LoginViewController.self)
        let homeController = UIStoryboard(name: "Login", bundle: nil)
        guard let viewController = homeController.instantiateViewController(identifier: identifier)
                as? LoginViewController else { return }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present(navigationController, animated: true)
    }
}

extension RandomViewController: ZPPickerDelegate {
    
    func didSelectPicker(atRow row: Int, withKey key: String) {
        
        if selectedGenre {
            selectedGenre.toggle()
            
            let genre = randomController.pickerDataGenre[row]
            set(genreField: genre)
            self.genre = genre
        }
        
        if selectedNote {
            selectedNote.toggle()
            
            let note = randomController.pickerDataNote[row]
            set(noteField: note)
            randomController.get(note: note)
        }
    }
}

extension RandomViewController: RandomControllerProtocol {
    func failure(error: String) {
        self.showMessage(title: "Erro", message: error)
    }
    
    
    func get(sortedMovie: Movie?) {
        self.sortedMovie = sortedMovie
    }
}
