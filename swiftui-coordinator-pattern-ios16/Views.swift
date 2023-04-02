import SwiftUI

struct MainView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        VStack(spacing: 24) {
            Button("Settings") { coordinator.command(.settings) }
        }
        .navigationBarTitle("Main", displayMode: .automatic)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.yellow, for: .navigationBar)
        .toolbar {
            CommandToolBarItem(command: .help, label: "help", image: "questionmark.circle.fill", isTrailing: true)
        }
    }
}

struct SettingsView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        ZStack {
            Text("Tinker with things here")
        }
        .navigationTitle("Settings")
        .navigationBarBackButtonHidden()
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.orange, for: .navigationBar)
        .toolbar {
            CommandToolBarItem(command: .back, label: "back", image: "chevron.left.circle.fill")
            CommandToolBarItem(command: .about, label: "about", image: "info.circle.fill", isTrailing: true)
        }
    }
}

struct CommandToolBarItem: ToolbarContent {
    let command: Command
    let label: String?
    let image: String?
    var isTrailing: Bool = false

    var body: some ToolbarContent {
        ToolbarItem(placement: isTrailing ? .navigationBarTrailing : .navigationBarLeading) {
            ToolbarButton(command, label, image, isTrailing)
        }
    }

    struct ToolbarButton: View {
        let command: Command
        let label: String?
        let image: String?
        let isTrailing: Bool
        @EnvironmentObject private var coordinator: Coordinator

        init(_ command: Command, _ label: String? = nil, _ image: String? = nil, _ isTrailing: Bool = false) {
            self.command = command
            self.label = label
            self.image = image
            self.isTrailing = isTrailing
        }

        var body: some View {
            Button(action: {
                coordinator.command(command)
            }, label: {
                HStack {
                    if let label, isTrailing {
                        Text(label)
                    }
                    if let image {
                        Image(systemName: image)
                            .imageScale(.large)
                    }
                    if let label, !isTrailing {
                        Text(label)
                    }
                }
                .foregroundColor(.white)
            })
        }
    }
}

struct CommandToolBarItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Text("The Navigation bar should have a X button")
                .environmentObject(Coordinator())
                .navigationBarTitle("Message", displayMode: .inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.yellow, for: .navigationBar)
                .toolbar {
                    CommandToolBarItem(command: .dismissAbout, label: nil, image: "x.circle.fill", isTrailing: true)
                }
        }
    }
}

struct AboutView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        NavigationStack {
            Text("About this and that")
                .padding()
                .navigationTitle("About")
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.pink, for: .navigationBar)
                .toolbar {
                    CommandToolBarItem(command: .dismissAbout, label: nil, image: "x.circle.fill", isTrailing: true)
                }
        }
    }
}

struct HelpView: View {
    @EnvironmentObject private var coordinator: Coordinator
    let message: LocalizedStringKey = """
        **Help**

        This is **where** you see *how* to do it, and if you ***goof** ~~how not to do it~~
        `Monospaced numbers 123` 🙃
        """

    var body: some View {
        NavigationStack {
            ScrollView {
                Text(message)
            }
            .padding()
            .navigationTitle("Help")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.green, for: .navigationBar)
            .toolbar {
                CommandToolBarItem(command: .dismissHelp, label: nil, image: "x.circle.fill", isTrailing: true)
            }
        }
    }
}
