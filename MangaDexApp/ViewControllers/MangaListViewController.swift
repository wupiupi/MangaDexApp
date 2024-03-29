//
//  MangaListViewController.swift
//  MangaDexApp
//
//  Created by Paul Makey on 29.01.24.
//

import UIKit

final class MangaListViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var mangaList: MangaList?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        fetchData()
    }
    
    // MARK: - Navigaion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as? MangaDetailsViewController
        guard let mangaIndex = tableView.indexPathForSelectedRow?.row else { return }
        detailsVC?.manga = mangaList?.data[mangaIndex]
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mangaList?.data.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mangaTitleCell", for: indexPath)
        let manga = mangaList?.data[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = manga?.attributes.title.en ?? "No title"
        content.textProperties.color = .white
        content.textProperties.font = .boldSystemFont(ofSize: 17)

        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Networking
private extension MangaListViewController {
    func fetchData() {
        networkManager.fetch(MangaList.self, from: Link.mangaList.url) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let mangaList):
                    self.mangaList = mangaList
                    tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
}
