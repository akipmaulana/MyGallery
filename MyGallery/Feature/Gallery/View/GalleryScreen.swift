//
//  GalleryScreen.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import SwiftUI

struct GalleryScreen: View {
    
    @StateObject private var viewModel = GalleryViewModel()
    
    @State private var searchText: String = ""
    
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
                VStack {
                    Image(systemName: "network.slash")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red.opacity(0.6))
                        .frame(height: 100)
                        .padding(.bottom, 16)
                    
                    Text("No artwork available at the moment")
                        .font(.title3)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                    
                    Text(error.localizedDescription)
                        .multilineTextAlignment(.center)
                }
            case .empty:
                VStack {
                    Image(systemName: "xmark.icloud")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red.opacity(0.6))
                        .frame(height: 100)
                        .padding(.bottom, 16)
                    
                    Text("No artwork available at the moment")
                        .font(.title3)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                    
                    Text("Please try again later. It might be not listed in our database")
                        .multilineTextAlignment(.center)
                }
            }
        }
        
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
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField(
                    "Type your search here",
                    text: $searchText
                )
                .foregroundColor(Color.black)
                .font(.title3)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .onSubmit {
                    Task {
                        await viewModel.searchGallery(query: searchText)
                    }
                }
                .submitLabel(.done)
            }
            .padding()
            .overlay(
                RoundedRectangle(
                    cornerRadius: 10
                )
                .stroke(
                    lineWidth: 1
                )
                .foregroundColor(Color.gray.opacity(0.6))
            )
            .padding()
            
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
            .refreshable {
                Task {
                    await viewModel.searchGallery(query: searchText)
                }
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
