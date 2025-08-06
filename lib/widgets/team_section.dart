import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

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
            'Our Team',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 16),

          Text(
                'Meet the dedicated members who make it all possible',
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

          // Team Members Grid
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('team_members')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return _buildFallbackTeam(context, isMobile, isTablet);
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final members = snapshot.data?.docs ?? [];

              if (members.isEmpty) {
                return _buildFallbackTeam(context, isMobile, isTablet);
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile
                      ? 1
                      : isTablet
                      ? 2
                      : 3,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: isMobile ? 1.6 : 1.5,
                ),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index].data() as Map<String, dynamic>;
                  return _TeamMemberCard(
                        name: member['name'] ?? 'Unknown',
                        role: member['role'] ?? 'Member',
                        imageUrl: member['imageUrl'],
                        description: member['description'] ?? '',
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: (index * 100).ms)
                      .slideY(begin: 0.3, end: 0);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackTeam(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    final fallbackMembers = [
      {
        'name': 'Syed Ali Raza',
        'role': 'President',
        'description': 'Leading the team with vision and dedication',
        'imageUrl': null,
      },
      {
        'name': 'Syed Hassan',
        'role': 'Treasurer',
        'description': 'Managing finances and resources efficiently',
        'imageUrl': null,
      },
      {
        'name': 'Syed Abbas',
        'role': 'Event Manager',
        'description': 'Coordinating events and community activities',
        'imageUrl': null,
      },
      {
        'name': 'Volunteer Team',
        'role': 'Active Members',
        'description': 'Dedicated volunteers serving the community',
        'imageUrl': null,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile
            ? 1
            : isTablet
            ? 2
            : 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isMobile ? 1.6 : 1.5,
      ),
      itemCount: fallbackMembers.length,
      itemBuilder: (context, index) {
        final member = fallbackMembers[index];
        return _TeamMemberCard(
              name: member['name']!,
              role: member['role']!,
              imageUrl: member['imageUrl'],
              description: member['description']!,
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: (index * 100).ms)
            .slideY(begin: 0.3, end: 0);
      },
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String? imageUrl;
  final String description;

  const _TeamMemberCard({
    required this.name,
    required this.role,
    this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          // Profile Image
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD32F2F).withOpacity(0.1),
            ),
            child: imageUrl != null
                ? ClipOval(
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar();
                      },
                    ),
                  )
                : _buildDefaultAvatar(),
          ),

          // Member Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD32F2F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    role,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const Spacer(),

          // Contact Button
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Contact functionality would be implemented here
                },
                icon: const Icon(Icons.message, size: 12),
                label: const Text('Contact', style: TextStyle(fontSize: 10)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFD32F2F),
                  side: const BorderSide(color: Color(0xFFD32F2F)),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFD32F2F),
      ),
      child: const Icon(Icons.person, color: Colors.white, size: 36),
    );
  }
}
