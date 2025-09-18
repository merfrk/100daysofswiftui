//
//  ContentView.swift
//  Snowseeker
//
//  Created by Omer on 17.09.2025.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    var filteredResorts: [Resort] {
        var list = resorts
        if !searchText.isEmpty {
            list = list.filter { $0.name.localizedStandardContains(searchText)}
        }
        switch sortType {
        case .none:
            return list
        case .name:
            return list.sorted { $0.name < $1.name }
        case .country:
            return list.sorted { $0.country < $1.country }
        }
    }
    @State private var favorites = Favorites()
    enum SortType: String, CaseIterable {
        case none, name, country
        var title: String {
            switch self {
            case .none: "Default"
            case .name: "Name"
            case .country: "Country"
            }
        }
    }
    @State private var sortType: SortType = .none
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar{
                Menu{
                    ForEach(SortType.allCases, id: \.self) { type in
                        Button {
                                   sortType = type
                               } label: {
                                   if sortType == type {
                                       Label(type.title, systemImage: "checkmark")
                                   } else {
                                       Text(type.title)
                                   }
                               }
                        }
                } label: {
                    HStack {
                            Image(systemName: "arrow.up.arrow.down")
                            Text("Sort: \(sortType.title)")
                        }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
