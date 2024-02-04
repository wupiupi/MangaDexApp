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
    private var imageCover = "https://uploads.mangadex.org/covers/"
    private var coverFileName = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        
        titleLabel.text = manga?.attributes.title.en
        descriptionLabel.text = manga?.attributes.description?.en
        
        fetchData()
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
    func fetchData() {
        
        guard let mangaCoverID = manga?.getCoverID() else { return }
        let coverURL = URL(string: "https://api.mangadex.org/cover/\(mangaCoverID)")!
        
        networkManager.fetch(Cover.self, from: coverURL) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let cover):
                    coverFileName = cover.data.attributes.fileName
                    imageCover += manga?.id ?? ""
                    imageCover += "/\(coverFileName)"
                    setupImage(with: URL(string: imageCover)!)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func setupImage(with imageURL: URL) {
        networkManager.fetchImage(from: imageURL) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let imageData):
                    mangaCover.image = UIImage(data: imageData)
                    activityIndicator.stopAnimating()
                case .failure(let error):
                    print(error)
            }
        }
    }
}
