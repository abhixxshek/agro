import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../core/widgets/app_drawer.dart';
import '../../core/widgets/custom_card.dart';
import '../../providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('AgroSmart Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.help),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
        ],
      ),
      drawer: const AppDrawer(currentRoute: AppRoutes.dashboard),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.heroGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.wb_sunny_outlined, color: Colors.amber, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'Hello, ${user?.username ?? 'Farmer'}!',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Welcome to your smart farming assistant. Select a tool below to make data-driven decisions.',
                    style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.85)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'ML Precision Tools',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),

            // Feature Cards Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.1,
              children: [
                _buildGridCard(
                  context,
                  title: 'Crop Rec.',
                  subtitle: 'Soil & Climate ML',
                  icon: Icons.grass_rounded,
                  color: const Color(0xFF2E7D32),
                  route: AppRoutes.cropRecommend,
                ),
                _buildGridCard(
                  context,
                  title: 'Fertilizer',
                  subtitle: 'NPK Optimization',
                  icon: Icons.science_rounded,
                  color: const Color(0xFF00796B),
                  route: AppRoutes.fertilizerRecommend,
                ),
                _buildGridCard(
                  context,
                  title: 'Yield Predict',
                  subtitle: 'Decision Tree ML',
                  icon: Icons.show_chart_rounded,
                  color: const Color(0xFFE65100),
                  route: AppRoutes.yieldPredict,
                ),
                _buildGridCard(
                  context,
                  title: 'Weather',
                  subtitle: 'Forecast & Spray',
                  icon: Icons.cloud_sync_rounded,
                  color: const Color(0xFF0277BD),
                  route: AppRoutes.weatherForecast,
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Insights & Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),

            // Wide Feature Cards
            _buildWideCard(
              context,
              title: 'Agricultural Data Analytics',
              subtitle: 'Cost of production, cultivation area & rainfall charts',
              icon: Icons.pie_chart_rounded,
              color: Colors.purple.shade700,
              route: AppRoutes.analysis,
            ),
            const SizedBox(height: 12),
            _buildWideCard(
              context,
              title: 'Help & Knowledge Center',
              subtitle: 'FAQs, crop advice guide & support helpline',
              icon: Icons.help_outline_rounded,
              color: Colors.teal.shade800,
              route: AppRoutes.help,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return CustomCard(
      onTap: () => Navigator.pushNamed(context, route),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWideCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return CustomCard(
      onTap: () => Navigator.pushNamed(context, route),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }
}
