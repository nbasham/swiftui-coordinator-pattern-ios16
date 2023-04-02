import SwiftUI

///  Comands differ from routes in that they express an intention rather than a destination and leave it to the Coordinator to determine the destination
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
    @Published var cover: Cover?

    private func push(_ page: Page) { path.append(page) }
    private func pop() { path.removeLast() }
    private func popToRoot() { path.removeLast(path.count) }
    private func present(_ sheet: Sheet) { self.sheet = sheet }
    private func cover(_ cover: Cover) { self.cover = cover }
    private func dismissSheet() { self.sheet = nil }
    private func dismissCover() { self.cover = nil }

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
                cover(.help)
            case .main:
                push(.main)
            case .settings:
                push(.settings)
            case .dismissAbout:
                dismissSheet()
            case .dismissHelp:
                dismissCover()
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
    func build(cover: Cover) -> some View {
        switch cover {
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

    enum Cover: String, Identifiable, Hashable {
        case help
        var id: String { rawValue }
    }
}
