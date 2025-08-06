import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final isTablet = MediaQuery.of(context).size.width >= 800 && MediaQuery.of(context).size.width < 1200;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          // Section Header
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 16),
          
          Text(
            'Get in touch with our team',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 64),
          
          // Contact Content
          if (isMobile)
            Column(
              children: [
                _ContactForm(),
                const SizedBox(height: 32),
                _MapSection(),
                const SizedBox(height: 32),
                _SocialMediaSection(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _ContactForm(),
                      const SizedBox(height: 32),
                      _SocialMediaSection(),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 1,
                  child: _MapSection(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send us a message',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            
            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Email Field
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Message Field
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Send Message',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      
      // Simulate form submission
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: Color(0xFFD32F2F),
          ),
        );
        
        // Clear form
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      }
    }
  }
}

class _MapSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Map placeholder
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFD32F2F).withOpacity(0.1),
                    const Color(0xFFB71C1C).withOpacity(0.1),
                  ],
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 64,
                      color: Color(0xFFD32F2F),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Jafariya Colony, Lucknow',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Muftiganj, Daulatganj, Lucknow\nUttar Pradesh 226003',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Map overlay with location info
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Jafariya Colony, Lucknow',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _openGoogleMaps(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD32F2F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: const Text('Directions'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.3, end: 0);
  }

  void _openGoogleMaps() async {
    const url = 'https://www.google.com/maps/place/Jafaria+Colony,+Muftiganj,+Daulatganj,+Lucknow,+Uttar+Pradesh+226003';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class _SocialMediaSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socialLinks = [
      {
        'name': 'WhatsApp',
        'icon': Icons.message,
        'color': const Color(0xFF25D366),
        'url': 'https://wa.me/919876543210',
      },
      {
        'name': 'Telegram',
        'icon': Icons.telegram,
        'color': const Color(0xFF0088CC),
        'url': 'https://t.me/jafariyasquad',
      },
      {
        'name': 'Facebook',
        'icon': Icons.facebook,
        'color': const Color(0xFF1877F2),
        'url': 'https://facebook.com/jafariyasquad',
      },
      {
        'name': 'Instagram',
        'icon': Icons.camera_alt,
        'color': const Color(0xFFE4405F),
        'url': 'https://instagram.com/jafariyasquad',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect with us',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: socialLinks.map((link) {
            return _SocialButton(
              name: link['name'] as String,
              icon: link['icon'] as IconData,
              color: link['color'] as Color,
              url: link['url'] as String,
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.3, end: 0);
  }
}

class _SocialButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final String url;

  const _SocialButton({
    required this.name,
    required this.icon,
    required this.color,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
} 