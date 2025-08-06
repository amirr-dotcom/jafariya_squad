import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/hero_section.dart';
import '../widgets/team_section.dart';
import '../widgets/event_section.dart';
import '../widgets/gallery_section.dart';
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section with Lightning Animation
                Stack(
                  children: [
                    const HeroSection(),
                    const LightningAnimation(),
                  ],
                ),
                
                // Team Section
                const TeamSection()
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
                
                // Event Section
                const EventSection()
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
                
                // Gallery Section
                const GallerySection()
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
                
                // Contact Section
                const ContactSection()
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
          
          // Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: const CustomNavigationBar(),
            ),
          ),
        ],
      ),
    );
  }
} 