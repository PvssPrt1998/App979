import SwiftUI

struct Tab: View {
    
    @State var selection: Int = 0
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(rgbColorCodeRed: 153, green: 153, blue: 153, alpha: 1)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 153, green: 153, blue: 153, alpha: 1)]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(rgbColorCodeRed: 57, green: 229, blue: 123, alpha: 1)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 57, green: 229, blue: 123, alpha: 1)]
        appearance.backgroundColor = UIColor.c474849
        appearance.shadowColor = .white.withAlphaComponent(0.15)
        appearance.shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
        UITabBar.appearance().backgroundColor = .c474849
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Text("Competitions")
                .tabItem { VStack {
                    tabViewImage("latch.2.case")
                    Text("Competitions") .font(.system(size: 10, weight: .medium))
                } }
            Text("Tricks")
                .tabItem { VStack {
                    tabViewImage("apps.ipad")
                    Text("Tricks") .font(.system(size: 10, weight: .medium))
                } }
            Text("Places")
                .tabItem { VStack{
                    tabViewImage("map.fill")
                    Text("Places")
                        .font(.system(size: 10, weight: .medium))
                }
                }
            Text("My posts")
                .tabItem {
                    VStack {
                        tabViewImage("gearshape.fill")
                        Text("My posts") .font(.system(size: 10, weight: .medium))
                    }
                }
            Text("Settings")
                .tabItem {
                    VStack {
                        tabViewImage("gearshape.fill")
                        Text("Settings") .font(.system(size: 10, weight: .medium))
                    }
                }
        }
    }
    
    @ViewBuilder func tabViewImage(_ systemName: String) -> some View {
        if #available(iOS 15.0, *) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
                .environment(\.symbolVariants, .none)
        } else {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
        }
    }
}

#Preview {
    Tab()
}

extension UIColor {
   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
   }
}
