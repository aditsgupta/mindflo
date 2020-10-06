//
//  MFProUpgrade.swift
//  MindFlo
//
//  Created by Adit Gupta on 21/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
import SwiftyStoreKit
import StoreKit
import SwiftUIVisualEffects

enum RegisteredPurchase: String {
    case yearlyPro = "MfYearlyPro20"
    //add more IAPs here
}

struct MFProUpgrade: View {
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertDescription = ""
    @State private var alertButtonTitle = "Done"
    
    //Floating action bar
    @State var fabTitle = "Mindflo Pro"
    @State var fabSubtitle = "Unlock your journey"
    @State var fabLocalizedPrice = "$9.99"
    
    
    var body: some View {
        
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24){
                    
                    ZStack {
                        Color.black
                        VStack(alignment: .center, spacing: 24) {
                            Text("Capture more with Pro")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.trailing, 64)
                            
                            
                            Image("prohero")
                        }
                        .padding(.vertical, 32)
                        
                        
                    }
                    .edgesIgnoringSafeArea(.top)
                    
                    
                    VStack {
                        HStack {
                            Text("Benefits with Pro")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            Spacer()
                        }
                        //📷
                        MFProAccordionList(title: "Add a Photo", icon: "camera", details: ["Capture more context with a photo. Photo journaling makes your Mindflo more powerful.", "Multiple photos on a post is currently unavailable."])
                        //🎨
                        MFProAccordionList(title: "Unlock more colors", icon: "square.on.square", details: ["Colors unlock your potential to express yourself more creatively.", "Use these pastel colors to categorize your moods beautifully."])
                        
                        //♥️
                        MFProAccordionList(title: "Support our journey", icon: "heart", details: ["Help support the maintenance and development of Mindflo"])
                    }
                    
                    Button(action: {
                        verifyReceipt(purchase: yearlyPro)
                        
                    }, label: {
                        Text("Validate Reciepts")
                    })
                    .padding()
                    
                    
                    Button(action: {
                        restorePurchase()
                        
                    }, label: {
                        Text("Restore purchase")
                    })
                    .padding()
                    
                    Button(action: {
                        refreshReceipt()
                        
                    }, label: {
                        Text("Refresh receipt")
                    })
                    .padding()
                    
