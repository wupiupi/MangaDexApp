//
//  MangaDetailsViewController.swift
//  MangaDexApp
//
//  Created by Paul Makey on 3.02.24.
//

import UIKit

final class MangaDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var mangaCover: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Properties
    var manga: MangaInfo?
    private var imageCover = "https://uploads.mangadex.org/covers/"
    private let networkManager = NetworkManager.shared
    private var coverFileName = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = manga?.attributes.title.en
        descriptionLabel.text = manga?.attributes.description?.en
        
        getData()
    }
}

// MARK: - Networking
private extension MangaDetailsViewController {
    func getData() {
        
        let mangaCoverID = manga?.relationships.filter({ $0.type == "cover_art" })
        guard let firstId = mangaCoverID?.first?.id else { return }
        
        let coverURL = URL(string: "https://api.mangadex.org/cover/\(firstId)")!
        
        networkManager.fetch(Cover.self, from: coverURL) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let cover):
                    coverFileName = cover.data.attributes.fileName
                    imageCover += manga?.id ?? ""
                    imageCover += "/\(coverFileName)"
                    print(imageCover)
                    setupImage(with: URL(string: imageCover)!)
                case .failure(let error):
                    print(error)
            }
        }
    }
}

// MARK: - Private Methods
private extension MangaDetailsViewController {
    func setupImage(with imageURL: URL) {
        networkManager.fetchImage(from: imageURL) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let imageData):
                    mangaCover.image = UIImage(data: imageData)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
