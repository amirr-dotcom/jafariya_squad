# Jafariya Squad - Flutter Web Application

A professional, mobile-responsive Flutter Web UI for Jafariya Squad – a team of Shia Muslim youth who organize events for the Jafariya Colony in Lucknow, Uttar Pradesh, India.

## 🌟 Features

### 🏠 Elegant Homepage
- **Hero Section**: Grand, modern design with background image
- **Lightning Animation**: Impressive animated red lightning effects
- **Location Integration**: Embedded Google Maps for Jafariya Colony
- **Smooth Animations**: Fade-in and slide animations throughout

### 👥 Team Section
- **Member Cards**: Profiles for key team members
  - President
  - Treasurer  
  - Event Manager
  - Volunteers
- **Responsive Design**: Adapts to mobile, tablet, and desktop
- **Contact Integration**: Direct contact buttons for each member

### 📅 Annual Event Section
- **Juloos Event**: Showcase of the main yearly event
- **Countdown Timer**: Real-time countdown to event date
- **Timeline**: Preparation phases and milestones
- **Registration**: Event registration functionality

### 🖼️ Media Gallery
- **Image Grid**: Display images from Firebase Storage
- **YouTube Integration**: Embedded video player for highlights
- **Admin Upload**: Admin panel for content management
- **Responsive Layout**: Adaptive grid for different screen sizes

### 🔧 Admin Panel
- **Secure Login**: Firebase Authentication
- **Content Management**: Upload/remove images and videos
- **Event Management**: Edit event information
- **Team Management**: Update team member details

### 📞 Contact Section
- **Contact Form**: Functional contact form with validation
- **Google Maps**: Embedded map of Jafariya Colony
- **Social Media**: WhatsApp, Telegram, Facebook, Instagram links
- **Responsive Layout**: Mobile-optimized contact interface

## 🛠️ Tech Stack

### Frontend
- **Flutter Web**: Modern web framework
- **Material Design 3**: Latest design system
- **Google Fonts**: Poppins font family
- **Flutter Animate**: Smooth animations

### Backend & Services
- **Firebase Authentication**: Secure admin login
- **Firebase Storage**: Image and video hosting
- **Cloud Firestore**: Dynamic content management
- **Firebase Hosting**: Web deployment

### Responsive Design
- **Mobile-First**: Optimized for mobile devices
- **Tablet Support**: Adaptive layouts for tablets
- **Desktop Experience**: Full-featured desktop interface

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Chrome browser for web development

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd jafariya_squad
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project
   - Enable Authentication, Storage, and Firestore
   - Update Firebase configuration in `lib/main.dart`

4. **Run the application**
   ```bash
   flutter run -d chrome --web-port 8080
   ```

## 📱 Features Overview

### Homepage
- **Hero Section**: Full-screen landing with animated lightning
- **Location Card**: Interactive map integration
- **Smooth Scrolling**: Animated section transitions

### Team Management
- **Member Profiles**: Individual cards with photos and roles
- **Contact Integration**: Direct messaging capabilities
- **Responsive Grid**: Adaptive layout for all devices

### Event Management
- **Countdown Timer**: Real-time event countdown
- **Timeline View**: Preparation phases visualization
- **Registration System**: Event signup functionality

### Media Gallery
- **Image Grid**: Masonry-style image layout
- **Video Player**: YouTube video integration
- **Lightbox View**: Full-screen image viewing
- **Admin Upload**: Content management interface

### Contact System
- **Contact Form**: Validated contact form
- **Map Integration**: Google Maps embedding
- **Social Links**: Direct social media integration
- **Responsive Design**: Mobile-optimized interface

## 🎨 Design Features

### Color Scheme
- **Primary**: Red (#D32F2F) - Islamic theme
- **Secondary**: Gold/Brown accents
- **Background**: Clean white/light theme
- **Dark Mode**: Optional dark theme support

### Typography
- **Font Family**: Poppins (Google Fonts)
- **Hierarchy**: Clear typography scale
- **Readability**: Optimized for web viewing

### Animations
- **Page Transitions**: Smooth fade-in effects
- **Lightning Animation**: Custom animated lightning bolts
- **Hover Effects**: Interactive element animations
- **Loading States**: Professional loading indicators

## 🔧 Configuration

### Firebase Setup
1. Create a new Firebase project
2. Enable Authentication, Storage, and Firestore
3. Update the Firebase configuration in `lib/main.dart`:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "YOUR_API_KEY",
    authDomain: "jafariya-squad.firebaseapp.com",
    projectId: "jafariya-squad",
    storageBucket: "jafariya-squad.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID",
  ),
);
```

### Environment Variables
- Set up Firebase configuration
- Configure admin credentials
- Set up social media links

## 📦 Dependencies

### Core Dependencies
- `flutter`: Core Flutter framework
- `firebase_core`: Firebase initialization
- `firebase_auth`: Authentication services
- `firebase_storage`: File storage
- `cloud_firestore`: Database services

### UI Dependencies
- `google_fonts`: Typography
- `flutter_animate`: Animations
- `cached_network_image`: Image caching
- `url_launcher`: External link handling

### Development Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Code quality

## 🚀 Deployment

### Web Deployment
1. **Build for production**
   ```bash
   flutter build web
   ```

2. **Deploy to Firebase Hosting**
   ```bash
   firebase deploy
   ```

### Firebase Configuration
- Set up Firebase project
- Configure hosting rules
- Set up custom domain (optional)

## 📋 Project Structure

```
lib/
├── main.dart                 # App entry point
├── services/
│   └── firebase_service.dart # Firebase operations
├── providers/
│   ├── auth_provider.dart    # Authentication state
│   └── theme_provider.dart   # Theme management
├── screens/
│   └── home_screen.dart      # Main screen
└── widgets/
    ├── navigation_bar.dart    # Navigation component
    ├── hero_section.dart     # Hero section
    ├── team_section.dart     # Team display
    ├── event_section.dart    # Event showcase
    ├── gallery_section.dart  # Media gallery
    ├── contact_section.dart  # Contact form
    └── lightning_animation.dart # Lightning effects
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:
- **Email**: contact@jafariyasquad.com
- **WhatsApp**: +91 98765 43210
- **Telegram**: @jafariyasquad

## 🙏 Acknowledgments

- **Flutter Team**: For the amazing web framework
- **Firebase**: For backend services
- **Google Fonts**: For typography
- **Community**: For inspiration and support

---

**Jafariya Squad** - Unity • Devotion • Service
# jafariya_squad
