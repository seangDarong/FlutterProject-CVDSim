import 'package:cvd_sim/ui/widgets/home_screen/home_card.dart';
import 'package:cvd_sim/ui/widgets/home_screen/info_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),


      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'CVDSim',
                style: TextStyle(fontFamily: 'DM Sans'),
              ),
              SizedBox(width: 8),
              Hero(
                tag: 'eye-logo',
                child: Icon(
                  Icons.remove_red_eye,
                  size: 40,
                  color: Color(0xFF1BA38C),
                ),
              ),
            ],
          ),
        ),
      ),
  body: SingleChildScrollView(
  padding: const EdgeInsets.all(24),
  child: Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Column(
        children: [
          const SizedBox(height: 12),

          const Text(
            'Understand color vision deficiency through',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            'simulation and self-assessment tools.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 24),

          
          HomeCard(
            onTap: () => context.push('/simulator'),
            icon: Icons.camera_alt_outlined,
            iconColor: const Color(0xFF1BA38C),
            title: 'CVD Simulation',
            description:
                'See the world through the eyes of someone with color vision deficiency using your camera.',
            actionText: 'Get started ››',
          ),

          const SizedBox(height: 24),

          
          const InfoCard(),
        ],
      ),
    ),
  ),
),

    );
  }
}
