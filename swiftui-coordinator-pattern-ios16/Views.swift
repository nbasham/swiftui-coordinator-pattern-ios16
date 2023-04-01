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
                Button(action: {
                    coordinator.command(.help)
                }, label: {
                    HStack {
                        Label("help", systemImage: "questionmark.circle.fill")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                })
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
                ZStack(alignment: .trailing) {
                    Button(action: {
                        coordinator.command(.back)
                    }, label: {
                        HStack {
                            Label("back", systemImage: "chevron.left.circle.fill")
                                .imageScale(.large)
                            Text("back")
                        }
                    })
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    DispatchQueue.main.async(execute: {
                        coordinator.command(.about)
                    })
                }, label: {
                    HStack {
                        Text("about")
                        Label("info", systemImage: "info.circle.fill")
                            .imageScale(.large)
                    }
                })
            }
        }
        .foregroundColor(.white)
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
                        Button(action: {
                            coordinator.dismissSheet()
                        }, label: {
                            HStack {
                                Label("dismiss", systemImage: "x.circle.fill")
                                    .imageScale(.large)
                            }
                        })
                        .foregroundColor(.white)
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
                    Button(action: {
                        coordinator.dismissCover()
                    }, label: {
                        HStack {
                            Label("dismiss", systemImage: "x.circle.fill")
                                .imageScale(.large)
                        }
                    })
                    .foregroundColor(.white)
                }
            }
        }
    }
}
