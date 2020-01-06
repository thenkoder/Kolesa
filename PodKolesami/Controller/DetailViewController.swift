//
//  DetailViewController.swift
//  PodKolesami
//
//  Created by Другов Родион on 18.12.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageDVC: UIImageView!
    
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var firstParam: UILabel!
    @IBOutlet weak var firstDetailParam: UILabel!
    @IBOutlet weak var secondDetailParam: UILabel!
    @IBOutlet weak var secondParam: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    private var annousements: AnnoucementOnVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.text = ""
        firstParam.text = nil
        firstDetailParam.text = ""
        secondParam.text = ""
        secondDetailParam.text = ""
        textLabel.text = ""
        loadIndicator.startAnimating()
        
        loadAnnoucement()
    }
    
    // MARK: LoadAnnoucement for DetailViewController
    
    private func loadAnnoucement() {
        guard let url = URL(string: "https://lomiren.kz/intern/advert/2") else { return }
        
        URLSession.shared.dataTask(with: url) {
            [weak self]
            (data, response, error) in
            guard let data = data else { return }
            
            do {
                if let self = self {
                    let annousement = try JSONDecoder().decode(DetailAnnoucement.self, from: data)
                    self.annousements = annousement.data
                    
                    DispatchQueue.main.async {
                        self.loadViewForDetailViewController()
                    }
                }
            } catch {
                print("Error:",error.localizedDescription)
            }
        }.resume()
    }
    private func loadViewForDetailViewController() {
        self.loadIndicator.isHidden = true
        guard let annousement = self.annousements else { return }
        if let annousementParams = annousement.params {
            for dict in annousementParams {
                for (key, value) in dict {
                    if self.firstParam.text == nil {
                        self.firstParam.text = key
                        self.firstDetailParam.text = value
                    } else {
                        self.secondParam.text = key
                        self.secondDetailParam.text = value
                    }
                }
            }
        }
        if let annousementImage = annousement.image {
            if let image = try? Data(contentsOf: URL(string: annousementImage)!) {
                self.imageDVC.image = UIImage(data: image)
            }
        }
        self.titleText.text = annousement.title
        self.textLabel.text = annousement.description
        self.reloadInputViews()
    }
}
