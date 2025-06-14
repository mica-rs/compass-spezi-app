//
// This source file is part of the CompassSpeziApp based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Foundation
import SpeziAccount
import SpeziContact
import SwiftUI


/// Displays the contacts for the CompassSpeziApp.
struct Contacts: View {
    let contacts = [
        Contact(
            name: PersonNameComponents(
                givenName: "Leland",
                familyName: "Stanford"
            ),
            image: Image(systemName: "figure.wave.circle"), // swiftlint:disable:this accessibility_label_for_image
            title: "University Founder",
            description: String(localized: "LELAND_STANFORD_BIO"),
            organization: "Stanford University",
            address: {
                let address = CNMutablePostalAddress()
                address.country = "USA"
                address.state = "CA"
                address.postalCode = "94305"
                address.city = "Stanford"
                address.street = "450 Serra Mall"
                return address
            }(),
            contactOptions: [
                .call("+1 (650) 723-2300"),
                .text("+1 (650) 723-2300"),
                .email(addresses: ["contact@stanford.edu"]),
                ContactOption(
                    image: Image(systemName: "safari.fill"), // swiftlint:disable:this accessibility_label_for_image
                    title: "Website",
                    action: {
                        if let url = URL(string: "https://stanford.edu") {
                            UIApplication.shared.open(url)
                        }
                    }
                )
            ]
        )
    ]

    @Environment(Account.self) private var account: Account?

    @Binding var presentingAccount: Bool
    
    
    var body: some View {
        NavigationStack {
            ContactsList(contacts: contacts)
                .navigationTitle("Contacts")
                .toolbar {
                    if account != nil {
                        AccountButton(isPresented: $presentingAccount)
                    }
                }
        }
    }
    
    
    init(presentingAccount: Binding<Bool>) {
        self._presentingAccount = presentingAccount
    }
}


#if DEBUG
#Preview {
    Contacts(presentingAccount: .constant(false))
}
#endif
