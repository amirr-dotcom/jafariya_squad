import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/hero_section.dart';
import '../widgets/team_section.dart';
import '../widgets/event_section.dart';
import '../widgets/gallery_section.dart';
import '../widgets/forms_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/lightning_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _teamKey = GlobalKey();
  final GlobalKey _eventsKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _formsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    switch (section) {
      case 'team':
        _scrollToKey(_teamKey);
        break;
      case 'events':
        _scrollToKey(_eventsKey);
        break;
      case 'gallery':
        _scrollToKey(_galleryKey);
        break;
      case 'forms':
        _scrollToKey(_formsKey);
        break;
      case 'contact':
        _scrollToKey(_contactKey);
        break;
      case 'home':
      default:
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        break;
    }
  }

  void _scrollToKey(GlobalKey key) {
    // Wait for the next frame to ensure the widget is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final offset =
            position.dy - 120; // Account for header height + safe area

        // Ensure we don't scroll to negative values
        final targetOffset = offset > 0 ? offset.toDouble() : 0.0;

        _scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _scrollToExplore() {
    _scrollToKey(_teamKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lightning Animation (non-interfering)
          const LightningAnimation(),

          // Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                HeroSection(onScrollToExplore: _scrollToExplore),

                // Team Section
                Container(key: _teamKey, child: const TeamSection()),

                // Event Section
                Container(key: _eventsKey, child: const EventSection()),

                // Gallery Section
                Container(key: _galleryKey, child: const GallerySection()),

                // Forms Section
                Container(key: _formsKey, child: const FormsSection()),

                // Contact Section
                Container(key: _contactKey, child: const ContactSection()),
              ],
            ),
          ),

          // Navigation Bar (floating)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavigationBar(onSectionTap: _scrollToSection),
          ),
        ],
      ),
    );
  }
}