                    Spacer().frame(height: 80)
                    
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertDescription), dismissButton: .default(Text(alertButtonTitle)))
            }
            
            //Floating action bar for Pro
            VStack {
                Spacer()
                Button(action: {
                    purchase(purchase: yearlyPro)
                    print("PRO Tap : Alert title \(alertTitle)")
                }, label: {
                    HStack{
                        Image("Pro logo")
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(fabTitle)")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                            
                            Text("\(fabSubtitle)y")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 4)
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("\(fabLocalizedPrice)")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                            
                            Text("$19.99")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .strikethrough()
                        }
                    }
                    .padding()
                    .frame(height: 84)
                    .background(BlurEffect())
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                })
                .buttonStyle(PlainButtonStyle())
                
            }
            .onAppear(){
                getInfo(purchase: yearlyPro)
            }
        }
        
    }
    
    let sharedSecret = "ffdc1b2d7acc4231ab01767dd65f239e"
    let bundleID = "com.aditgupta.MindFlo"
    var yearlyPro = RegisteredPurchase.yearlyPro
    
    func getInfo(purchase: RegisteredPurchase) {
        
        SwiftyStoreKit.retrieveProductsInfo([bundleID + "." + purchase.rawValue]) { (result) in
            
            
        self.alertForProductRetrival(result: result)
        //Add relevant alerts during retrival
        }
    }
    
    func purchase(purchase: RegisteredPurchase) {
        SwiftyStoreKit.purchaseProduct(bundleID + "." + purchase.rawValue) { (result) in
            if case .success(let product) = result {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                self.alertForPurchaseResult(result: result)
            }
        }
    }
    
    func restorePurchase(){
        //NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.restorePurchases(atomically: true) { (result) in
            
            for product in result.restoredPurchases {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
            }
            self.alertForRestorePurchases(result: result)
        }
    }
    
    func verifyReceipt(purchase: RegisteredPurchase) {
        //NetworkActivityIndicatorManager.NetworkOperationStarted()
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator, forceRefresh: false) { (result) in
            switch result {
            case .success(let receipt):
                let productId = self.bundleID + "." + purchase.rawValue
                // Verify the purchase of Consumable or NonConsumable
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt)
                
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\(productId) is purchased: \(receiptItem)")
                    alertWithTitle(title: "Receipt", message: "Pro has been purchased")
                case .notPurchased:
                    print("The user has never purchased \(productId)")
                    alertWithTitle(title: "Receipt", message: "Pro was never purchased")
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
                alertWithTitle(title: "Receipt verification failed", message: "Try again later")
                break
                
            }
        }
    }
    
    func verifyPurchase(product: RegisteredPurchase){
        //NetworkActivityIndicatorManager.NetworkOperationStarted()
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        
        SwiftyStoreKit.verifyReceipt(using: appleValidator, forceRefresh: false) { (result) in
            switch result{
            case .success(let receipt):
                let productId = self.bundleID + "." + product.rawValue
                if product == .yearlyPro {
                    //ONLY for auto-renewing subscription
                    let purchaseResult = SwiftyStoreKit.verifySubscription(ofType: .autoRenewable, productId: productId, inReceipt: receipt, validUntil: Date())
                    alertForVerifySubscription(result: purchaseResult)
                }
                else {
                    //Non autorenew
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productId, inReceipt: receipt)
                    alertForVerifyPurchase(result: purchaseResult)
                }
            case .error(let error):
                alertForVerifyReceipt(result: result)
                
                if case .noReceiptData = error {
                    self.refreshReceipt()
                }
            }
        }
    }
    
    func refreshReceipt(){
        SwiftyStoreKit.fetchReceipt(forceRefresh: true) { (result) in
            alertForFetchReceiptRefresh(result: result)
        }
    }
}
extension MFProUpgrade {
    func alertWithTitle(title: String, message: String, buttonTitle: String = "Done") {
        self.alertTitle = title
        self.alertDescription = message
        self.alertButtonTitle = buttonTitle
        self.showAlert = true
    }
    
    func alertForProductRetrival(result: RetrieveResults) {
        if let product = result.retrievedProducts.first {
            //Setup the floating action bar
            self.fabTitle = product.localizedTitle
            self.fabSubtitle = product.localizedDescription + " " + product.localizedSubscriptionPeriod
            self.fabLocalizedPrice = product.localizedPrice!
            
        }
        else if let invalidProductID = result.invalidProductIDs.first {
            alertWithTitle(title: "Could not retrieve a Pro product info", message: "Invalid product ID \(invalidProductID)")
        }
        else {
            let errorString = result.error?.localizedDescription ?? "Unkown error, please contact us"
            alertWithTitle(title: "Error", message: errorString)
        }
        
    }
    
