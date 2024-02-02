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
    private let networkManager = NetworkManager.shared
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = manga?.attributes.title.en
        descriptionLabel.text = manga?.attributes.description?.en
        
        networkManager.fetchImage(from: Link.getCover.url) { [weak self] result in
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
