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

        // Setting to the context coordinator allows the system to dictate which
        // coordinator needs to be used
        mapView.delegate = context.coordinator
        
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
    
    // MARK: - Coordinator
    
    // Given in the UIViewRepresentable protocol for delegate-protocol pattern
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    // Required class to assign instance as delegate to MKMapView
    internal class Coordinator: NSObject, MKMapViewDelegate {
        // This is displayed above the pin on the MapView
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // User location is treated as an annotation. Don't want this displayed like the businesses
            if annotation is MKUserLocation {
                return nil
            }
            
            // Alright to set as an explicit unwrap - will always be set after the if/else below
            var annotationView: MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.ReuseIdentifier)
            
            if let annotationView = annotationView {
                annotationView.annotation = annotation
            } else {
                // This will display balloon-shaped marker at the location on the map
                // NOTE: The reuseIdentifier allows this annotation view to be reused when scrolled out of screen,
                //          rather than creating a new instance in memory for a new marker. See the initial declaration
                //          above where we try to grab a reuse annotation view first.
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.ReuseIdentifier)
                
                // Make the annotation view tapable - used to display the business details.
                annotationView.canShowCallout = true
                // TODO: Handle the button tap
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            
            return annotationView
        }
    }
}
