//
//  MangaDetailsViewController.swift
//  MangaDexApp
//
//  Created by Paul Makey on 3.02.24.
//

import UIKit

final class MangaDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var mangaCover: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Properties
    var manga: MangaInfo?
    private let networkManager = NetworkManager.shared
    private var imageCoverURL = "https://uploads.mangadex.org/covers/"
    private var coverFileName = ""
    private var coverIDURl = "https://api.mangadex.org/cover/"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        
        titleLabel.text = manga?.attributes.title.en
        descriptionLabel.text = manga?.attributes.description?.en
        getCoverID()
    }
}

// MARK: - Private Methods
private extension MangaDetailsViewController {
    func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
    }
}

// MARK: - Networking
private extension MangaDetailsViewController {
    func getCoverID() {
        coverIDURl += manga?.getCoverID() ?? ""
        
        networkManager.fetchCoverID(from: coverIDURl) { [unowned self] result in
            switch result {
                case .success(let coverName):
                    imageCoverURL += manga?.id ?? ""
                    imageCoverURL += "/\(coverName)"
                    fetchImage(with: imageCoverURL)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func fetchImage(with url: String) {
        networkManager.fetchImage(from: url) { [unowned self] result in
            switch result {
                case .success(let data):
                    mangaCover.image = UIImage(data: data)
                    activityIndicator.stopAnimating()
                case .failure(let error):
                    print(error)
            }
        }
    }
}
