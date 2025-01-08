import SwiftUI

struct ContentView: View {
    @State private var buttonText = "Cookies: 0"
    @State private var timer: Timer?
    @State private var bonusTimer: Timer? // New timer
    @State private var persec: Int = 0
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    
// saved
    @AppStorage("cookies") private var cookiesSaved: Int = 0
        @State private var cookies: Int = 0 {
            didSet {
                cookiesSaved = cookies // Save to AppStorage whenever cookies changes
            }
        }
    @AppStorage("clickers") private var clickersSaved: Int = 0
        @State private var clickers: Int = 0 {
            didSet {
                clickersSaved = clickers // Save to AppStorage whenever cookies changes
            }
        }
    @AppStorage("clickprice") private var clickpriceSaved: Int = 10
        @State private var clickprice: Int = 10 {
            didSet {
                clickpriceSaved = clickprice // Save to AppStorage whenever cookies changes
            }
        }
    @AppStorage("grandmas") private var grandmasSaved: Int = 0
        @State private var grandmas: Int = 0 {
            didSet {
                grandmasSaved = grandmas // Save to AppStorage whenever cookies changes
            }
        }
    @AppStorage("grandprice") private var grandpriceSaved: Int = 20
        @State private var grandprice: Int = 20 {
            didSet {
                grandpriceSaved = grandprice // Save to AppStorage whenever cookies changes
            }
        }
    @AppStorage("farms") private var farmsSaved: Int = 0
        @State private var farms: Int = 0 {
            didSet {
                farmsSaved = farms // Save to AppStorage whenever cookies changes
            }
        }
    @AppStorage("farmprice") private var farmpriceSaved: Int = 40
        @State private var farmprice: Int = 40 {
            didSet {
                farmpriceSaved = farmprice // Save to AppStorage whenever cookies changes
            }
        }
    @AppStorage("factories") private var factoriesSaved: Int = 0
        @State private var factories: Int = 0 {
            didSet {
                factoriesSaved = factories // Save to AppStorage whenever cookies changes
            }
        }
    @AppStorage("factprice") private var factpriceSaved: Int = 80
        @State private var factprice: Int = 80 {
            didSet {
                factpriceSaved = factprice // Save to AppStorage whenever cookies changes
            }
        }
    @AppStorage("cookperclick") private var cookperclickSaved: Int = 1
    @State private var cookperclick: Int = 1 {
        didSet {
            cookperclickSaved = cookperclick // Save to AppStorage whenever cookies changes
        }
    }
    @AppStorage("perclickprice") private var perclickpriceSaved: Int = 300
        @State private var perclickprice: Int = 300 {
            didSet {
                perclickpriceSaved = perclickprice // Save to AppStorage whenever cookies changes
            }
        }
    





    

    var body: some View {
        
        ZStack {
            // Background color
            LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.4, green: 0.2, blue: 0.1), Color.brown]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

