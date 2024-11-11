//
//  ViewController.swift
//  HW41
//
//  Created by Максим Громов on 09.11.2024.
//

import UIKit
import SnapKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {
    lazy var map = MKMapView()
    let locationManager = CLLocationManager()
    lazy var showMeButton = UIButton()
    lazy var label = UILabel()
    var location: CLLocation?
    
    let sightseeings = [
        (CLLocation(latitude: 59.939864, longitude:  30.314566), "Эрмитаж"),
        (CLLocation(latitude: 59.938996, longitude: 30.315482), "Дворцовая площадь"),
        (CLLocation(latitude: 59.948861, longitude: 30.394809), "Смольный собор"),
        (CLLocation(latitude: 59.94405, longitude: 30.33182), "Марсово поле"),
        (CLLocation(latitude: 59.94085, longitude: 30.30848), "Дворцовый мост")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(map)
        map.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        map.showsUserLocation = true
        let loc = CLLocationCoordinate2D(latitude: -59.57, longitude: 30.19)
        let coordinateRegion = MKCoordinateRegion(
            center: loc,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        map.setRegion(coordinateRegion, animated: true)
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
        for sightseeing in sightseeings {
            let point = MKPointAnnotation()
            point.coordinate = sightseeing.0.coordinate
            point.title = sightseeing.1
            map.addAnnotation(point)
        }
        
        
        view.addSubview(showMeButton)
        showMeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(80)
        }
        showMeButton.backgroundColor = .systemGray3
        showMeButton.layer.cornerRadius = 20
        showMeButton.layer.shadowOffset = .init(width: 2, height: 2)
        showMeButton.layer.shadowColor = UIColor.black.cgColor
        showMeButton.layer.shadowOpacity = 0.5
        showMeButton.addTarget(self, action: #selector(showMeButtonPressed), for: .touchUpInside)
        showMeButton.setTitle("Show me", for: .normal)
        showMeButton.titleLabel?.font = .boldSystemFont(ofSize: 34)
        
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        label.text = "Hello"
        label.textColor = .systemTeal
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        label.layer.shadowOffset = .init(width: 2, height: 2)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.5
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations[0]
    }

    
    @objc func showMeButtonPressed(){
        guard let location else {
            label.text = "Allow location"
            return
        }
        label.text = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 100,
            longitudinalMeters: 100
        )
        map.setRegion(coordinateRegion, animated: true)
    }
    
}

#Preview{
    ViewController()
}
