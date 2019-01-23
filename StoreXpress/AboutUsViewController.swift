//
//  AboutUsViewController.swift
//  StoreXpress
//
//  Created by Rana on 22/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit
import  MapKit


class AboutUsViewController: BaseViewController {

    @IBOutlet weak var MapView: MKMapView!

let initialLocation = CLLocation(latitude: 24.828238, longitude: 67.035551)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerMapOnLocation(location: initialLocation)

        // Do any additional setup after loading the view.
    }
    
let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        MapView.setRegion(coordinateRegion, animated: true)
    
        let artwork = Artwork(title: "Aga's SuperMarket ",
                              locationName: "Aga's SuperMarket",
                              discipline: "Market",
                              coordinate: CLLocationCoordinate2D(latitude: 24.828238, longitude: 67.035551))
        MapView.addAnnotation(artwork)
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