    func alertForPurchaseResult(result: PurchaseResult) {
        switch result {
        case .success(let product):
            print("Purchase successful \(product.productId)")
            alertWithTitle(title: "Congrats on Minflo Pro!", message: "Enjoy your Pro :)")
            
        case .error(let error):
            var errorString = ""
            
            switch error.code {
            case .unknown: errorString = "Unknown error. Please contact support"
            case .clientInvalid: errorString = ("Not allowed to make the payment")
            case .paymentCancelled: break
            case .paymentInvalid: errorString = ("The purchase identifier was invalid")
            case .paymentNotAllowed: errorString = ("The device is not allowed to make the payment")
            case .storeProductNotAvailable: errorString = ("The product is not available in the current storefront")
            case .cloudServicePermissionDenied: errorString = ("Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed: errorString = ("Could not connect to the network")
            case .cloudServiceRevoked: errorString = ("User has revoked permission to use this cloud service")
            default: errorString = ((error as NSError).localizedDescription)
            }
            print(errorString)
            alertWithTitle(title: "Purchase failed", message: errorString)
        }
    }
    
    func alertForRestorePurchases(result: RestoreResults){
        if result.restoreFailedPurchases.count > 0 {
            print("restore failed \(result.restoreFailedPurchases)")
            alertWithTitle(title: "Restore failed", message: "Unkown error, try again in a while")
        }
        else if result.restoredPurchases.count > 0 {
            print("Restore successful \(result.restoredPurchases)")
            alertWithTitle(title: "Mindflo Pro has been restored", message: "Thanks for supporting Mindflo. Enjoy :)")
        }
        else {
            print("Nothing to restore")
            alertWithTitle(title: "No past purchases to restore", message: "Please contact support")
        }
    }
    
    func alertForVerifyReceipt(result: VerifyReceiptResult){
        switch result {
        case .success:
            alertWithTitle(title: "Receipt verified", message: "Receipt verified remotely")
        case .error(let error):
            switch error {
            case .noReceiptData:
                alertWithTitle(title: "Receipt verification failed", message: "No receipt found. Try again later.")
            default:
                alertWithTitle(title: "Receipt verification failed", message: "Error unknown")
            }
        }
    }
    
    func alertForVerifySubscription(result: VerifySubscriptionResult){
        switch result {
        case .purchased(let expiryDate, let items):
            print("Mindflo Pro is valid until \(expiryDate)\n\(items)\n")
            alertWithTitle(title: "Your Mindflo Pro is active", message: "Valid until \(expiryDate)")
        case .expired(let expiryDate, let items):
            print("Pro has expired since \(expiryDate)\n\(items)\n")
            alertWithTitle(title: "Your Mindflo Pro has expired", message: "Since \(expiryDate)")
        case .notPurchased:
            print("The user has never purchased")
            alertWithTitle(title: "Mindflo Pro was not purchased", message: "Get Pro")
        }
    }
    
    func alertForVerifyPurchase(result: VerifyPurchaseResult){
        //Useful for non-sub Pro
        switch result {
        case .purchased:
            alertWithTitle(title: "Pro purchased", message: "This plan is always valid and will not expire")
        case .notPurchased:
            alertWithTitle(title: "Pro was not purchased", message: "Please upgrade or contact us")
        }
    }
    
    func alertForFetchReceiptRefresh(result: FetchReceiptResult){
        switch result {
        case .success:
            alertWithTitle(title: "Refresh receipt successful", message: "Thanks")
            print("Receipt refresh success")
        case.error(let error):
            alertWithTitle(title: "Error occured during refresh", message: "Please try again later. \(error.localizedDescription)")
            print("Reciept refresh error\(error.localizedDescription)")
        }
    }
    
}
struct MFProAccordionList: View {
    @State var showDetails = false
    var title: String = ""
    var icon: String = "plus"
    var details: [String] = [""]
    
    var body: some View{
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                Image(systemName: showDetails ? "\(icon).fill": "\(icon)")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.gray)
                    .padding(.trailing)
                Text("\(title)")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: showDetails ? "chevron.up": "chevron.down")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(ColorManager.buttonGrey)
            }
            .padding([.all])
            
            
            if self.showDetails {
                Group{
                    ForEach(details.indices){index in
                        
                        Text("\(details[index])")
                            .font(.system(.body))
                            .lineLimit(nil)
                            .padding(.leading, 64)
                    }
                }
                .padding([.trailing, .bottom], 8)
                
            } else {
                EmptyView()
            }
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color.black.opacity(0.10))
                .padding(.leading, 72)
                .padding(.top, 0)
            
        }
        .onTapGesture{
            showDetails.toggle()
        }
    }
}

/*
 class NetworkActivityIndicatorManager : NSObject {
 private static var loadingCount = 0
 
 class func NetworkOperationStarted() {
 if loadingCount == 0 {
 //UIApplication.shared.isNetworkActivityIndicatorVisible = true
 // need to replace this with a loader
 }
 loadingCount += 1
 }
 class func NetworkOperationFinished() {
 if loadingCount > 0 {
 loadingCount -= 1
 }
 
 if loadingCount == 0 {
 //UIApplication.shared.isNetworkActivityIndicatorVisible = false
 //Need to remove the loader
 }
 }
 }
 */

struct MFProUpgrade_Previews: PreviewProvider {
    static var previews: some View {
        MFProUpgrade()
    }
}
