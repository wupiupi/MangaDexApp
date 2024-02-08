//
//  MangaListViewController.swift
//  MangaDexApp
//
//  Created by Paul Makey on 29.01.24.
//

import UIKit

final class MangaListViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var mangaList: [MangaInfo] = []
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        activityIndicator.color = .systemCyan
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        fetchData()
    }
    
    // MARK: - Navigaion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as? MangaDetailsViewController
        guard let mangaIndex = tableView.indexPathForSelectedRow?.row else { return }
        detailsVC?.manga = mangaList[mangaIndex]
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mangaList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mangaTitleCell", for: indexPath)
        let manga = mangaList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = manga.attributes.title.en
        content.textProperties.color = .white
        content.textProperties.font = .boldSystemFont(ofSize: 17)

        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Networking
private extension MangaListViewController {
    func fetchData() {
        networkManager.fetchData(from: Link.mangaList.url) { [unowned self] result in
            switch result {
                case .success(let mangaList):
                    self.mangaList = mangaList
                    tableView.reloadData()
                    activityIndicator.stopAnimating()
                case .failure(let error):
                    print(error)
            }
        }
    }
}
