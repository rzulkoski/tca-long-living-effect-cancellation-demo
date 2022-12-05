import SwiftUI

struct ContentView: View {
    var body: some View {
		// Using UIKit at the root to replicate issue
		UITabBarControllerWrapperView()
			.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
