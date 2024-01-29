//
//  MainViewController.swift
//  MangaDexApp
//
//  Created by Paul Makey on 29.01.24.
//

import UIKit

final class MainViewController: UITableViewController {

    private let url = URL(string: "https://api.mangadex.org/manga")!
    
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

private extension MainViewController {
    func fetchData() {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error ?? "No error description")
                return
            }
            
            print(data)
            
            do {
                let data = try JSONDecoder().decode(Book.self, from: data)
                print(data)
            } catch {
                print(error.localizedDescription, error)
            }
            
        }.resume()
    }
}
