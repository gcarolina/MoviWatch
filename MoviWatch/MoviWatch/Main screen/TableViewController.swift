//
//  TableViewController.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import UIKit

class TableViewController: UITableViewController {

    var genres: FilterResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            fetchGenres()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchGenres()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genres?.genres?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let genre = genres?.genres?[indexPath.row]
        cell.textLabel?.text = genre?.genre
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    private func fetchGenres() {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/filters") else { return }
        var request = URLRequest(url: url)
        request.addValue("1bcbd78e-ca5b-4ba6-a840-e482764b60ef", forHTTPHeaderField: "X-API-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response status code")
                return
            }
            
            guard let data = data else { return }
            
            do {
                self?.genres = try JSONDecoder().decode(FilterResponse.self, from: data)
                print(self?.genres ?? "")
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            print("Response: \(String(data: data, encoding: .utf8)!)")
        }
        task.resume()
    }   
}
