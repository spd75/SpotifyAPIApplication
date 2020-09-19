# SpotifyAPIApplication

***Please excuse the lack of documentation. I have tried to document more for those viewing it on Github. However, because I wrote this program by myself, I didn't have a big need for documenting all functions and classes.***

***To understand the concepts necessary to create this application, I watched and took notes on the AppDev iOS lectures that are posted on YouTube.***

This app was developed using UIKit and Swift.  The purpose is for users to be able to see how popular certain Spotify songs are.  Users are required to sign in to their Spotify account (Spotify's API requires an Auth Key, which is only granted after signing in).  Once they have done so, all their playlists will appear in a UITableView of multiple horizontal scrolling UICollectionViews, which shows all the songs on their playlists and their popularity metric.  Users can then press a button to search to view the popularity of specific songs.

The app uses the Spotify API to retrieve data.  With the help of the AlamoFire library, I was able to figure out how to gain access to the API by acquiring an Auth Key.  This was easily the most complex step in the process.  Once I figured this out, I was able to work with the API to get any data necessary to complete the application.

