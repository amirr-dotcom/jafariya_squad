import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventSection extends StatelessWidget {
  const EventSection({super.key});

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
            'Annual Events',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 16),

          Text(
                'Celebrating our traditions and community spirit',
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

          // Main Event Card
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('events').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return _buildFallbackEvent(context, isMobile, isTablet);
              }

              final events = snapshot.data?.docs ?? [];

              if (events.isEmpty) {
                return _buildFallbackEvent(context, isMobile, isTablet);
              }

              return Column(
                children: events.map((event) {
                  final eventData = event.data() as Map<String, dynamic>;
                  return _EventCard(
                        title: eventData['title'] ?? 'Annual Juloos',
                        description: eventData['description'] ?? '',
                        date: eventData['date'] ?? DateTime.now(),
                        imageUrl: eventData['imageUrl'],
                        isMobile: isMobile,
                        isTablet: isTablet,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.3, end: 0);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackEvent(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return _EventCard(
      title: 'Annual Juloos',
      description:
          'Join us for the annual Juloos procession, a significant event that brings our community together in unity and devotion. This year\'s event promises to be even more special with enhanced arrangements and community participation.',
      date: DateTime.now().add(const Duration(days: 30)),
      imageUrl: null,
      isMobile: isMobile,
      isTablet: isTablet,
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }
}

class _EventCard extends StatefulWidget {
  final String title;
  final String description;
  final DateTime date;
  final String? imageUrl;
  final bool isMobile;
  final bool isTablet;

  const _EventCard({
    required this.title,
    required this.description,
    required this.date,
    this.imageUrl,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  late DateTime _now;
  late Duration _timeUntilEvent;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timeUntilEvent = widget.date.difference(_now);

    // Update countdown every second
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
          _timeUntilEvent = widget.date.difference(_now);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: widget.isMobile ? double.infinity : 800,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
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
          // Event Image
          if (widget.imageUrl != null)
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
                ),
              ),
              child: const Center(
                child: Icon(Icons.event, color: Colors.white, size: 80),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: widget.isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 16),

                // Countdown Timer
                _CountdownTimer(timeUntilEvent: _timeUntilEvent),

                const SizedBox(height: 24),

                // Event Description
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: widget.isMobile ? 16 : 18,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.8),
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 32),

                // Timeline
                _TimelineSection(),

                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Register for event
                        },
                        icon: const Icon(Icons.event_available),
                        label: const Text('Register for Event'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD32F2F),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Share event
                        },
                        icon: const Icon(Icons.share),
                        label: const Text('Share Event'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFD32F2F),
                          side: const BorderSide(color: Color(0xFFD32F2F)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownTimer extends StatelessWidget {
  final Duration timeUntilEvent;

  const _CountdownTimer({required this.timeUntilEvent});

  @override
  Widget build(BuildContext context) {
    final days = timeUntilEvent.inDays;
    final hours = timeUntilEvent.inHours % 24;
    final minutes = timeUntilEvent.inMinutes % 60;
    final seconds = timeUntilEvent.inSeconds % 60;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD32F2F).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD32F2F).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            'Event starts in',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _TimeUnit(value: days, label: 'Days'),
              _TimeUnit(value: hours, label: 'Hours'),
              _TimeUnit(value: minutes, label: 'Minutes'),
              _TimeUnit(value: seconds, label: 'Seconds'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeUnit extends StatelessWidget {
  final int value;
  final String label;

  const _TimeUnit({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFD32F2F),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class _TimelineSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timelineItems = [
      {
        'title': 'Planning Phase',
        'description': 'Event planning and coordination',
        'days': 30,
      },
      {
        'title': 'Preparation',
        'description': 'Logistics and arrangements',
        'days': 15,
      },
      {
        'title': 'Final Week',
        'description': 'Last-minute preparations',
        'days': 7,
      },
      {'title': 'Event Day', 'description': 'The main celebration', 'days': 0},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Timeline',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        ...timelineItems.map(
          (item) => _TimelineItem(
            title: item['title'] as String,
            description: item['description'] as String,
            days: item['days'] as int,
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String description;
  final int days;

  const _TimelineItem({
    required this.title,
    required this.description,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (days > 0)
            Text(
              '$days days',
              style: TextStyle(
                color: const Color(0xFFD32F2F),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}
