//
//  ContentView.swift
//  WalletDemoV2
//
//  Created by Kai on 11/20/22.
//

import Foundation
import SwiftUI
import Starscream
import WalletConnectNetworking
import WalletConnectRelay
import WalletConnectPairing


extension WebSocket: WebSocketConnecting { }


struct SocketFactory: WebSocketFactory {
    func create(with url: URL) -> WebSocketConnecting {
        return WebSocket(url: url)
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                connect()
            } label: {
                Text("Connect")
            }
        }
        .padding()
        .task {
            setup()
        }
    }

    func setup() {
        let metadata = AppMetadata(
            name: "Sample Mac V2",
            description: "Sample Mac V2 Description",
            url: "com.sample.mac.v2",
            icons: [""])
        Networking.configure(projectId: "ad654754426704b226bda09ea5392691", socketFactory: SocketFactory())
        Pair.configure(metadata: metadata)
    }

    func connect() {
        Task {
            let uri = try await Pair.instance.create()
            debugPrint("WalletConnect 2.0 URI: \(uri)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
