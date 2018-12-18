//
//  ViewController.swift
//  UnsplashAPIZainy
//
//  Created by ZAINAB TAREEN on 11/12/18.
//  Copyright © 2018 ZAINY TAREEN. All rights reserved.
//

import UIKit

struct PlanetInfo: Decodable {
    let copyright: String?
    let date: String?
    let explanation: String
    let hdurl: String
    let media_type: String?
    let service_version: String
    let title: String
    let url: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var planetInfoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    @IBAction func planetInfowhenTapped(_ sender: Any) {
        parse()
    }
    
    // func planetInfoWhenTrapped(_ sender: Any){
        //  parse()
        //}
        func parse() {
            let jsonURLString = "https://api.nasa.gov/planetary/apod?api_key=TJz8ex0lbHUJM5ee2Z6jCBsHygLTN9zcJw9Fzgd8"
            guard let url = URL(string: jsonURLString) else {return}
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {return}
                do {
                    let planetInfo = try JSONDecoder().decode(PlanetInfo.self, from: data)
                    print(planetInfo.url)
                    let explanation = planetInfo.explanation
                    print(planetInfo.title)
                    print(planetInfo.url)
                    print(planetInfo.explanation)
                       let url = URL(string: planetInfo.url)
                    
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url!)
                      
                        DispatchQueue.main.async {
                            self.imageContainer.image = UIImage(data: data!)
                            
                    
                        }
                        
                    }
                    
                    
                } catch let jsonErr {
                    print("error serializing JSON", jsonErr)
                }
                }
                .resume()
        
        }
        

    
    
}










