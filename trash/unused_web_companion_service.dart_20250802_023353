import 'dart:async';
import 'dart:convert';



import 'package:deadhour/utils/mock_data.dart';

import 'package:deadhour/screens/deals_screen/models/deal.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_service.dart';




/// Web companion service for browser integration
/// Provides browser extension-like functionality for desktop users
class WebCompanionService {
  static final WebCompanionService _instance = WebCompanionService._internal();
  factory WebCompanionService() => _instance;
  WebCompanionService._internal();

  final CashbackService _cashbackService = CashbackService();
  
  // Browser companion features
  bool _webCompanionEnabled = false;
  String? _companionUrl;
  final Set<String> _watchedDomains = {};
  final Map<String, List<Deal>> _domainDeals = {};

  /// Initialize web companion features
  void initializeWebCompanion() {
    _webCompanionEnabled = true;
    _companionUrl = 'https://app.deadhour.ma/companion';
    
    // Add Morocco-focused domains to watch
    _watchedDomains.addAll([
      'booking.com',
      'airbnb.com', 
      'tripadvisor.com',
      'expedia.com',
      'agoda.com',
      'hotels.com',
      'moroccoworld.com',
      'visitmorocco.com',
      'marrakech.com',
      'casablanca-morocco.com',
      'fes-morocco.com',
      'restaurant.ma',
      'cafes-maroc.com',
      'spa-morocco.com',
      'hammam-marrakech.com',
    ]);

    _loadDealsForDomains();
  }

  /// Check if web companion is enabled
  bool get isWebCompanionEnabled => _webCompanionEnabled;

  /// Get companion URL for browser bookmarklet
  String? get companionUrl => _companionUrl;

  /// Generate bookmarklet code for browser
  String generateBookmarklet() {
    return '''
javascript:(function(){
  var s=document.createElement('script');
  s.src='$_companionUrl/bookmarklet.js';
  s.onload=function(){
    DeadHourCompanion.init({
      apiUrl: '$_companionUrl/api',
      userAgent: 'DeadHour-Companion/1.0'
    });
  };
  document.head.appendChild(s);
})();
''';
  }

  /// Generate browser extension manifest
  Map<String, dynamic> generateExtensionManifest() {
    return {
      'manifest_version': 3,
      'name': 'DeadHour Morocco Deals',
      'version': '1.0.0',
      'description': 'Find dead hour deals and cashback opportunities in Morocco',
      'permissions': [
        'activeTab',
        'storage',
        'notifications'
      ],
      'host_permissions': _watchedDomains.map((d) => 'https://*.$d/*').toList(),
      'background': {
        'service_worker': 'background.js'
      },
      'content_scripts': [
        {
          'matches': _watchedDomains.map((d) => 'https://*.$d/*').toList(),
          'js': ['content.js'],
          'css': ['styles.css']
        }
      ],
      'action': {
        'default_popup': 'popup.html',
        'default_title': 'DeadHour Deals',
        'default_icon': {
          '16': 'icons/icon16.png',
          '32': 'icons/icon32.png',
          '48': 'icons/icon48.png',
          '128': 'icons/icon128.png'
        }
      },
      'icons': {
        '16': 'icons/icon16.png',
        '32': 'icons/icon32.png',
        '48': 'icons/icon48.png',
        '128': 'icons/icon128.png'
      }
    };
  }

  /// Find deals for current website domain
  List<Deal> findDealsForDomain(String domain) {
    final cleanDomain = _cleanDomain(domain);
    return _domainDeals[cleanDomain] ?? [];
  }

  /// Find alternative DeadHour deals for a venue search
  Future<List<Deal>> findAlternativeDeals(String query, String location) async {
    // Simulate finding local deals based on search query
    final deals = MockData.deals.where((deal) {
      final venue = MockData.venues.firstWhere(
        (v) => v.id == deal.venueId,
        orElse: () => MockData.venues.first,
      );
      
      return _matchesSearch(venue.name, query) ||
             _matchesSearch(venue.type, query) ||
             _matchesSearch(venue.category, query);
    }).toList();

    // Sort by relevance and cashback potential
    deals.sort((a, b) {
      final cashbackA = _cashbackService.calculateCashback(a, a.discountedPrice);
      final cashbackB = _cashbackService.calculateCashback(b, b.discountedPrice);
      return cashbackB.cashbackAmount.compareTo(cashbackA.cashbackAmount);
    });

    return deals.take(5).toList();
  }

