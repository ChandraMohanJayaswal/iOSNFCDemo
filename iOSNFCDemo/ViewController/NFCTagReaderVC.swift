//
//  NFCTagReaderVC.swift
//  iOSNFCDemo
//
//  Created by Chandra Jayaswal on 29/08/2023.
//

import UIKit
import CoreNFC

class NFCTagReaderVC: BaseVC {

    @IBOutlet weak var lblTagMsg: UILabel!
    var nfcSession: NFCNDEFReaderSession? = nil
    let word = "NA"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnSignOutAction(_ sender: Any) {
        self.moveToLoginVC()
    }
    
    @IBAction func btnScanAction(_ sender: Any) {
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.begin()
    }
}

extension NFCTagReaderVC: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Session invalidate with error: \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.lblTagMsg.text = "\(error.localizedDescription)"
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var result = ""
        for payload in messages[0].records {
            result = result + (String.init(data: payload.payload.advanced(by: 3), encoding: .utf8) ?? "No payload for defined format!")
        }
        
        DispatchQueue.main.async {
            self.lblTagMsg.text = "Result: \(result)"
        }
    }
    
}
