import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class FormsSection extends StatelessWidget {
  const FormsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final isTablet =
        MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width < 1200;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[50]!, Colors.white, Colors.grey[50]!],
        ),
      ),
      child: Column(
        children: [
          // Section Title
          Text(
            'Forms & Documents',
            style: TextStyle(
              fontSize: isMobile
                  ? 32
                  : isTablet
                  ? 40
                  : 48,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD32F2F),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 16),

          // Subtitle
          Container(
                constraints: BoxConstraints(
                  maxWidth: isMobile ? double.infinity : 600,
                ),
                child: Text(
                  'Download important forms and documents for Jafariya Squad events and activities.',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: 0.3, end: 0),

          const SizedBox(height: 60),

          // Forms Grid
          Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 800,
            ),
            child: Column(
              children: [
                // Nomination Form Card
                Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Icon
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD32F2F).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.description,
                              size: 40,
                              color: Color(0xFFD32F2F),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Title
                          Text(
                            'Nomination Form',
                            style: TextStyle(
                              fontSize: isMobile ? 20 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 12),

                          // Description
                          Text(
                            'Official nomination form for Jafariya Squad membership and event participation. Fill out this form to join our team or participate in our events.',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 24),

                          // Download Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () =>
                                    _downloadNominationForm(context),
                                icon: const Icon(Icons.download, size: 20),
                                label: Text(
                                  'Download Form',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD32F2F),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 16),

                              // Preview Button
                              OutlinedButton.icon(
                                onPressed: () => _previewForm(context),
                                icon: const Icon(Icons.visibility, size: 20),
                                label: Text(
                                  'Preview',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFD32F2F),
                                  side: const BorderSide(
                                    color: Color(0xFFD32F2F),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 400.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 40),

                // Additional Info
                Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD32F2F).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFD32F2F).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: const Color(0xFFD32F2F),
                                size: isMobile ? 20 : 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Form Instructions',
                                style: TextStyle(
                                  fontSize: isMobile ? 16 : 18,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFD32F2F),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Text(
                            '• Download the form and fill it out completely\n• Attach required documents and photos\n• Submit the completed form to our team\n• We will review and contact you within 3-5 days',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: Colors.grey[700],
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 600.ms)
                    .slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _downloadNominationForm(BuildContext context) {
    _showDownloadDialog(context);
  }

  void _previewForm(BuildContext context) {
    // Show a preview dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nomination Form Preview'),
        content: const Text(
          'This is the official Jafariya Squad nomination form. '
          'It includes sections for personal information, contact details, '
          'and event preferences. Please download the form to fill it out.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _downloadNominationForm(context);
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  void _showDownloadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Nomination Form'),
        content: const Text(
          'The nomination form will be downloaded. '
          'Please fill it out completely and submit it to our team.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _triggerDownload();
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  void _triggerDownload() {
    // For web, we'll use a direct link to the asset
    // This will trigger the browser's download behavior
    final url = Uri.parse('assets/forms/nomination_form.xlsx');
    launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
