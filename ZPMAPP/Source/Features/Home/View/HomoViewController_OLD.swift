////
////  HomeViewController.swift
////  ZPMAPP
////
////  Created by Hellen on 22/08/21.
////
//
//import UIKit
//
//
//class HomeViewController_old: UIViewController {
//    
//    let path: [LayoutSectionItemsTuple] = [
//        ("trending/all/week", .topTrending),
//        ("movie/top_rated",   .popularMovies)
//    ]
//
//    // MARK: - IBOutlets
//    
//    @IBOutlet private var tableView: UITableView!
//    
//    // MARK: - View Lifecycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        showLoginIfNeeded()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setupNavigationBar()
//    }
//    
//    // MARK: - Private Functions
//    
//    private func showLoginIfNeeded() {
//        guard userIsLogged() else {
//            return
//            
//        }
//        proceedToLogin()
//    }
//    
//    private func userIsLogged() -> Bool {
//        return true
//    }
//    
//    private func setupNavigationBar() {
//        navigationController?.navigationBar.navigationStyle()
//    }
//    
//    private func setupUI() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        DailyTrendingsCell.registerOn(tableView)
//        TopCustomCell.registerOn(tableView)
//    }
//    
//    private func getMoviesTheatersCellCell() -> UITableViewCell {
//        let identifier = DailyTrendingsCell.identifier
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//                as? DailyTrendingsCell else { return UITableViewCell() }
//        
//        cell.delegate = self
//        
//        return cell
//    }
//    
//    private func getTopPopularMoviesCustomCell() -> UITableViewCell {
//        let identifier = TopCustomCell.identifier
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//                as? TopCustomCell else { return UITableViewCell() }
//        
//        cell.delegate = self
//        
//        return cell
//    }
//    
//    private func getTopPopularSeriesCustomCell() -> UITableViewCell {
//        let identifier = TopCustomCell.identifier
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//                as? TopCustomCell else { return UITableViewCell() }
//        
//        cell.delegate = self
//        
//        return cell
//    }
//    
//    private func getTopDramaCustomCell() -> UITableViewCell {
//        let identifier = TopCustomCell.identifier
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//                as? TopCustomCell else { return UITableViewCell() }
//        
//        cell.delegate = self
//        
//        return cell
//    }
//    
//    private func getTopComedyCustomCell() -> UITableViewCell {
//        let identifier = TopCustomCell.identifier
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//                as? TopCustomCell else { return UITableViewCell() }
//        
//        cell.delegate = self
//        
//        return cell
//    }
//    
//    private func getTopTerrorCustomCell() -> UITableViewCell {
//        let identifier = TopCustomCell.identifier
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//                as? TopCustomCell else { return UITableViewCell() }
//        
//        cell.delegate = self
//        
//        return cell
//    }
//    
//    private func getTopDocumentariesCustomCell() -> UITableViewCell {
//        let identifier = TopCustomCell.identifier
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//                as? TopCustomCell else { return UITableViewCell() }
//        
//        cell.delegate = self
//        
//        return cell
//    }
//    
//    private func getTopAdventureCustomCell() -> UITableViewCell {
//        let identifier = TopCustomCell.identifier
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//                as? TopCustomCell else { return UITableViewCell() }
//        
//        cell.delegate = self
//        
//        return cell
//    }
//    
//    private func getTopRomanceCustomCell() -> UITableViewCell {
//        let identifier = TopCustomCell.identifier
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//                as? TopCustomCell else { return UITableViewCell() }
//        
//        cell.delegate = self
//        
//        return cell
//    }
//    
//    private func proceedToMoviesDetails() {
//        let homeController = UIStoryboard(name: "Home", bundle: nil)
//        guard let viewController = homeController.instantiateViewController(identifier: "MovieDetailsViewController")
//                as? MovieDetailsViewController else { return }
//        
//        navigationController?.pushViewController(viewController, animated: true)
//    }
//    
//    private func proceedToLogin() {
//        let homeController = UIStoryboard(name: "Login", bundle: nil)
//        guard let viewController = homeController.instantiateViewController(identifier: "LoginViewController")
//                as? LoginViewController else { return }
//        
//        let navigationController = UINavigationController(rootViewController: viewController)
//        
//        present(navigationController, animated: true)
//    }
//    
//    private func setupSectionHeader(section: Int) -> UIView {
//        let titleSection = ["Destaques diários", "Top 20 filmes populares", "Top 20 séries populares", "Dramático", "Rir é o melhor remédio", "Não apague as luzes", "Documentários surpreendentes", "Para se aventurar", "Hora do romance"]
//        
//        let sectionHeader = UIView.init(frame:
//                                            CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        
//        let sectionText = UILabel()
//        sectionText.frame = CGRect.init(x: 16, y: 15, width: sectionHeader.frame.width-10,
//                                        height: sectionHeader.frame.height-10)
//        
//        sectionText.text = titleSection[section]
//        sectionText.font = .systemFont(ofSize: 18, weight: .bold)
//        sectionText.textColor = .white
//        
//        sectionHeader.addSubview(sectionText)
//        
//        return sectionHeader
//    }
//}
//
//// MARK: - UITableView Protocol Extensions
//
//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    typealias LayoutSectionItemsTuple = (apiPah: String, layout: HomeSection)
//    
//    enum HomeSection: Int, CaseIterable {
//        case topTrending
//        case popularMovies
//        case popularSeries
//        case drama
//        case comedy
//        case terror
//        case documentaries
//        case adventure
//        case romance
//        
//        func getSection() {
//            
//        }
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return HomeSection.allCases.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        //Implementar códgio para identificar a section e saber o identifier.
//        let cell: DailyTrendingsCell? = tableView.dequeueReusableCell(withIdentifier: "DailyTrendingsCell", for: indexPath) as? DailyTrendingsCell
//        
//        return cell ?? UITableViewCell()
//    
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        setupSectionHeader(section: section)
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//    
//    //Implementar código para inserir o header da table view.
//    
//}
//
//// MARK: - HomeViewControllerDelegate Extensions
//
//extension HomeViewController: HomeViewControllerDelegate {
//    
//    func tappedCell() {
//        proceedToMoviesDetails()
//    }
//}
