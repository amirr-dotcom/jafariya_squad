import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

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
      child: Column(
        children: [
          // Section Header
          Text(
            'Media Gallery',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 16),

          Text(
                'Capturing moments of unity and devotion',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: 0.3, end: 0),

          const SizedBox(height: 64),

          // Gallery Tabs
          _GalleryTabs(),

          const SizedBox(height: 32),

          // Gallery Content
          _GalleryContent(isMobile: isMobile, isTablet: isTablet),
        ],
      ),
    );
  }
}

class _GalleryTabs extends StatefulWidget {
  @override
  State<_GalleryTabs> createState() => _GalleryTabsState();
}

class _GalleryTabsState extends State<_GalleryTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = ['Images', 'Videos', 'Highlights'];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = _selectedTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFD32F2F)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _GalleryContent extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const _GalleryContent({required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('gallery').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildFallbackGallery(context);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final images = snapshot.data?.docs ?? [];

        if (images.isEmpty) {
          return _buildFallbackGallery(context);
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile
                ? 2
                : isTablet
                ? 3
                : 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            final imageData = images[index].data() as Map<String, dynamic>;
            return _GalleryItem(
                  imageUrl: imageData['imageUrl'] as String?,
                  title: imageData['title'] as String? ?? 'Gallery Image',
                  description: imageData['description'] as String? ?? '',
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: (index * 100).ms)
                .slideY(begin: 0.3, end: 0);
          },
        );
      },
    );
  }

  Widget _buildFallbackGallery(BuildContext context) {
    final fallbackImages = [
      'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
      'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
      'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
      'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile
            ? 2
            : isTablet
            ? 3
            : 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: fallbackImages.length,
      itemBuilder: (context, index) {
        return _GalleryItem(
              imageUrl: fallbackImages[index],
              title: 'Community Event ${index + 1}',
              description: 'Capturing the spirit of unity and devotion',
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: (index * 100).ms)
            .slideY(begin: 0.3, end: 0);
      },
    );
  }
}

class _GalleryItem extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String description;

  const _GalleryItem({
    this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImageDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Image
              if (imageUrl != null)
                CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) => Container(
                    color: const Color(0xFFD32F2F).withOpacity(0.1),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: const Color(0xFFD32F2F).withOpacity(0.1),
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        color: Color(0xFFD32F2F),
                        size: 48,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  color: const Color(0xFFD32F2F).withOpacity(0.1),
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      color: Color(0xFFD32F2F),
                      size: 48,
                    ),
                  ),
                ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              // Zoom icon
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            // Backdrop
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(color: Colors.black.withOpacity(0.8)),
              ),
            ),

            // Image
            if (imageUrl != null)
              Center(
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error, color: Colors.white, size: 48),
                  ),
                ),
              ),

            // Close button
            Positioned(
              top: 40,
              right: 40,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
