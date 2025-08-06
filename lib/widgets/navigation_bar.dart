import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // Listen to scroll changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkScroll();
      }
    });
  }

  void _checkScroll() {
    // This would be connected to scroll controller in real implementation
    setState(() {
      _isScrolled = false; // Start with transparent navigation
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      decoration: BoxDecoration(
        color: _isScrolled
            ? Theme.of(context).colorScheme.surface.withOpacity(0.8)
            : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              // Logo
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD32F2F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'JS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (!isMobile)
                      const Text(
                        'Jafariya Squad',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                  ],
                ),
              ),

              // Navigation Items
              if (!isMobile) ...[
                _NavItem(title: 'Home', onTap: () => _scrollToSection('home')),
                _NavItem(title: 'Team', onTap: () => _scrollToSection('team')),
                _NavItem(
                  title: 'Events',
                  onTap: () => _scrollToSection('events'),
                ),
                _NavItem(
                  title: 'Gallery',
                  onTap: () => _scrollToSection('gallery'),
                ),
                _NavItem(
                  title: 'Contact',
                  onTap: () => _scrollToSection('contact'),
                ),
              ],

              // Theme Toggle
              IconButton(
                onPressed: () {
                  // Theme toggle would be implemented here
                },
                icon: Icon(
                  Icons.brightness_6,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              // Mobile Menu Button
              if (isMobile)
                IconButton(
                  onPressed: () {
                    _showMobileMenu(context);
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  void _scrollToSection(String section) {
    // Implementation for smooth scrolling to sections
    print('Scrolling to $section');
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _MobileNavItem(
              title: 'Home',
              onTap: () => _scrollToSection('home'),
            ),
            _MobileNavItem(
              title: 'Team',
              onTap: () => _scrollToSection('team'),
            ),
            _MobileNavItem(
              title: 'Events',
              onTap: () => _scrollToSection('events'),
            ),
            _MobileNavItem(
              title: 'Gallery',
              onTap: () => _scrollToSection('gallery'),
            ),
            _MobileNavItem(
              title: 'Contact',
              onTap: () => _scrollToSection('contact'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MobileNavItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
