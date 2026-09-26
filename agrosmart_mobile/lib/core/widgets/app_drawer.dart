import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            accountName: Text(
              user?.username ?? 'Farmer User',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(user?.email ?? 'farmer@agrosmart.org'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                (user?.username.isNotEmpty ?? false) ? user!.username[0].toUpperCase() : 'A',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: 'Dashboard',
                  route: AppRoutes.dashboard,
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.grass_outlined,
                  title: 'Crop Recommendation',
                  route: AppRoutes.cropRecommend,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.science_outlined,
                  title: 'Fertilizer Recommendation',
                  route: AppRoutes.fertilizerRecommend,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.bar_chart_outlined,
                  title: 'Yield Prediction',
                  route: AppRoutes.yieldPredict,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.cloud_outlined,
                  title: 'Weather Forecast',
                  route: AppRoutes.weatherForecast,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.pie_chart_outline,
                  title: 'Agricultural Analytics',
                  route: AppRoutes.analysis,
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'My Profile',
                  route: AppRoutes.profile,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  route: AppRoutes.help,
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text('Logout', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600)),
            onTap: () {
              authProvider.logout();
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    final isSelected = currentRoute == route;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        Navigator.pop(context); // Close drawer
        if (!isSelected) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}
