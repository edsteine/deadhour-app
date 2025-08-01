import 'services/web_companion_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_theme.dart';
/// Screen for managing browser extension and web companion features
class WebCompanionScreen extends StatefulWidget {
  const WebCompanionScreen({super.key});

  @override
  State<WebCompanionScreen> createState() => _WebCompanionScreenState();
}

class _WebCompanionScreenState extends State<WebCompanionScreen> {
  final WebCompanionService _webService = WebCompanionService();
  String _selectedBrowser = 'chrome';

  @override
  void initState() {
    super.initState();
    _webService.initializeWebCompanion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browser Extension'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeaderSection(),
            const SizedBox(height: 24),

            // Features section
            _buildFeaturesSection(),
            const SizedBox(height: 24),

            // Installation section
            _buildInstallationSection(),
            const SizedBox(height: 24),

            // Bookmarklet section
            _buildBookmarkletSection(),
            const SizedBox(height: 24),

            // Supported websites
            _buildSupportedWebsitesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.moroccoGreen,
            AppTheme.moroccoGreen.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.extension,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DeadHour Browser Extension',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Find Morocco deals while browsing',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Get notified about better DeadHour deals when browsing international booking sites. Like Honey for coupons, but for Morocco\'s dead hour deals with cashback.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {
        'icon': Icons.notifications_active,
        'title': 'Smart Deal Notifications',
        'description': 'Get alerts when browsing travel sites about better Morocco deals',
        'color': Colors.blue,
      },
      {
        'icon': Icons.auto_mode,
        'title': 'Auto-Deal Detection',
        'description': 'Automatically finds DeadHour alternatives while you browse',
        'color': AppTheme.moroccoGreen,
      },
      {
        'icon': Icons.monetization_on,
        'title': 'Cashback Alerts',
        'description': 'Shows potential cashback earnings on Morocco bookings',
        'color': Colors.orange,
      },
      {
        'icon': Icons.compare_arrows,
        'title': 'Price Comparison',
        'description': 'Compare international prices with local Morocco deals',
        'color': Colors.purple,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Extension Features',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...features.map((feature) => _buildFeatureCard(feature)),
      ],
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: feature['color'].withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature['icon'],
              color: feature['color'],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstallationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Install Browser Extension',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Browser selection
        Row(
          children: [
            _buildBrowserButton('chrome', 'Chrome', Icons.web),
            const SizedBox(width: 12),
            _buildBrowserButton('firefox', 'Firefox', Icons.web_asset),
          ],
        ),
        const SizedBox(height: 16),

        // Installation instructions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _selectedBrowser == 'chrome' ? Icons.web : Icons.web_asset,
                    color: AppTheme.moroccoGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Installation Instructions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _webService.getInstallationInstructions()[_selectedBrowser] ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Download button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _downloadExtension,
            icon: const Icon(Icons.download),
            label: Text('Download ${_selectedBrowser == 'chrome' ? 'Chrome' : 'Firefox'} Extension'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppTheme.moroccoGreen,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrowserButton(String browser, String label, IconData icon) {
    final isSelected = _selectedBrowser == browser;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedBrowser = browser;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.moroccoGreen.withValues(alpha: 0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.moroccoGreen : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? AppTheme.moroccoGreen : Colors.grey,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppTheme.moroccoGreen : AppTheme.primaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookmarkletSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Setup: Bookmarklet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Can\'t install extensions? Use our bookmarklet for instant access on any browser.',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryText,
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.bookmark_add,
                    color: Colors.amber,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Bookmarklet Instructions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _webService.getInstallationInstructions()['bookmarklet'] ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Copy bookmarklet button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _copyBookmarklet,
            icon: const Icon(Icons.copy),
            label: const Text('Copy Bookmarklet Code'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.amber),
              foregroundColor: Colors.amber.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportedWebsitesSection() {
    final websites = [
      {'name': 'Booking.com', 'icon': '🏨', 'category': 'Hotels'},
      {'name': 'Airbnb', 'icon': '🏠', 'category': 'Accommodations'},
      {'name': 'TripAdvisor', 'icon': '✈️', 'category': 'Travel'},
      {'name': 'Expedia', 'icon': '🌍', 'category': 'Travel'},
      {'name': 'Agoda', 'icon': '🏖️', 'category': 'Hotels'},
      {'name': 'Hotels.com', 'icon': '🛏️', 'category': 'Hotels'},
      {'name': 'VisitMorocco.com', 'icon': '🇲🇦', 'category': 'Local'},
      {'name': 'Restaurant.ma', 'icon': '🍽️', 'category': 'Dining'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Supported Websites',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'The extension works on these popular booking and travel websites.',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryText,
          ),
        ),
        const SizedBox(height: 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3,
          ),
          itemCount: websites.length,
          itemBuilder: (context, index) {
            final website = websites[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Text(
                    website['icon']!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          website['name']!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          website['category']!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _downloadExtension() {
    // In a real app, this would trigger a download
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Extension Download'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('The ${_selectedBrowser == 'chrome' ? 'Chrome' : 'Firefox'} extension is being prepared for download.'),
            const SizedBox(height: 16),
            const Text(
              'Note: This is a demo. In the full version, you would download extension files and follow the installation instructions.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryText,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _copyBookmarklet() {
    final bookmarklet = _webService.generateBookmarklet();
    Clipboard.setData(ClipboardData(text: bookmarklet));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Bookmarklet code copied to clipboard!'),
          ],
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }
}