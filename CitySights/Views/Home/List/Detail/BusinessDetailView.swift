//
//  BusinessDetailView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/30/21.
//

import SwiftUI

struct BusinessDetailView: View {
    var business: Business
    
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
            
            // MARK: - Name, Location, Rating
            HStack {
                VStack (alignment: .leading) {
                    // Fixed size prevents long business names from abbreviating
                    Text(business.name ?? "Name Unavailable")
                        .font(.largeTitle)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    if let displayAddress = business.location?.displayAddress {
                        ForEach(displayAddress, id: \.self) { line in
                            Text(line)
                                .bold()
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                    }
                    
                    if let rating = business.rating {
                        Image("regular_\(rating)")
                            .padding(.horizontal)
                    }
                }
                
                Spacer()
                
                Text("Yelp!")
                    .padding(.horizontal)
            }
            
            Divider()
            
            Group {
                // MARK: - Phone
                BusinessDetailLinkView(
                    heading: "Phone",
                    headingValue: business.displayPhone ?? business.phone ?? "",
                    urlString: "tel:\(business.phone ?? "")",
                    linkString: "Call")
                
                Divider()
                
                // MARK: - Reviews
                BusinessDetailLinkView(
                    heading: "Reviews",
                    headingValue: String(business.reviewCount ?? 0),
                    urlString: business.url ?? "",
                    linkString: "Read")
                
                Divider()
                
                // MARK: - Website
                BusinessDetailLinkView(
                    heading: "Website",
                    headingValue: business.url ?? "",
                    urlString: business.url ?? "",
                    linkString: "Visit")
                
                Divider()
            }
            
            // MARK: - Directions Button
            Button(action: {
                // TODO: Implement
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
        }
    }
}
