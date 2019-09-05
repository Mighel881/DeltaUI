import SwiftUI

extension ActionSheet {
    static func EmulatorMenu(store: CurrentlyPlayingStore, menu: MenuStore) -> ActionSheet {
        ActionSheet(title: Text("Menu"), message: nil, buttons: [
            store.game!.favorited ? .default(Text("Unfavorite")) {
                store.game?.favorited.toggle()
                } : .default(Text("Favorite")) {
                    store.game?.favorited.toggle()
            },
            .default(Text("Add to Playlist")) {
                menu.isShowingSavedStates = false
                menu.isShowingAddToPlaylist.toggle()
            },
            .default(Text("View Saved States")) {
                menu.isShowingAddToPlaylist.toggle() // lazy af
                menu.isShowingSavedStates = true
            },
            .destructive(Text("Close \(store.game!.console.title)")) {
                store.isShowingEmulator.toggle()
            },
            .cancel()
        ])
    }
}
