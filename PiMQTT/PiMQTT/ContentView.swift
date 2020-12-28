//
//  ContentView.swift
//  PiMQTT
//
//  Created by Max Leblang on 12/25/20.
//

import SwiftUI
import CocoaMQTT

let mqttClient = CocoaMQTT(clientID: "LongboardApp", host: "192.168.190.237", port: 1883)

struct ContentView: View {
    @State private var speed = 0
    @State private var maxSpeed = 20
    
    func speedUp(){
        speed += 1
        if(speed>=maxSpeed){
            speed = maxSpeed
        }
        mqttClient.publish("pibot/move", withString: String(speed))
    }
    func slowDown(){
        speed -= 1
        if(speed<=0){
            speed = 0
        }
        mqttClient.publish("pibot/move", withString: String(speed))
    }
    
    
    var body: some View {
    
        VStack {
            Button(action: {
                let test: Bool = mqttClient.connect()
                print(test)
            }) {
                Text("Connect")
            }
            Stepper(onIncrement: speedUp,
                    onDecrement: slowDown) {
                    Text("Speed: \(speed)")
                }
                .padding(5)
            
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
