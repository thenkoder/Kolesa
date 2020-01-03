//
//  TableViewController.swift
//  PodKolesami
//
//  Created by Другов Родион on 08.12.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit

enum HeightForRow {
    static let height: CGFloat = 500
}

class TableViewController: UITableViewController {

    private var announcements: [DetailedInformation] = []
    
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        titleForTableViewController()
    }
    
    func titleForTableViewController() {
        if let titleInCategor = category {
            self.title = titleInCategor.title
        }
    }

    private func getJSON(urlPath: String?, tag: Int, completion: @escaping(Data, Int) -> ()) {
        guard let urlPath = urlPath else { return }
        guard let url = URL(string: urlPath) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data, tag)
                }
            }
        }.resume()
    }
    
    private func loadCategory() {
        guard let url = URL(string: "https://lomiren.kz/intern/category_adverts/1") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }

            do {
                let announcement = try JSONDecoder().decode(Announcement.self, from: data)
                self.announcements = announcement.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error:",error.localizedDescription)
            }
        }.resume()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeightForRow.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        let annoucement = announcements[indexPath.row]
        let tag = indexPath.row + 1
        cell.tag = tag
        
        cell.imageTV.image = UIImage(named: "preloader")
        getJSON(urlPath: annoucement.image, tag: tag) { data, tag in
            print("\(tag) \(cell.tag)")
            if cell.tag == tag {
                cell.imageTV.image = UIImage(data: data)
            } else {
                print("Fail!")
            }
        }
        
        cell.titleTV.text = annoucement.title
        cell.textTV.text = annoucement.description
        
        return cell
    }
}


