//
//  BusinessMapView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/2/22.
//

import SwiftUI
import MapKit

struct BusinessMapView: UIViewRepresentable {
    @EnvironmentObject var contentModel: ContentModel
    
    var locations: [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        for business in contentModel.restaurants + contentModel.sights {
            if let latitude = business.coordinates?.latitude, let longitude = business.coordinates?.longitude {
                let pointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = CLLocationCoordinate2D(
                    latitude: latitude,
                    longitude: longitude
                )
                pointAnnotation.title = business.name ?? ""
                
                annotations.append(pointAnnotation)
            }
        }
        
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // Show user on map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // Remove all annotations we don't need
        mapView.removeAnnotations(mapView.annotations)
        
        // Re-add the relevant annotations to our app
        mapView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ mapView: MKMapView, coordinator: ()) {
        mapView.removeAnnotations(mapView.annotations)
    }
}