  /// Generate popup HTML for browser extension
  String generatePopupHtml(String currentDomain) {
    final deals = findDealsForDomain(currentDomain);
    final hasDeals = deals.isNotEmpty;
    
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <style>
        body { 
            width: 320px; 
            padding: 16px; 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            margin: 0;
        }
        .header {
            display: flex;
            align-items: center;
            margin-bottom: 16px;
            padding-bottom: 12px;
            border-bottom: 1px solid #e0e0e0;
        }
        .logo {
            width: 24px;
            height: 24px;
            background: #2E7D32;
            border-radius: 50%;
            margin-right: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 12px;
        }
        .title {
            font-weight: 600;
            font-size: 16px;
            color: #1a1a1a;
        }
        .deal-card {
            padding: 12px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            margin-bottom: 8px;
            background: white;
        }
        .deal-title {
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 4px;
            color: #1a1a1a;
        }
        .deal-venue {
            font-size: 12px;
            color: #666;
            margin-bottom: 8px;
        }
        .deal-price {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .price-new {
            font-weight: bold;
            color: #2E7D32;
            font-size: 16px;
        }
        .price-old {
            text-decoration: line-through;
            color: #999;
            font-size: 12px;
        }
        .cashback {
            background: #E8F5E8;
            color: #2E7D32;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 500;
        }
        .no-deals {
            text-align: center;
            padding: 24px;
            color: #666;
        }
        .cta-button {
            background: #2E7D32;
            color: white;
            border: none;
            padding: 12px 16px;
            border-radius: 8px;
            width: 100%;
            font-weight: 600;
            cursor: pointer;
            margin-top: 12px;
        }
        .cta-button:hover {
            background: #1B5E20;
        }
        .features {
            margin-top: 16px;
            padding-top: 12px;
            border-top: 1px solid #e0e0e0;
        }
        .feature {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
            font-size: 12px;
            color: #666;
        }
        .feature-icon {
            margin-right: 8px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">DH</div>
        <div class="title">DeadHour Morocco</div>
    </div>
    
    ${hasDeals ? _generateDealsHtml(deals) : _generateNoDealsHtml(currentDomain)}
    
    <button class="cta-button" onclick="openApp()">
        ${hasDeals ? 'View All Deals' : 'Discover Morocco Deals'}
    </button>
    
    <div class="features">
        <div class="feature">
            <span class="feature-icon">💰</span>
            Up to 25% cashback on dead hour deals
        </div>
        <div class="feature">
            <span class="feature-icon">🗺️</span>
            Real-time map with live deals
        </div>
        <div class="feature">
            <span class="feature-icon">🤖</span>
            Auto-apply best deals (like Honey)
        </div>
    </div>
    
    <script>
        function openApp() {
            chrome.tabs.create({url: '$_companionUrl'});
        }
        
        function bookDeal(dealId) {
            chrome.tabs.create({url: '$_companionUrl/deal/' + dealId});
        }
    </script>
</body>
</html>
''';
  }

  /// Generate background script for browser extension
  String generateBackgroundScript() {
    return '''
// DeadHour Browser Extension Background Script
chrome.runtime.onInstalled.addListener(() => {
  console.log('DeadHour extension installed');
});

// Monitor tab updates for deal opportunities
chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  if (changeInfo.status === 'complete' && tab.url) {
    checkForDeals(tab.url, tabId);
  }
});

async function checkForDeals(url, tabId) {
  const domain = new URL(url).hostname;
  const watchedDomains = ${jsonEncode(_watchedDomains.toList())};
  
  // Check if this is a watched domain
  const isWatched = watchedDomains.some(d => domain.includes(d));
  
  if (isWatched) {
    // Inject content script to look for deal opportunities
    chrome.scripting.executeScript({
      target: { tabId: tabId },
      func: scanForDealOpportunities
    });
  }
}

function scanForDealOpportunities() {
  // Look for hotel/restaurant/activity searches
  const searchInputs = document.querySelectorAll('input[type="text"], input[type="search"]');
  const priceElements = document.querySelectorAll('[class*="price"], [class*="cost"], [class*="rate"]');
  
  if (searchInputs.length > 0 || priceElements.length > 0) {
    // Show DeadHour notification
    showDeadHourNotification();
  }
}

function showDeadHourNotification() {
  // Create notification overlay
  if (document.getElementById('deadhour-notification')) return;
  
  const notification = document.createElement('div');
  notification.id = 'deadhour-notification';
  notification.innerHTML = `
    <div style="
      position: fixed;
      top: 20px;
      right: 20px;
      background: #2E7D32;
      color: white;
      padding: 12px 16px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
      z-index: 10000;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      font-size: 14px;
      max-width: 300px;
      cursor: pointer;
    ">
      🇲🇦 <strong>DeadHour Morocco</strong><br>
      <span style="font-size: 12px; opacity: 0.9;">
        Find better deals with up to 25% cashback in Morocco
      </span>
      <div style="margin-top: 8px; font-size: 11px; opacity: 0.8;">
        Click to compare prices →
      </div>
    </div>
  `;
  
  notification.onclick = () => {
    window.open('$_companionUrl', '_blank');
  };
  
  document.body.appendChild(notification);
  
  // Auto-hide after 8 seconds
  setTimeout(() => {
    if (notification.parentNode) {
      notification.parentNode.removeChild(notification);
    }
  }, 8000);
}

// Handle extension icon click
chrome.action.onClicked.addListener((tab) => {
  chrome.scripting.executeScript({
    target: { tabId: tab.id },
    func: showDeadHourNotification
  });
});
''';
  }

  /// Generate content script for browser extension
  String generateContentScript() {
    return '''
// DeadHour Content Script - Runs on watched websites
(function() {
  'use strict';
  
  // Initialize DeadHour companion
  function initDeadHourCompanion() {
    // Look for booking/search forms
    const forms = document.querySelectorAll('form');
    const searchInputs = document.querySelectorAll('input[type="text"], input[type="search"]');
    
    // Add DeadHour suggestions to relevant forms
    forms.forEach(form => {
      if (isBookingForm(form)) {
        addDeadHourSuggestion(form);
      }
    });
  }
  
  function isBookingForm(form) {
    const formText = form.innerText.toLowerCase();
    const bookingKeywords = [
      'hotel', 'restaurant', 'book', 'reserve', 'check-in',
      'morocco', 'marrakech', 'casablanca', 'fes', 'rabat'
    ];
    
    return bookingKeywords.some(keyword => formText.includes(keyword));
  }
  
  function addDeadHourSuggestion(form) {
    if (form.querySelector('.deadhour-suggestion')) return;
    
    const suggestion = document.createElement('div');
    suggestion.className = 'deadhour-suggestion';
    suggestion.innerHTML = `
      <div style="
        background: linear-gradient(135deg, #2E7D32, #4CAF50);
        color: white;
        padding: 12px;
        border-radius: 8px;
        margin: 8px 0;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        font-size: 13px;
        box-shadow: 0 2px 8px rgba(46, 125, 50, 0.3);
        cursor: pointer;
        transition: transform 0.2s;
      " onmouseover="this.style.transform='scale(1.02)'" onmouseout="this.style.transform='scale(1)'">
        <div style="display: flex; align-items: center; margin-bottom: 4px;">
          <span style="font-size: 16px; margin-right: 8px;">🇲🇦</span>
          <strong>DeadHour Morocco Alternative</strong>
        </div>
        <div style="font-size: 11px; opacity: 0.9; margin-bottom: 8px;">
          Find better deals with up to 25% cashback during dead hours
        </div>
        <div style="display: flex; justify-content: space-between; align-items: center;">
          <span style="font-size: 11px;">🤖 Auto-apply • 💰 Cashback • 🗺️ Live deals</span>
          <span style="font-size: 12px; font-weight: bold;">Compare →</span>
        </div>
      </div>
    `;
    
    suggestion.onclick = () => {
      window.open('$_companionUrl?ref=extension', '_blank');
    };
    
    form.appendChild(suggestion);
  }
  
  // Initialize when page loads
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initDeadHourCompanion);
  } else {
    initDeadHourCompanion();
  }
  
  // Re-initialize when content changes (SPA navigation)
  const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
      if (mutation.addedNodes.length > 0) {
        setTimeout(initDeadHourCompanion, 1000);
      }
    });
  });
  
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
})();
''';
  }

  /// Load deals for watched domains
  void _loadDealsForDomains() {
    // Simulate loading deals that match international booking sites
    for (final domain in _watchedDomains) {
      final relevantDeals = MockData.deals.where((deal) {
        final venue = MockData.venues.firstWhere(
          (v) => v.id == deal.venueId,
          orElse: () => MockData.venues.first,
        );
        
        // Match based on domain type
        switch (domain) {
          case 'booking.com':
          case 'airbnb.com':
          case 'hotels.com':
            return venue.category == 'tourism' || venue.type.toLowerCase().contains('hotel');
          case 'tripadvisor.com':
            return true; // All deals relevant for TripAdvisor
          case 'restaurant.ma':
          case 'cafes-maroc.com':
            return venue.category == 'food';
          case 'spa-morocco.com':
          case 'hammam-marrakech.com':
            return venue.category == 'wellness';
          default:
            return venue.city.toLowerCase().contains('morocco') || 
                   venue.city.toLowerCase().contains('casablanca');
        }
      }).toList();
      
      _domainDeals[domain] = relevantDeals;
    }
  }

  String _cleanDomain(String domain) {
    return domain.replaceAll('www.', '').toLowerCase();
  }

  bool _matchesSearch(String text, String query) {
    return text.toLowerCase().contains(query.toLowerCase());
  }

  String _generateDealsHtml(List<Deal> deals) {
    return deals.take(3).map((deal) {
      final venue = MockData.venues.firstWhere(
        (v) => v.id == deal.venueId,
        orElse: () => MockData.venues.first,
      );
      final cashback = _cashbackService.calculateCashback(deal, deal.discountedPrice);
      
      return '''
        <div class="deal-card" onclick="bookDeal('${deal.id}')">
          <div class="deal-title">${deal.title}</div>
          <div class="deal-venue">${venue.name}</div>
          <div class="deal-price">
            <div>
              <span class="price-new">${deal.discountedPrice.toInt()} MAD</span>
              <span class="price-old">${deal.originalPrice.toInt()} MAD</span>
            </div>
            <div class="cashback">+${cashback.cashbackAmount.toStringAsFixed(0)} MAD</div>
          </div>
        </div>
      ''';
    }).join();
  }

  String _generateNoDealsHtml(String domain) {
    return '''
      <div class="no-deals">
        <div style="font-size: 32px; margin-bottom: 12px;">🇲🇦</div>
        <div style="font-weight: 600; margin-bottom: 8px;">Discover Morocco Deals</div>
        <div style="font-size: 12px;">
          Find authentic experiences with up to 25% cashback during dead hours
        </div>
      </div>
    ''';
  }

  /// Get installation instructions for different browsers
  Map<String, String> getInstallationInstructions() {
    return {
      'chrome': '''
1. Download the DeadHour extension files
2. Open Chrome → Settings → Extensions
3. Enable "Developer mode"
4. Click "Load unpacked" and select the extension folder
5. Pin the DeadHour icon to your toolbar
''',
      'firefox': '''
1. Download the DeadHour extension files
2. Open Firefox → Add-ons Manager
3. Click the gear icon → "Debug Add-ons"
4. Click "Load Temporary Add-on"
5. Select the manifest.json file
''',
      'bookmarklet': '''
1. Copy the bookmarklet code
2. Create a new bookmark in your browser
3. Paste the code as the URL
4. Name it "DeadHour Morocco"
5. Click the bookmark on any travel/booking site
''',
    };
  }
}