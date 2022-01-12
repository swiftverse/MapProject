//
//  EditViewVM.swift
//  MapProject
//
//  Created by Amit Shrivastava on 12/01/22.
//

import Foundation
import SwiftUI
import MapKit

enum LoadingData {
    case loading, loaded, failed
}


extension EditView {
    @MainActor class EditViewVM: ObservableObject {
        @Published  var descriptionLocation: String
        @Published  var nameLocation: String
        @Published var loadingState = LoadingData.loaded
        @Published var pages = [Page]()
        
        
        init()  {
  
            _nameLocation = Published(initialValue: "")
            _descriptionLocation = Published(initialValue: "")
       
        }
  
    }
}
