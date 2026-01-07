import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String actionText;

  const HomeCard({
    super.key, 
    required this.onTap,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                actionText,
                style: const TextStyle(
                  fontFamily: 'DMSans',
                  color: Color(0xFF1BA38C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
