//
//  GalleryScreen.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import SwiftUI

struct GalleryScreen: View {
    
    @StateObject private var viewModel = GalleryViewModel()
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            switch viewModel.paginationState {
            case .isLoading:
                HStack(spacing: 8) {
                    Text("Fetching More")
                    ProgressView()
                }
            case .idle:
                Text("Avilable More")
            case .failure(let error):
                Text(error.localizedDescription)
            }
        }
        .frame(height: 50)
    }
    
    @ViewBuilder
    var gridContent: some View {
        ForEach(
            viewModel.artworks,
            id: \.id,
            content: { item in
                ThumbnailView(
                    artworkId: item.imageId
                )
                .onAppear {
                    Task {
                        await viewModel.loadMoreGallery(current: item)
                    }
                }
            }
        )
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(),
                        GridItem(),
                        GridItem(),
                    ],
                    content: {
                        gridContent
                    }
                )
                
                lastRowView
            }
        }
        .task {
            await viewModel.refreshGallery()
        }
        .navigationTitle("Artwork Gallery")
    }
}

#Preview {
    NavigationStack {
        GalleryScreen()
    }
    
}
