//
//  DashedDividerView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/15/22.
//

import SwiftUI

struct DashedDividerView: View {
    var body: some View {
        GeometryReader { geo in
            Path { path in
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: geo.size.width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(.gray)
        }
        .frame(height: 1) // geo was consuming too much whitespace. This takes care of it.
    }
}

struct DashedDividerView_Previews: PreviewProvider {
    static var previews: some View {
        DashedDividerView()
    }
}
