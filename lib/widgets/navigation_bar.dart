import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(String)? onSectionTap;

  const CustomNavigationBar({super.key, this.onSectionTap});

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
            ? Theme.of(context).colorScheme.surface.withOpacity(0.95)
            : Colors.black.withOpacity(0.3),
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
                          color: Colors.white,
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
                  title: 'Forms',
                  onTap: () => _scrollToSection('forms'),
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
                icon: Icon(Icons.brightness_6, color: Colors.white),
              ),

              // Mobile Menu Button
              if (isMobile)
                IconButton(
                  onPressed: () {
                    _showMobileMenu(context);
                  },
                  icon: Icon(Icons.menu, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  void _scrollToSection(String section) {
    widget.onSectionTap?.call(section);
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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

            const Divider(height: 1),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  _MobileNavItem(
                    title: 'Home',
                    icon: Icons.home,
                    onTap: () => _scrollToSection('home'),
                  ),
                  _MobileNavItem(
                    title: 'Team',
                    icon: Icons.people,
                    onTap: () => _scrollToSection('team'),
                  ),
                  _MobileNavItem(
                    title: 'Events',
                    icon: Icons.event,
                    onTap: () => _scrollToSection('events'),
                  ),
                  _MobileNavItem(
                    title: 'Gallery',
                    icon: Icons.photo_library,
                    onTap: () => _scrollToSection('gallery'),
                  ),
                  _MobileNavItem(
                    title: 'Forms',
                    icon: Icons.description,
                    onTap: () => _scrollToSection('forms'),
                  ),
                  _MobileNavItem(
                    title: 'Contact',
                    icon: Icons.contact_mail,
                    onTap: () => _scrollToSection('contact'),
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      // Theme toggle
                    },
                    icon: Icon(
                      Icons.brightness_6,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Share
                    },
                    icon: Icon(Icons.share, color: Colors.grey[600], size: 24),
                  ),
                  IconButton(
                    onPressed: () {
                      // Settings
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD32F2F), size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
