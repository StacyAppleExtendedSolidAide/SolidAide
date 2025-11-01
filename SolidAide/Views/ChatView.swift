//
//  ChatView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData
import CoreLocation

struct ChatView: View {
    @Query private var profiles: [ProfileClass]
    @Query private var chats: [ChatClass]

    @State private var messageType = "Tous"
    @State private var searchMessages = ""
    let status = ["Tous", "Non Lus", "Favoris"]

    // Helper pour récupérer le profil courant (exemple “Marie D.”)
    private var currentProfile: ProfileClass? {
        profiles.first { $0.pseudo == "Marie D." }
    }

    // Filtrage selon le type de message
    private var filteredProfiles: [ProfileClass] {
        switch messageType {
        case "Tous":
            return profiles
        case "Non Lus":
            return profiles.filter { profile in
                guard let pid = profile.userId?.id else { return false }
                return chats.contains {
                    ($0.sender.id == pid || $0.recipient.id == pid) && !$0.isRead
                }
            }
        case "Favoris":
            guard let favIds = currentProfile?.favorite?.map({ $0.id }) else { return [] }
            return profiles.filter { profile in
                if let uid = profile.userId?.id {
                    return favIds.contains(uid)
                }
                return false
            }
        default:
            return profiles
        }
    }

    // Recherche texte
    private var displayedProfiles: [ProfileClass] {
        if searchMessages.isEmpty {
            return filteredProfiles
        } else {
            return filteredProfiles.filter {
                $0.pseudo.localizedCaseInsensitiveContains(searchMessages)
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Type", selection: $messageType) {
                    ForEach(status, id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)
                .padding()

                Divider()

                ScrollView {
                    ForEach(displayedProfiles, id: \.self) { contact in
                        // … ton UI de contact …
                    }
                }
            }
            .navigationTitle("Messagerie")
            .searchable(text: $searchMessages,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Rechercher un contact")
        }
    }
}
    

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: UserClass.self, ProfileClass.self, ChatClass.self, ServiceClass.self, TimeBankClass.self,
        configurations: config
    )
    let context = ModelContext(container)
    
    GenerateDataBaseFunc(context: context)
    
    return ChatView()
        .modelContainer(container)
}
