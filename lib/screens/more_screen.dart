import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildListTile(
          context,
          'About the App',
          Icons.info_outline,
          () => _showAboutDialog(context),
        ),
        const Divider(),
        _buildListTile(
          context,
          'Privacy Policy',
          Icons.privacy_tip_outlined,
          () => _showPrivacyPolicy(context),
        ),
        const Divider(),
        _buildListTile(
          context,
          'Contact Us',
          Icons.mail_outline,
          () => _showContactInfo(context),
        ),
        const Divider(),
        _buildListTile(
          context,
          'Theme',
          Icons.dark_mode_outlined,
          () => _toggleTheme(context),
          trailing: Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (_) => _toggleTheme(context),
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Assam GK & Current Affairs'),
            SizedBox(height: 8),
            Text('Version: 1.0.0'),
            SizedBox(height: 8),
            Text('A comprehensive app for learning about Assam\'s geography, history, culture, and current affairs.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'This app does not collect any personal information. '
            'All study materials are stored locally on your device. '
            'We respect your privacy and ensure that your learning experience is completely private.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showContactInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Us'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('support@assamgk.com'),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Website'),
              subtitle: Text('www.assamgk.com'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _toggleTheme(BuildContext context) {
    // TODO: Implement theme toggling
  }
}
