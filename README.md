# Vought Showcase

A modern iOS application that showcases characters from "The Boys" TV series through an interactive carousel/story interface, built with Swift and UIKit.

## 📱 Features

- **Interactive Carousel**: Swipeable character showcase with smooth transitions
- **Story-like Interface**: Instagram/Snapchat-style story progression with segmented progress bars
- **Character Showcase**: Features characters from "The Boys" including:
  - Billy Butcher
  - Frenchie
  - Hughie Campbell
  - Mother's Milk (MM)
  - Homelander
  - Queen Maeve
  - A-Train
  - Black Noir
- **Gesture Controls**: 
  - Tap left/right to navigate between stories
  - Swipe down to dismiss modal presentations
  - Automatic story progression with customizable timing
- **Modal Presentations**: Bottom-up slide animations for immersive viewing
- **Looping Support**: Configurable story looping for continuous playback

## 🏗️ Architecture

The project follows a clean, modular architecture with clear separation of concerns:

### Core Components

- **Carousel System**: Modular carousel implementation with protocol-based design
- **Progress Bar**: Custom segmented progress bar with animation support
- **Presentation Controllers**: Custom modal presentation with bottom-up animation
- **Gesture Handling**: Comprehensive touch and swipe gesture recognition

### Project Structure

```
Vought Showcase/
├── Controllers/           # View Controllers
│   ├── MainViewController.swift
│   ├── CarouselViewController.swift
│   ├── ImageViewController.swift
│   └── BottomUpPresentationController.swift
├── Views/                 # Custom UI Components
│   └── SegmentedProgressBar.swift
├── Carousel/             # Carousel System
│   ├── Core/
│   │   ├── CarouselItem.swift
│   │   └── CarouselItemDataSourceProviderType.swift
│   ├── CarouselItemProvider/
│   │   └── CarouselItemDataSourceProvider.swift
│   └── CarouselItems/    # Individual character items
├── Assets.xcassets/      # Images and resources
└── Utilities/           # Helper extensions
```

## 🛠️ Technical Stack

- **Language**: Swift 5.0+
- **Framework**: UIKit
- **Dependency Management**: CocoaPods
- **Layout**: SnapKit (Auto Layout DSL)
- **Minimum iOS Version**: iOS 9.0+

### Dependencies

- **SnapKit**: Modern Auto Layout DSL for iOS
  - Provides clean, readable constraint syntax
  - Reduces boilerplate code for layout management

## 🚀 Getting Started

### Prerequisites

- Xcode 12.0 or later
- iOS 9.0+ deployment target
- CocoaPods installed

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd "Vought Showcase"
   ```

2. **Install dependencies**
   ```bash
   pod install
   ```

3. **Open the workspace**
   ```bash
   open "Vought Showcase.xcworkspace"
   ```

4. **Build and run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run the project

## 🎯 Usage

### Main Interface
- The app launches with a background carousel showing character images
- A "Show Stories" button is centered on the screen
- Tap the button to launch the full-screen story experience

### Story Navigation
- **Auto-progression**: Stories automatically advance every 3 seconds
- **Manual navigation**: 
  - Tap left side (30% of screen) to go to previous story
  - Tap right side (30% of screen) to go to next story
- **Dismiss**: Swipe down to close the story view

### Progress Bar
- Segmented progress bar shows current story position
- Each segment represents one character/story
- Visual feedback for story progression and navigation

## 🔧 Customization

### Adding New Characters

1. Create a new carousel item class implementing `CarouselItem`:
   ```swift
   class NewCharacterCarouselItem: CarouselItem {
       func getController() -> UIViewController {
           // Return your custom view controller
       }
   }
   ```

2. Add the character to `CarouselItemDataSourceProvider`:
   ```swift
   func items() -> [CarouselItem] {
       return [
           // ... existing items
           NewCharacterCarouselItem(),
       ]
   }
   ```

### Modifying Story Duration

Update the duration parameter in `CarouselViewController`:
```swift
progressBar = SegmentedProgressBar(numberOfSegments: items.count, duration: 5.0) // Change from 3.0 to desired duration
```

### Customizing Progress Bar

The `SegmentedProgressBar` supports various customization options:
- `topColor`: Color of filled segments
- `bottomColor`: Color of unfilled segments
- `padding`: Space between segments

## 🧪 Testing

The project includes both unit tests and UI tests:

- **Unit Tests**: `Vought ShowcaseTests/`
- **UI Tests**: `Vought ShowcaseUITests/`

Run tests using `Cmd + U` in Xcode.

## 📱 Screenshots



## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request



---
