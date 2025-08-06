import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final isTablet =
        MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width < 1200;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.5),
            Colors.black.withOpacity(0.8),
          ],
        ),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
              child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 48,
              vertical: 24,
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main Title
              Text(
                'JAFARIYA SQUAD',
                style: TextStyle(
                  fontSize: isMobile
                      ? 32
                      : isTablet
                      ? 48
                      : 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.5, end: 0),

              const SizedBox(height: 16),

              // Tagline
              Text(
                    'Unity • Devotion • Service',
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 24,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFFD32F2F),
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 200.ms)
                  .slideY(begin: 0.5, end: 0),

              const SizedBox(height: 32),

              // Description
              Container(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? double.infinity : 600,
                    ),
                    child: Text(
                      'A dedicated team of Shia Muslim youth organizing events and serving the Jafariya Colony community in Lucknow, Uttar Pradesh, India.',
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 400.ms)
                  .slideY(begin: 0.5, end: 0),

              const SizedBox(height: 48),

              // Location Card
              Container(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? double.infinity : 500,
                    ),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: const Color(0xFFD32F2F),
                              size: isMobile ? 20 : 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Jafariya Colony, Lucknow',
                              style: TextStyle(
                                fontSize: isMobile ? 16 : 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Muftiganj, Daulatganj, Lucknow, Uttar Pradesh 226003',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => _openGoogleMaps(),
                          icon: const Icon(Icons.map, size: 18),
                          label: const Text('View on Google Maps'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD32F2F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 600.ms)
                  .slideY(begin: 0.5, end: 0),

              const Spacer(),

              // Scroll Indicator
              Column(
                children: [
                  Text(
                    'Scroll to explore',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white.withOpacity(0.7),
                    size: 24,
                  ),
                ],
              ).animate().fadeIn(duration: 800.ms, delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  void _openGoogleMaps() async {
    const url =
        'https://www.google.com/maps/place/Jafaria+Colony,+Muftiganj,+Daulatganj,+Lucknow,+Uttar+Pradesh+226003';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
