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
            ToolbarItem(placement: .navigationBarTrailing) {
                NavButton(.help, "help", "questionmark.circle.fill", isTrailing: true)
            }
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
            ToolbarItem(placement: .navigationBarLeading) {
                NavButton(.back, "back", "chevron.left.circle.fill")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavButton(.about, "about", "info.circle.fill", isTrailing: true)
            }
        }
    }
}

struct NavButton: View {
    let command: Command
    let label: String?
    let image: String?
    let isTrailing: Bool
    @EnvironmentObject private var coordinator: Coordinator

    init(_ command: Command, _ label: String? = nil, _ image: String? = nil, isTrailing: Bool = false) {
        self.command = command
        self.label = label
        self.image = image
        self.isTrailing = isTrailing
    }

    var body: some View {
        Button(action: {
            DispatchQueue.main.async(execute: {
                coordinator.command(command)
            })
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
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavButton(.dismissAbout, nil, "x.circle.fill", isTrailing: true)
                    }
                }
        }
    }
}

struct HelpView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        NavigationStack {
            ScrollView {
                Text("""
                        I need somebody
                        (Help) not just anybody
                        (Help) you know I need someone, help
                        So much younger than today
                        (I never need) I never needed anybody's help in any way
                        (Now) but now these days are gone (these days are gone)
                        I'm not so self assured
                        (And now I find) now I find I've changed my mind
                        And opened up the doors
                        Help me if you can, I'm feeling down
                        And I do appreciate you being 'round
                        Help me get my feet back on the ground
                        Won't you please, please help me
                        In oh so many ways
                        (My independ-) my independence seems to vanish in the haze
                        (But) but every now and then (now and then)
                        I feel so insecure
                        (I know that I) I know that I just need you like
                        I've never done before
                        Help me if you can, I'm feeling down
                        And I do appreciate you being 'round
                        Help me get my feet back on the ground
                        Won't you please, please help me
                        When I was younger, so much younger than today
                        I never needed anybody's help in any way
                        (Now) but now these days are gone (these days are gone)
                        I'm not so self assured
                        (And now I find) now I find I've changed my mind
                        And opened up the doors
                        Help me if you can, I'm feeling down
                        And I do appreciate you being 'round
                        Help me get my feet back on the ground
                        Won't you please, please help me, help me, help me, ooh
                    """)
            }
            .padding()
            .navigationTitle("Help")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.green, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavButton(.dismissHelp, nil, "x.circle.fill", isTrailing: true)
                }
            }
        }
    }
}
