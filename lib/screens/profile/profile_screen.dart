import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/routes.dart';
import '../../services/auth_service.dart';
import '../../utils/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final authService = AuthService();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildProfileHeader(user),
            const SizedBox(height: 32),
            _buildStatCards(),
            const SizedBox(height: 32),
            _buildMenuSection(context, authService),
            const SizedBox(height: 40),
            _buildLogoutButton(context, authService),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(User? user) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 56,
                  backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                  child: user?.photoURL == null ? const Icon(Icons.person, size: 60, color: Colors.grey) : null,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          user?.displayName ?? 'NexHire User',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          user?.email ?? 'user@example.com',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildStatCards() {
    return Row(
      children: [
        _statItem('12', 'Applied'),
        const SizedBox(width: 16),
        _statItem('4', 'Interviews'),
        const SizedBox(width: 16),
        _statItem('85%', 'Match'),
      ],
    );
  }

  Widget _statItem(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, AuthService authService) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _menuItem(Icons.person_outline_rounded, 'Personal Info'),
          _divider(),
          _menuItem(Icons.description_outlined, 'My Resume'),
          _divider(),
          _menuItem(Icons.bookmark_outline_rounded, 'Saved Jobs'),
          _divider(),
          _menuItem(Icons.notifications_none_rounded, 'Job Alerts'),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      onTap: () {},
    );
  }

  Widget _divider() {
    return Divider(height: 1, indent: 24, endIndent: 24, color: Colors.grey.withOpacity(0.1));
  }

  Widget _buildLogoutButton(BuildContext context, AuthService authService) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: () async {
          await authService.logout();
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
          }
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.red.withOpacity(0.2)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          foregroundColor: Colors.red,
        ),
        child: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
