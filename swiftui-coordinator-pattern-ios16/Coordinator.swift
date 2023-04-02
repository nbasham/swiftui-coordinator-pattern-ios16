import SwiftUI

///  Commands differ from routes in that they express an intention rather than a destination and leave it to the Coordinator to determine the destination
enum Command {
    case about, back, help, main, settings, dismissHelp, dismissAbout
}

@MainActor
class Coordinator: ObservableObject {
    @Published var path = NavigationPath() {
        didSet {
            print("path count \(path.count)")
        }
    }
    @Published var sheet: Sheet?
    @Published var fullscreen: Fullscreen?

    private func push(_ page: Page) { path.append(page) }
    private func pop() { path.removeLast() }
    private func popToRoot() { path.removeLast(path.count) }
    private func present(_ sheet: Sheet) { self.sheet = sheet }
    private func fullscreen(_ fullscreen: Fullscreen) { self.fullscreen = fullscreen }
    private func dismissSheet() { self.sheet = nil }
    private func dismissFullscreen() { self.fullscreen = nil }

    init() {
        print("Coordinator init'd")
    }

    deinit {
        print("Coordinator deinit'd")
    }

    func command(_ command: Command) {
        switch command {
            case .about:
                present(.about)
            case .back:
                pop()
            case .help:
                fullscreen(.help)
            case .main:
                push(.main)
            case .settings:
                push(.settings)
            case .dismissAbout:
                dismissSheet()
            case .dismissHelp:
                dismissFullscreen()
        }
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
            case .main:
                MainView()
            case .settings:
                SettingsView()
        }
    }

    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
            case .about:
                AboutView()
        }
    }

    @ViewBuilder
    func build(fullscreen: Fullscreen) -> some View {
        switch fullscreen {
            case .help:
                HelpView()
        }
    }
}

extension Coordinator {
    enum Page: String, Identifiable, Hashable {
        case main, settings
        var id: String { rawValue }
    }

    enum Sheet: String, Identifiable, Hashable {
        case about
        var id: String { rawValue }
    }

    enum Fullscreen: String, Identifiable, Hashable {
        case help
        var id: String { rawValue }
    }
}
