import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black, Color("PrimaryAccent").opacity(0.80)],
                startPoint: .center,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()
            
            VStack(spacing: 12) {
               
                VStack(spacing: 12) {
                    Image("splash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    Text("Journali")
                        .font(.system(size: 42, weight: .black))
                        .foregroundColor(.white)
                    
                    Text("Your thoughts, your story")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color("TextSecondary"))
                }
            }
        }
    }
}
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