            VStack() { // Main vertical stack with spacing
                // First button and text pair
                VStack {
                    Button(action: buyperclick) {
                        Label("+ Cookie per Click (\(perclickprice) cookies)", systemImage: "cursorarrow.click")
                            .foregroundColor(.black) // Text color
                            .padding()
                    }
                    .background(perclickbuttonColor)
                    .cornerRadius(8)
                    .frame(width: 370, height: 60)
                    Button(action: {
                                    incrementCookies() // Call your action function

                                    // Add bounce animation
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)) {
                                        scale = 0.8 // Grow the button
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)) {
                                            scale = 1.0 // Shrink back
                                        }
                                    }
                                }) {
                                    Image("cookieimg") // Replace with your image name
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300, height: 300)
                                        .padding()
                                        .scaleEffect(scale) // Apply scale transformation
                                        .rotationEffect(.degrees(rotation)) // Apply rotation
                                        .onAppear {
                                            // Start continuous rotation animation when the view appears
                                            withAnimation(
                                                Animation.linear(duration: 5) // Animation duration
                                                    .repeatForever(autoreverses: false) // Keeps it rotating endlessly
                                            ) {
                                                rotation = 360 // Rotate 360 degrees
                                            }
                                        }
                                }
                                .clipShape(Circle()) // Makes the button circular
                                .buttonStyle(PlainButtonStyle()) // Remove default button style

                                Text(buttonText) // Button label
                                    .font(.title)
                                    .padding(.bottom)
                            }
                HStack {
                    Text("\(persec) cookies per sec").padding(.bottom).padding(.bottom)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            Rectangle()
                                .frame(height: 7)
                                .foregroundColor(Color(white: 0.3))
                                .padding(.top, 50),
                            alignment: .bottom
                        )
                    Text("\(cookperclick) cookies per click").padding(.bottom).padding(.bottom)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            Rectangle()
                                .frame(height: 7)
                                .foregroundColor(Color(white: 0.3))
                                .padding(.top, 50),
                            alignment: .bottom
                        )
                }.onAppear() {
                    cookies = cookiesSaved
                    buttonText = "Cookies: \(cookies)"
                    clickers = clickersSaved
                    clickprice = clickpriceSaved
                    grandmas = grandmasSaved
                    grandprice = grandpriceSaved
                    farms = farmsSaved
                    farmprice = farmpriceSaved
                    factories = factoriesSaved
                    factprice = factpriceSaved
                    perclickprice = perclickpriceSaved
                    cookperclick = cookperclickSaved
                }
                

                ScrollView {
                    VStack {
                        Button(action: buyclick) {
                            Label("Clicker (\(clickprice) cookies) \(clickers) owned", systemImage: "computermouse.fill")
                                .foregroundColor(.black) // Text color
                                .padding()
                        }
                        .background(clickbuttonColor)
                        .cornerRadius(8)
                        .frame(width: 360, height: 60)
                        
                        Button(action: buygrand) {
                            Label("Grandma (\(grandprice) cookies) \(grandmas) owned", systemImage: "person.badge.plus")
                                .foregroundColor(.black) // Text color
                                .padding()
                        }
                        .background(grandbuttonColor)
                        .cornerRadius(8)
                        .frame(width: 370, height: 60)
                        
                        Button(action: buyfarm) {
                            Label("Farm (\(farmprice) cookies) \(farms) owned", systemImage: "leaf.fill")
                                .foregroundColor(.black) // Text color
                                .padding()
                        }
                        .background(farmbuttonColor)
                        .cornerRadius(8)
                        .frame(width: 370, height: 60)
                        
                        Button(action: buyfact) {
                            Label("Factory (\(factprice) cookies) \(factories) owned", systemImage: "house.and.flag.fill")
                                .foregroundColor(.black) // Text color
                                .padding()
                        }
                        .background(factbuttonColor)
                        .cornerRadius(8)
                        .frame(width: 370, height: 60)
                        
                    }
                }
            }
        }
        .onAppear {
            startTimer() // Start the first timer
            startBonusTimer() // Start the second timer
        }
        .onDisappear {
            stopTimer()
            stopBonusTimer()
        }
    }

    func incrementCookies() {
        cookies += cookperclick
        buttonText = "Cookies: \(cookies)"
    }
// Buying
    func buyclick() {
        if cookies >= clickprice {
            clickers += 1
            cookies -= clickprice
            clickprice += clickprice/2
            buttonText = "Cookies: \(cookies)"
        }
    }

    func clicker() {
        cookies += clickers
        buttonText = "Cookies: \(cookies)"
    }
// grandmas
    
    func buygrand() {
        if cookies >= grandprice {
            grandmas += 1
            cookies -= grandprice
            grandprice += grandprice/2
            buttonText = "Cookies: \(cookies)"
        }
    }

    func grandma() {
        cookies += grandmas * 2
        buttonText = "Cookies: \(cookies)"
    }
// farms
    
    func buyfarm() {
        if cookies >= farmprice {
            farms += 1
            cookies -= farmprice
            farmprice += farmprice/2
            buttonText = "Cookies: \(cookies)"
        }
    }

    func farm() {
        cookies += farms * 4
        buttonText = "Cookies: \(cookies)"
    }
// factories
    
    func buyfact() {
        if cookies >= factprice {
            factories += 1
            cookies -= factprice
            factprice += factprice/2
            buttonText = "Cookies: \(cookies)"
        }
    }

    func factory() {
        cookies += factories * 8
        buttonText = "Cookies: \(cookies)"
    }
// cook per click
    
    func buyperclick() {
        if cookies >= perclickprice {
            cookperclick += 1
            cookies -= perclickprice
            perclickprice += perclickprice/2
            buttonText = "Cookies: \(cookies)"
        }
    }
// Buying ^
    func startTimer() {
        // Start the first timer to run clicker() every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            clicker()
            grandma()
            farm()
            factory()
        }
    }

    func stopTimer() {
        // Stop the first timer if it's running
        timer?.invalidate()
        timer = nil
    }

    // New timer for bonus cookies
    func startBonusTimer() {
        bonusTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            colorchange()
            persec = clickers + grandmas*2 + farms*4 + factories*8
        }
    }

    func stopBonusTimer() {
        // Stop the bonus timer if it's running
        bonusTimer?.invalidate()
        bonusTimer = nil
    }
    @State private var clickbuttonColor: Color = .gray
    @State private var grandbuttonColor: Color = .gray
    @State private var farmbuttonColor: Color = .gray
    @State private var factbuttonColor: Color = .gray
    @State private var perclickbuttonColor: Color = .gray
    func colorchange() {
        clickbuttonColor = cookies >= clickprice ? .green : .gray
        grandbuttonColor = cookies >= grandprice ? .green : .gray
        farmbuttonColor = cookies >= farmprice ? .green : .gray
        factbuttonColor = cookies >= factprice ? .green : .gray
        perclickbuttonColor = cookies >= perclickprice ? .green : .gray
    }
}

#Preview {
    ContentView()
}
