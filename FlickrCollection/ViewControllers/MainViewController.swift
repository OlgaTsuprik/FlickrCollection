//
//  MainViewController.swift
//  FlickrCollection
//
//  Created by Оля on 22.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: Priperties
    var collectionArray = [Photo]()
    var layoutType: LayoutType = .grid
    var requiredURL: String?
    
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedPhotoSegue" {
            let photoVC = segue.destination as! DetailedViewController
            _ = sender as! CustomCollectionCell
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                //print("\(self.collectionArray[indexPath.row].urlZ)")
                photoVC.descriptionOfPhoto = self.collectionArray[indexPath.row].title
                photoVC.photoURL = self.collectionArray[indexPath.row].urlZ
            }
        }
    }
    
    func fetchData() {
        let headers = [
            //"auth_token": "72157718999765219-63c5e7c8f01b2fb2",
            //"api_sig": "66fd317fd254546d6d715cfe9680c8ca",
            "api-key": "e2fb2c1641e3c15013517588f9728525"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://www.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=e2fb2c1641e3c15013517588f9728525&date=&extras=url_q%2C+url_z&format=json&nojsoncallback=1")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let allData = try JSONDecoder().decode(Welcome.self, from: data)
                    self.collectionArray = allData.photos.photo
                    //print(self.collectionArray)
                    self.collectionView.reloadData()
                } catch let error {
                    print("Error serialization", error)
                }
            }
        }.resume()
    }
    
    func confCell(cell: CustomCollectionCell, for indexPath: IndexPath) {
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: self.collectionArray[indexPath.row].urlZ) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                cell.image.image = UIImage(data: imageData)
            }
        }
    }
    
    //MARK: IB Actions
    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        self.layoutType = LayoutType(rawValue: sender.selectedSegmentIndex) ?? .grid
        collectionView.reloadData()
    }
}

//MARK: Extensions
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionCell
        confCell(cell: cell, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView = UICollectionReusableView()
        reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Search", for: indexPath)
        
        return reusableView
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    enum LayoutType: Int {
        case grid
        case list
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if layoutType == .grid {
            let photoWidth = collectionView.bounds.width / 3 - 5
            return CGSize(width: photoWidth, height: photoWidth)
        } else {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
        }
    }
}
