//
//  CollectionViewController.swift
//  PodKolesami
//
//  Created by Другов Родион on 04.12.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    private var category: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    private func loadCategory() {
        guard let url = URL(string: "https://lomiren.kz/intern/category") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }

            do {
                let categoryes = try JSONDecoder().decode(CategoryInformation.self, from: data)
                self.category = categoryes.data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error:",error.localizedDescription)
            }
        }.resume()
    }
    
    private func parsingImages(categoryes: Category, cell: CollectionViewCell) {
        if let ursString = URL(string: categoryes.image ?? "ошибка картинки") {
            if let imageData = try? Data(contentsOf: ursString) {
                cell.imageCVC.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        let categoryes = category[indexPath.row]
        
        parsingImages(categoryes: categoryes, cell: cell)
        
        cell.textLabel.text = categoryes.title
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toTableVC", sender: indexPath)
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let categoryDetail = segue.destination as? TableViewController {
            if let indexPath = sender as? IndexPath {
                let categor: Category
                categor = category[indexPath.row]
                categoryDetail.category = categor
            }
        }
    }
}
