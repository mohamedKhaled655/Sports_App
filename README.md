# 🏅 The Sports App

A sleek iOS application built with **Swift** that leverages the [AllSportsAPI](https://allsportsapi.com/) to provide users with information about various sports, leagues, events, and teams. The app offers a smooth user experience with modern UI design, persistence using CoreData, and clean architecture with Unit Testing and design patterns.

---

## 📱 Features

### ✅ Onboarding screen
###🌐 Localization support
### 🌙 Dark mode UI

### 🏟 Main Screen (2 Tabs)

#### 1. All Sports
- Displayed in a `UICollectionView` (2 items per row, with spacing).
- Each sport cell shows:
  - **Sport Name** (`strSport`)
  - **Sport Thumbnail** (`strSportThumb`)
- Navigation: Selecting a sport → navigates to **Leagues ViewController**
- Screen Title: `Sports`

#### 2. Favorite Leagues
- Uses **CoreData** for persistent storage.
- Layout similar to `Leagues ViewController`
- Tap on any league:
  - If online → navigates to **LeagueDetailsViewController**
  - Else → shows an alert (No Internet Connection)
- Screen Title: `Favorites`

---

### 🏆 Leagues ViewController
- A `UITableViewController` with title `Leagues`
- Each row contains:
  - **League Badge** (`strBadge`) – circular
  - **League Name** (`strLeague`)
- Tap to navigate to **LeagueDetailsViewController**

---

### 📅 LeagueDetails ViewController
- Top-right: Add/Remove from Favorite Leagues
- Screen divided into 3 sections:

#### 1. Upcoming Events
- Horizontal `UICollectionView`
- Each item includes:
  - Event name (`strEvent`)
  - Date & time
  - Teams' images

#### 2. Latest Events
- Vertical `UICollectionView`
- Each item includes:
  - Match: Home vs Away
  - Scores
  - Date & time
  - Teams' images

#### 3. Teams
- Horizontal `UICollectionView`
- Circular image of the team
- Tap → navigates to **TeamDetails ViewController**

---

### 👥 TeamDetails ViewController
- Displays team details (simplified, elegant design)
- Custom, elegant UI layout

---

## 🧰 Technologies Used

- **Swift & UIKit**
- **Alamofire** – for networking
- **CoreData** – for local persistence
- **AllSportsAPI** – for sports data
- **Design Patterns** –MVP architecture
- **Unit Testing** – for logic and API layer

---

![sportsApp](https://github.com/user-attachments/assets/e77fc795-1b42-4c4f-a0e1-6620fa2b0531)



---

## 🛠 Setup & Run

1. Clone the repository:
   ```bash
   git clone https://github.com/mohamedKhaled655/Sports_App
   cd the-sports-app
