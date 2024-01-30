//
//  MangaListViewController.swift
//  MangaDexApp
//
//  Created by Paul Makey on 29.01.24.
//

import UIKit

final class MangaListViewController: UITableViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manga", for: indexPath)
        return cell
    }
}

// MARK: - Private Methods
private extension MangaListViewController {
    func fetchData() {
        let mangaList = URL(string: "https://api.mangadex.org/manga")!

        URLSession.shared.dataTask(with: mangaList) { data, _, error in
            guard let data else {
                print(error ?? "No error description")
                return
            }
            
            print(data)
            
            do {
                let data = try JSONDecoder().decode(Manga.self, from: data)
                print(data.data)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }

}
