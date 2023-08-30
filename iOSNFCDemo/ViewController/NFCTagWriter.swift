//
//  NFCTagWriter.swift
//  iOSNFCDemo
//
//  Created by Chandra Jayaswal on 29/08/2023.
//

import UIKit
import CoreNFC

class NFCTagWriter: BaseVC {
    @IBOutlet weak var txtNFCTagMessage: UITextField!
    
    var nfcSession: NFCNDEFReaderSession? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnWriteAction(_ sender: Any) {
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Make sure your iPhone is near an NFC Tag to write the message!"
        nfcSession?.begin()

    }
    
    @IBAction func btnSignOutAction(_ sender: Any) {
        self.moveToLoginVC()
    }
    
}

extension NFCTagWriter: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Session invalidate with error: \(error.localizedDescription)")

    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        var value: String = "\(self.txtNFCTagMessage.text ?? "NA")"
        var valueToUInt8 = [UInt8] (value.utf8)
        
        if tags.count > 1 {
            let retryAfter = DispatchTimeInterval.milliseconds(800)
            session.alertMessage = "More than one NFC Tag is detected. Mare sure there is only one NFC Tag near to iPhone!"
            DispatchQueue.global().asyncAfter(deadline: .now() + retryAfter, execute: {
                session.restartPolling()
            })
            return
        }
        
        let tag = tags.first!
        session.connect(to: tag) { (error: Error?) in
            if error != nil {
                session.alertMessage = "Unable to connect with NFC Tag. Error: \(error?.localizedDescription)"
                session.invalidate()
                return
            }
            
            tag.queryNDEFStatus { (nfcStatus: NFCNDEFStatus, capacity: Int, error: Error?) in
                
                if let error = error {
                    session.alertMessage = "Unable to query NFC Tag. Error: \(error.localizedDescription)"
                    session.invalidate()
                    return
                }
                
                switch nfcStatus {
                    
                case .notSupported:
                    session.alertMessage = "NFC Tag is not NDEF complaint!"
                    session.invalidate()
                    
                case .readWrite:
                    tag.writeNDEF(.init(records: [.init(format: .nfcWellKnown, type: Data([06]), identifier: Data([0x0C]), payload: Data(valueToUInt8))])) { (error:Error?) in
                        //
                        
                        if let error = error {
                            session.alertMessage = "Unable to write message. Error: \(error.localizedDescription)"
                        } else {
                            session.alertMessage = "Write message to NFC Tag is successful!"
                        }
                        session.invalidate()
                    }
                case .readOnly:
                    session.alertMessage = "NFC Tag read only!"
                    session.invalidate()
                @unknown default:
                    session.alertMessage = "Unknown NFC Tag status!"
                    session.invalidate()
                }
            }
        }
    }
    
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        //
    }
    
}
