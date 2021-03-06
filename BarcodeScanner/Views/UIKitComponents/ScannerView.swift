//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Christopher J. Roura on 11/6/20.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
        }
        
        func didSurface(error: CameraError) {
            switch error {
                case .invalidDeviceInput:
                    scannerView.alertItem = AlertContext.invalidDeviceInput
                case .invalidScanValue:
                    scannerView.alertItem = AlertContext.invalidScannedType
            }
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(scannedCode: .constant("Not Yet Scanned"),
                    alertItem: .constant(AlertItem(title: Text(""),
                                                   message: Text(""),
                                                   dismissButton: .default(Text("Ok")))))
    }
}
