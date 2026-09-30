import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSection(
          context,
          'Assam GK',
          Icons.book,
          () => Navigator.pushNamed(context, '/chapters'),
        ),
        const SizedBox(height: 16),
        _buildSection(
          context,
          'Current Affairs',
          Icons.newspaper,
          () => Navigator.pushNamed(context, '/current-affairs'),
        ),
        const SizedBox(height: 16),
        _buildLanguageSelector(context),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.language, size: 32),
        title: Text(
          'Language',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        trailing: DropdownButton<String>(
          value: 'English',
          items: const [
            DropdownMenuItem(
              value: 'English',
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: 'Assamese',
              child: Text('Assamese'),
            ),
          ],
          onChanged: (value) {
            // TODO: Implement language change
          },
        ),
      ),
    );
  }
}
