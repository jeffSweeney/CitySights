//
//  BusinessDetailView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/30/21.
//

import SwiftUI

struct BusinessDetailView: View {
    var business: Business
    @State private var showDirectionsSheet = false
    
    var body: some View {
        VStack {
            // MARK: - Image and Open/Closed Tab
            VStack (spacing: 0) {
                GeometryReader { geo in
                    if let imageData = business.imageData {
                        let uiImage = UIImage(data: imageData)
                        Image(uiImage: uiImage ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                    }
                }
                
                ZStack (alignment: .leading) {
                    // Assuming if isClosed isn't defined, then it's open
                    let (label, color) = business.isClosed ?? false ? ("Closed", Color.gray) : ("Open", Color.blue)
                    
                    Rectangle()
                        .foregroundColor(color)
                        .frame(height: 36)
                    
                    Text(label)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading)
                }
            }
            .ignoresSafeArea()
            
            // MARK: - Business Title
            HStack {
                BusinessTitleView(business: business)
                
                Spacer()
                
                YelpLinkView(link: business.url ?? "")
            }
            .padding(.bottom, 10)
            
            DashedDividerView()
                .padding(.horizontal)
            
            Group {
                // MARK: - Phone
                BusinessDetailLinkView(
                    heading: "Phone",
                    headingValue: business.displayPhone ?? business.phone ?? "",
                    urlString: "tel:\(business.phone ?? "")",
                    linkString: "Call")
                
                DashedDividerView()
                    .padding(.horizontal)
                
                // MARK: - Reviews
                BusinessDetailLinkView(
                    heading: "Reviews",
                    headingValue: String(business.reviewCount ?? 0),
                    urlString: business.url ?? "",
                    linkString: "Read")
                
                DashedDividerView()
                    .padding(.horizontal)
                
                // MARK: - Website
                BusinessDetailLinkView(
                    heading: "Website",
                    headingValue: business.url ?? "",
                    urlString: business.url ?? "",
                    linkString: "Visit")
                
                DashedDividerView()
                    .padding(.horizontal)
            }
            
            // MARK: - Directions Button
            Button(action: {
                showDirectionsSheet = true
            }) {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding()
            .sheet(isPresented: $showDirectionsSheet) {
                DirectionsView(business: business)
            }
        }
    }
}
