//
//  PrivacyPromiseStore.swift
//  MindFlo
//
//  Created by Adit Gupta on 15/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
class PrivacyPromiseStore {
    let allPromises = [
        PrivacyPromise(title: "", bulletPoints: [""]),
        PrivacyPromise(title: "You own your data", bulletPoints: [
            "We securely sync all your Mindflo data only on your private iCloud storage. We keep no backups or copies on our servers.",
            "All data that you add, edit and delete from one device will be synced permanently to iCloud and cannot be reversed.",
            "This means ONLY you have control of your data through your Apple iCloud account."
        ]),
       
        PrivacyPromise(title: "No accounts, emails, & PIIs", bulletPoints: [
            "We save no Personally Identifiable Information(PII), nor do we identify you with an account/email. We believe that this data is a huge responsibility that apps take lightly. We hate email spam too.",
            "Mindflo is only linked to your iCloud account. Frankly, we don’t need anything else to keep your data safe."
        ]),
        
        PrivacyPromise(title: "Full transparency", bulletPoints: [
            "We are commited to logging only what we absolutely need to improve this app. To that end, we use Firebase to log crash reports, anonymous  feature usage reports, and button taps.",
            "We NEVER track or save any of your personal journal data, mood, text or images. We think that’s a massive breach of your privacy."
        ]),
        
        PrivacyPromise(title: "Ad-free, forever", bulletPoints: [
            "We will never monetize your attention or clicks. Mindflo is a deeply private experience which will always be beyond the prying eyes of advertisers"
        ])
        
    ]
}
struct PrivacyPromise {
    var title = ""
    var bulletPoints = [""]
}
