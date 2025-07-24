# DeadHour MVP - ADDON System Core Screens (90% Functionality)

## Overview
This document contains the **essential screens** that demonstrate DeadHour's revolutionary ADDON platform value to investors and users. These screens prove infinite scalability through ADDON stacking and cross-addon amplification.

**MVP Purpose**: Show the Instagram-inspired ADDON switching interface and marketplace functionality.

**Development Timeline**: 4 weeks
**Resource Requirements**: 2-3 developers, Firebase backend, ADDON marketplace integrations
**Target**: Prove ADDON system with €65+/month revenue potential per user

---

## Core Business Value

**ADDON System Proof**:
✅ **ADDON Stacking**: Single user can have Business €30 + Guide €20 + Premium €15 = €65/month
✅ **Instagram-Inspired Interface**: Seamless ADDON switching with familiar social media UX
✅ **Cross-ADDON Amplification**: Each ADDON enhances others through network effects

**Essential ADDON User Journeys**:
1. **Consumer → Business ADDON**: Start as consumer → Add Business ADDON → Manage venue with enhanced tools
2. **Business → Guide ADDON**: Business owner adds Guide expertise → Earn from both ADDONs
3. **Multi-ADDON User**: Switch between ADDONs seamlessly → Cross-addon analytics → Maximize revenue

---

## 1. Authentication Flow
*(Development: Week 1 - Days 1-2)*

### 1.1 Splash Screen
```
┌─────────────────────────────────────┐
│              🕐 DeadHour            │
│         Find deals during           │
│         off-peak hours             │
│                                    │
│    [Loading animation with         │
│     Morocco-themed colors]         │
│                                    │
│         Loading...                 │
└─────────────────────────────────────┘
```
**Business Value**: Brand recognition for infinite-scalability ADDON platform
**Features**: Morocco-themed, multi-language support, prayer time integration

### 1.2 Welcome/Onboarding Screen
```
┌─────────────────────────────────────┐
│  Welcome to DeadHour Morocco! 🇲🇦   │
│                                    │
│  [Swipeable carousel screens:]     │
│                                    │
│  Screen 1: "Find Amazing Deals"    │
│  • Restaurants during quiet hours  │
│  • Entertainment & activities      │
│  • Wellness & spa experiences     │
│                                    │
│  Screen 2: "Join Local Communities"│
│  • Discover through trusted locals │
│  • Cultural experiences & guides   │
│  • Meet people with shared interests│
│                                    │
│  Screen 3: "Morocco First"         │
│  • Prayer time aware scheduling    │
│  • Halal certified options        │
│  • Multi-language support         │
│                                    │
│ [Skip] [Next] [Get Started]        │
└─────────────────────────────────────┘
```
**Business Value**: Explain ADDON stacking value proposition with industry validation

### 1.3 Registration Screen
```
┌─────────────────────────────────────┐
│ ← 📱 Create Account                 │
│                                    │
├─────────────────────────────────────┤
│                                    │
│ Create Universal DeadHour Account: │
│                                    │
│ 🎯 Start as Consumer (Everyone)    │
│ + Add ADDONs later through marketplace │
│                                    │
│ Available ADDONs:                  │
│ • Business ADDON (€30/month)       │
│ • Guide ADDON (€20/month)          │
│ • Premium ADDON (€15/month)        │
│                                    │
│ Phone Number                       │
│ ┌─────────────────────────────────┐ │
│ │ +212 | Enter your phone number │ │
│ └─────────────────────────────────┘ │
│                                    │
│ Full Name                          │
│ ┌─────────────────────────────────┐ │
│ │ Your full name                  │ │
│ └─────────────────────────────────┘ │
│                                    │
│ Email (Optional)                   │
│ ┌─────────────────────────────────┐ │
│ │ your.email@example.com          │ │
│ └─────────────────────────────────┘ │
│                                    │
│ Preferred Language                 │
│ [العربية ▼] Arabic selected         │
│                                    │
│ ☑️ I agree to Terms & Privacy      │
│                                    │
│ [Send Verification Code]           │
│                                    │
│ Already have account? [Sign In]    │
└─────────────────────────────────────┘
```
**Business Value**: Segment users for different experiences (locals vs tourists vs businesses)

### 1.4 Business Registration Flow
```
┌─────────────────────────────────────┐
│ ← 🏢 Business Registration          │
│ Boost your venue during dead hours │
├─────────────────────────────────────┤
│                                    │
│ 🎯 Turn Dead Hours into Revenue!    │
│                                    │
│ Business Information:              │
│ Business Name                      │
│ ┌─────────────────────────────────┐ │
│ │ Café Central Gueliz             │ │
│ └─────────────────────────────────┘ │
│                                    │
│ Business Type                      │
│ [Restaurant/Café ▼]                │
│ Options: Restaurant, Café, Entertainment,│
│ Wellness/Spa, Sports, Tourism      │
│                                    │
│ Location                           │
│ ┌─────────────────────────────────┐ │
│ │ 123 Rue Mohammed V, Gueliz      │ │
│ │ Casablanca, Morocco             │ │
│ └─────────────────────────────────┘ │
│ [📍 Use Current Location]          │
│                                    │
│ Operating Hours                    │
│ Monday-Sunday: [08:00] - [23:00]   │
│ ☑️ Different hours for weekends    │
│                                    │
│ 📱 Contact Details:                │
│ Phone: +212 522 123 456            │
│ Email: manager@cafecentral.ma      │
│                                    │
│ 💰 Revenue Goals:                  │
│ "What's your main challenge?"      │
│ ● 🕐 Empty during afternoon hours  │
│ ○ 📅 Slow on specific weekdays     │
│ ○ 🌙 Need more evening customers   │
│ ○ 📈 General low occupancy         │
│                                    │
│ [Continue Setup] [Save Draft]      │
└─────────────────────────────────────┘
```

### 1.5 Business Verification & Setup
```
┌─────────────────────────────────────┐
│ ← 🏢 Verify Your Business           │
│ Final steps to start boosting sales│
├─────────────────────────────────────┤
│                                    │
│ 📋 Business Verification:          │
│                                    │
│ Upload Business License/Permit:    │
│ [📄 Upload Document] [📷 Take Photo]│
│ ✅ Accepted formats: PDF, JPG, PNG │
│                                    │
│ Menu/Services (Optional):          │
│ [📄 Upload Menu] [➕ Add Items]     │
│                                    │
│ 📸 Venue Photos (3-5 photos):      │
│ [📷 Take Photos] [📱 Upload Gallery]│
│ Interior, exterior, signature items│
│                                    │
│ 💳 Payment & Commission Setup:     │
│ Commission Rate: 8% per booking    │
│ Payment Method:                    │
│ ● 🏦 Bank Transfer (weekly)        │
│ ○ 📱 Mobile Money (daily)          │
│ ○ 💰 Cash Collection (monthly)     │
│                                    │
│ Bank Details:                      │
│ Bank: [Attijariwafa Bank ▼]        │
│ Account: XXXX-XXXX-XXXX-1234       │
│ Name: Café Central Gueliz          │
│                                    │
│ 🎯 Platform Benefits Preview:      │
│ • Attract customers during slow hours│
│ • Join community discussions       │
│ • Real-time booking management     │
│ • Revenue analytics & insights     │
│                                    │
│ ☑️ I agree to DeadHour Business Terms│
│ ☑️ 8% commission on confirmed bookings│
│                                    │
│ [Complete Registration]            │
└─────────────────────────────────────┘
```
**Business Value**: Complete business onboarding creates real platform for revenue optimization

---

## 2. Main Navigation & Home
*(Development: Week 1 - Days 3-5)*

### 2.1 Home Screen - Local User
```
┌─────────────────────────────────────┐
│ DeadHour Morocco 🇲🇦  [🔔] [⚙️]    │
│ Good afternoon, Ahmed! ☀️           │
│ Next prayer: Asr in 2h 15min 🕌    │
├─────────────────────────────────────┤
│ 🔥 Flash Deals Nearby (6 active)   │
│ ┌─────────────────────────────────┐ │
│ │ ☕ Café Atlas - 40% OFF         │ │
│ │ Valid next 90 minutes           │ │
│ │ 2.3km • Maarif                 │ │
│ │ [Book Now] [Save] [Share]       │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 📱 Quick Categories:               │
│ [🍕 Food] [🎮 Fun] [💆 Wellness]   │
│ [⚽ Sports] [🌍 Tourism] [👨‍👩‍👧‍👦 Family] │
│                                    │
│ 💬 Your Active Rooms (3):          │
│ • #coffee-afternoon-deals (12 new) │
│ • #padel-partners-casa (3 new)     │
│ • #cultural-events-morocco (1 new) │
│                                    │
│ 🏆 Popular This Week:              │
│ ┌─────────────────────────────────┐ │
│ │ 🍽️ Restaurant Al Fassia        │ │
│ │ 30% off lunch 14:00-16:00       │ │
│ │ ⭐ 4.8 • 89 people going        │ │
│ │ [View Details]                  │ │
│ └─────────────────────────────────┘ │
│                                    │
│ [Discover More] [Browse All]       │
└─────────────────────────────────────┘
```
**Business Value**: Show ADDON stacking solution working - deals + community rooms together

### 2.2 Tourist Home Screen
```
┌─────────────────────────────────────┐
│ DeadHour Morocco 🇲🇦  [🔔] [⚙️]    │
│ Welcome to Morocco, Sarah! ✈️       │
│ Day 3 of your trip • Casablanca    │
├─────────────────────────────────────┤
│ 🎯 Curated for Tourists:           │
│ ┌─────────────────────────────────┐ │
│ │ 🏺 Hassan II Mosque Tour        │ │
│ │ Local guide available now       │ │
│ │ 2 hours • 15€ • English/French │ │
│ │ [Book Experience] [Learn More]  │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 🔥 Tourist-Friendly Deals (12):    │
│ ┌─────────────────────────────────┐ │
│ │ ☕ Rick's Café - 20% OFF        │ │
│ │ Famous movie location café      │ │
│ │ English menu • Tourist-friendly │ │
│ │ [Reserve Table] [📍 2.1km]      │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 💬 Connect with Locals:            │
│ • #tourism-welcome-morocco (45)    │
│ • #cultural-experiences-casa (23)  │
│ • #foodie-tourists-guide (67)      │
│                                    │
│ 🌟 Local Expert Available:         │
│ "Youssef - Cultural Guide (4.9⭐)" │
│ Online now • Speaks English        │
│ [Chat Now] [Book Session]          │
│                                    │
│ [💰 Upgrade to Premium] 15€/month  │
│ Unlock exclusive tourist experiences│
└─────────────────────────────────────┘
```
**Business Value**: Premium revenue stream + local-tourist connection (network effects)

---

## 3. Category Screens
*(Development: Week 2 - Days 1-3)*

### 3.1 Food & Dining Category
```
┌─────────────────────────────────────┐
│ ← 🍕 Food & Dining                  │
│ [🔍 Search] [📍 Near Me] [⚙️ Filter]│
├─────────────────────────────────────┤
│                                    │
│ 🔥 Active Deals (23):              │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ ☕ Café Central                 │ │
│ │ 35% OFF • Next 2 hours          │ │
│ │ ⭐ 4.6 • Mediterranean • 1.2km  │ │
│ │ 💬 12 in room discussing        │ │
│ │ [Book Now] [Join Room] [❤️]     │ │
│ └─────────────────────────────────┘ │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 🥘 Restaurant Marrakchi         │ │
│ │ 25% OFF • Traditional Moroccan  │ │
│ │ ⭐ 4.8 • Halal ✅ • 2.1km       │ │
│ │ 💬 8 people planning visit      │ │
│ │ [Book Now] [Join Room] [❤️]     │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 🏷️ Browse by Type:                │
│ [Traditional] [International]      │
│ [Cafés] [Fast Food] [Fine Dining]  │
│                                    │
│ ⏰ By Time:                        │
│ [Breakfast] [Lunch] [Dinner]       │
│ [Late Night] [Dead Hours]          │
└─────────────────────────────────────┘
```
**Business Value**: Show community engagement driving bookings

### 3.2 Entertainment Category
```
┌─────────────────────────────────────┐
│ ← 🎮 Entertainment & Fun             │
│ [🔍 Search] [📍 Near Me] [⚙️ Filter]│
├─────────────────────────────────────┤
│                                    │
│ 🎯 Off-Peak Deals (15):            │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 🏎️ Karting Club Casa           │ │
│ │ 40% OFF weekday afternoons      │ │
│ │ ⭐ 4.5 • Racing • 3.4km         │ │
│ │ 👥 Group of 6 forming           │ │
│ │ [Join Group] [Book Solo] [❤️]   │ │
│ └─────────────────────────────────┘ │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 🎳 Bowling Anfa                 │ │
│ │ 30% OFF + Free shoes            │ │
│ │ ⭐ 4.7 • Family Fun • 1.8km     │ │
│ │ 💬 Planning weekend tournament  │ │
│ │ [Book Lane] [Join Chat] [❤️]    │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 🎲 Activity Types:                 │
│ [Gaming] [Bowling] [Cinema]        │
│ [Escape Rooms] [Arcade] [Karting]  │
│                                    │
│ 👥 Group Activities:               │
│ [Join Existing] [Create Group]     │
│ [Team Building] [Date Ideas]       │
└─────────────────────────────────────┘
```
**Business Value**: Multi-category platform breadth (not just restaurants)

---

## 4. Venue Details & Booking
*(Development: Week 2 - Days 4-5)*

### 4.1 Venue Details Screen
```
┌─────────────────────────────────────┐
│ ← [📷 Photo Gallery] [❤️] [📤]      │
│                                    │
│ [Main venue photo with overlay]    │
│ 🔥 FLASH DEAL: 35% OFF             │
│ Valid for next 1h 23min            │
├─────────────────────────────────────┤
│ ☕ Café Central Gueliz              │
│ ⭐ 4.6 (234 reviews) • €€ • 1.2km  │
│ Mediterranean Café • Halal ✅       │
│                                    │
│ 📍 123 Rue Mohammed V, Gueliz      │
│ 🕐 Open: 8:00 - 23:00              │
│ 📞 +212 522 123 456                │
│                                    │
│ 💬 Community Room (12 active):     │
│ "Great coffee and perfect for      │
│ afternoon work sessions!" - Sara   │
│ [Join Room Discussion]             │
│                                    │
│ ⏰ Deal Schedule Today:             │
│ • 14:00-16:00: 35% OFF (ACTIVE) 🔥 │
│ • 20:00-22:00: 25% OFF             │
│                                    │
│ 🍽️ Popular Items:                  │
│ • Moroccan Mint Tea - 15 MAD       │
│ • Pastilla - 45 MAD                │
│ • Continental Breakfast - 65 MAD   │
│                                    │
│ 📊 Busy Times: [Visual Graph]      │
│ Less busy right now (35% capacity) │
│                                    │
│ [🎫 Book Deal Now] [💬 Join Room]   │
│ [📞 Call] [🗺️ Directions]          │
└─────────────────────────────────────┘
```
**Business Value**: Perfect example of ADDON amplification - venue optimization + community engagement

### 4.2 Booking Flow Screen
```
┌─────────────────────────────────────┐
│ ← 🎫 Book: Café Central Gueliz      │
│                                    │
├─────────────────────────────────────┤
│ Deal: 35% OFF (saving 23 MAD)      │
│ Valid until: 16:00 today           │
│                                    │
│ 👥 Party Size:                     │
│ [1] [2] [3] [4] [5+]               │
│     ●                              │
│                                    │
│ 📅 Date & Time:                    │
│ Today, March 15 ▼                  │
│ [14:30] [15:00] [15:30] [16:00]    │
│          ●                         │
│                                    │
│ 📝 Special Requests:               │
│ ┌─────────────────────────────────┐ │
│ │ Window seat preferred, no nuts  │ │
│ │ allergy                         │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 💳 Payment Method:                 │
│ ● 💳 Pay at venue (Cash/Card)      │
│ ○ 📱 Pay now (Mobile payment)      │
│                                    │
│ 📱 Contact Info:                   │
│ Phone: +212 6XX XXX XXX ✓          │
│                                    │
│ 💰 Total: 42 MAD (was 65 MAD)      │
│ You save: 23 MAD with this deal!   │
│                                    │
│ [Confirm Booking]                  │
│                                    │
│ By booking, you agree to venue     │
│ cancellation policy                │
└─────────────────────────────────────┘
```
**Business Value**: Revenue transaction completion - core business model

---

## 5. Community & Social Features (Room-Based)
*(Development: Week 3 - Days 1-2)*

### 5.1 Room List Screen
```
┌─────────────────────────────────────┐
│ 💬 Community Rooms                  │
│ [🔍 Search] [➕ Create] [⚙️ Filter] │
├─────────────────────────────────────┤
│                                    │
│ 🔥 Most Active Right Now:           │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 🍕 #coffee-afternoon-deals-casa │ │
│ │ 156 members • 23 online         │ │
│ │ Latest: "Flash deal at Atlas!"  │ │
│ │ 2 min ago • [Join Room]         │ │
│ └─────────────────────────────────┘ │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 🎮 #escape-rooms-weekend        │ │
│ │ 89 members • 12 online          │ │
│ │ Latest: "Team forming for Sat"  │ │
│ │ 5 min ago • [Join Room]         │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 📂 Browse by Category:             │
│ 🍕 Food & Dining (12 rooms)        │
│ 🎮 Entertainment (8 rooms)         │
│ 💆 Wellness (6 rooms)              │
│ ⚽ Sports (9 rooms)                 │
│ 🌍 Tourism (15 rooms)              │
│ 👨‍👩‍👧‍👦 Family (7 rooms)               │
│                                    │
│ 🌟 Your Rooms (3):                 │
│ • #padel-partners-casa (8 new)     │
│ • #traditional-food-lovers (2 new) │
│ • #cultural-events-morocco (1 new) │
│                                    │
│ [Browse All Rooms]                 │
└─────────────────────────────────────┘
```
**Business Value**: Core innovation - Discord-like rooms where business deals become social discovery

### 5.2 Room Chat with Deal Integration
```
┌─────────────────────────────────────┐
│ ← 🍕 #coffee-afternoon-deals-casa   │
│ 156 members • 23 online • Mods: 3  │
├─────────────────────────────────────┤
│ 🤖 DeadHour Bot: 🚨 FLASH DEAL!    │
│ Café Atlas Maarif: 50% OFF         │
│ ⏰ Next 2 hours only               │
│ [Book Now] [Share with Friends]    │
│                                    │
│ Ahmed_Casa: Perfect timing! I was  │
│ just looking for a good coffee spot│
│ near Twin Center 👍                │
│ 2 min ago                          │
│                                    │
│ Sara_Local: @Ahmed_Casa Atlas has  │
│ amazing pastries too! Try the      │
│ chebakia 🥮                        │
│ 1 min ago                          │
│                                    │
│ TouristMike_🇺🇸: Is it halal       │
│ certified? First time in Morocco   │
│ 30 sec ago                         │
│                                    │
│ Local_Expert_Youssef: @TouristMike │
│ Yes! ✅ Halal certified. Welcome   │
│ to Morocco! 🇲🇦                    │
│ 15 sec ago                         │
│                                    │
│ [Type message...] [📷] [📍] [😊]   │
└─────────────────────────────────────┘
```
**Business Value**: PERFECT example of ADDON amplification in action - business deal creates social discovery opportunity

---

## 6. Search & Discovery
*(Development: Week 3 - Days 3-4)*

### 6.1 Search Screen
```
┌─────────────────────────────────────┐
│ 🔍 Search DeadHour                  │
│                                    │
├─────────────────────────────────────┤
│ ┌─────────────────────────────────┐ │
│ │ 🔍 Search venues, deals, rooms  │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 🔥 Popular Searches:               │
│ [coffee deals] [escape rooms]      │
│ [halal restaurants] [weekend fun]  │
│                                    │
│ ⚡ Quick Filters:                  │
│ [📍 Nearby] [🔥 Active Deals]      │
│ [⏰ Open Now] [✅ Halal]           │
│                                    │
│ 📂 Browse Categories:              │
│ ┌─────────────────────────────────┐ │
│ │ 🍕 30 food deals active         │ │
│ │ 🎮 15 entertainment offers      │ │
│ │ 💆 8 wellness specials          │ │
│ │ ⚽ 12 sports activities         │ │
│ │ 🌍 25 tourism experiences       │ │
│ │ 👨‍👩‍👧‍👦 18 family activities        │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 🕐 Recent Searches:                │
│ • "coffee Gueliz area"             │
│ • "bowling weekend deals"          │
│ • "traditional restaurants"        │
│                                    │
│ 💬 Trending in Rooms:              │
│ • "Atlas café amazing pastries"    │
│ • "Karting group tomorrow"         │
│ • "New hammam in Maarif"           │
└─────────────────────────────────────┘
```
**Business Value**: Show platform activity across all categories

---

## 7. Business Owner Dashboard
*(Development: Week 4 - Days 3-4)*

### 7.1 Business Dashboard
```
┌─────────────────────────────────────┐
│ 🏢 Café Central Dashboard           │
│ [📊 Analytics] [⚙️ Settings] [💬]  │
├─────────────────────────────────────┤
│                                    │
│ Today's Performance:               │
│ 📈 +23% revenue vs yesterday       │
│ 🎫 12 DeadHour bookings            │
│ 💰 234 MAD earned through platform │
│                                    │
│ 🔥 Active Deals:                   │
│ ┌─────────────────────────────────┐ │
│ │ 35% OFF - Dead Hours Special    │ │
│ │ 14:00-16:00 • 7 bookings so far│ │
│ │ Revenue: +89 MAD vs 0 yesterday │ │
│ │ [Edit Deal] [Extend Time]       │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 📅 Upcoming Bookings (8):          │
│ • 15:30 - Ahmed B. (Table for 2)   │
│ • 15:45 - Sara M. (Table for 1)    │
│ • 16:00 - Tourist Group (4 people) │
│                                    │
│ 💬 Community Room Activity:        │
│ #coffee-afternoon-deals-casa        │
│ 156 members • 23 discussing venue  │
│ Recent: "Great service yesterday!"  │
│ [View All Messages]                │
│                                    │
│ ⚡ Quick Actions:                   │
│ [➕ Create Flash Deal]             │
│ [📝 Update Hours]                  │
│ [📱 Send Notification]             │
│ [💳 View Payments]                 │
│                                    │
│ 📊 This Week Summary:              │
│ • Total bookings: 47               │
│ • Platform revenue: 1,240 MAD      │
│ • New customers: 23                │
│ • Average rating: 4.6⭐            │
└─────────────────────────────────────┘
```
**Business Value**: Show clear ROI for business owners - the core value proposition

### 7.2 Dead Hours Analytics Dashboard
```
┌─────────────────────────────────────┐
│ 🏢 Dead Hours Analysis              │
│ Identify your revenue opportunities │
├─────────────────────────────────────┤
│                                    │
│ 📊 Your Weekly Traffic Pattern:    │
│ ┌─────────────────────────────────┐ │
│ │ 100% ████████████████████████   │ │
│ │  80% ████████████████████       │ │
│ │  60% ████████████████          │ │
│ │  40% ████████████ 🔴 DEAD HOURS │ │
│ │  20% ████████                  │ │
│ │   0% ████                      │ │
│ │      Mon Tue Wed Thu Fri Sat Sun│ │
│ └─────────────────────────────────┘ │
│                                    │
│ 🕐 Today's Dead Hours Identified:  │
│ • 14:00-16:00: 35% occupancy ⬇️     │
│ • 20:00-22:00: 28% occupancy ⬇️     │
│                                    │
│ 💰 Revenue Opportunity:            │
│ Empty tables cost: 145 MAD/hour    │
│ Potential with 40% deal: +89 MAD   │
│ Monthly potential: +2,670 MAD      │
│                                    │
│ 🎯 Recommended Deal Strategy:      │
│ ┌─────────────────────────────────┐ │
│ │ 🔥 AFTERNOON SPECIAL            │ │
│ │ 35-40% OFF during 14:00-16:00   │ │
│ │ Target: Coffee + pastry combos  │ │
│ │ Expected: +12 customers/day     │ │
│ │ Revenue boost: +67% vs empty    │ │
│ │ [Create This Deal] 🚀           │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 📈 Performance vs Competition:     │
│ • Your dead hours: 14:00-16:00     │
│ • Competitors active: 67% offering │
│ • Average deal: 32% discount       │
│ • Recommendation: Beat with 35%    │
│                                    │
│ [📊 Detailed Analytics] [💡 Get Tips]│
└─────────────────────────────────────┘
```
**Business Value**: Data-driven dead hour identification shows exactly when to create deals for maximum impact

### 7.3 Create Deal Interface
```
┌─────────────────────────────────────┐
│ ← ➕ Create Dead Hour Deal           │
│ Boost revenue during slow times    │
├─────────────────────────────────────┤
│                                    │
│ 🎯 Deal Information:               │
│                                    │
│ Deal Name                          │
│ ┌─────────────────────────────────┐ │
│ │ Afternoon Coffee Special        │ │
│ └─────────────────────────────────┘ │
│                                    │
│ Deal Type                          │
│ ● 📉 Percentage Discount (35% OFF) │
│ ○ 💰 Fixed Price (Coffee + Pastry = 25 MAD)│
│ ○ 🎁 Buy One Get One              │
│ ○ 🍽️ Combo Deal (Special menu)    │
│                                    │
│ Discount Amount                    │
│ [35]% OFF regular prices           │
│ Preview: 45 MAD → 29 MAD           │
│                                    │
│ ⏰ Dead Hours Schedule:            │
│ Days: ☑️ Mon ☑️ Tue ☑️ Wed ☑️ Thu ☑️ Fri │
│       ☐ Sat ☐ Sun                 │
│                                    │
│ Time: [14:00] to [16:00]           │
│ Duration: 2 hours daily            │
│                                    │
│ 🎯 Target Items (Optional):        │
│ ☑️ All menu items                  │
│ ☐ Coffee & beverages only          │
│ ☐ Specific items:                  │
│ [+ Add Items]                      │
│                                    │
│ 👥 Deal Capacity:                  │
│ Max customers per day: [20]        │
│ Max per time slot: [8]             │
│                                    │
│ 💬 Community Message:              │
│ ┌─────────────────────────────────┐ │
│ │ Perfect afternoon study spot!   │ │
│ │ Quiet atmosphere, great coffee, │ │
│ │ free WiFi. Beat the afternoon   │ │
│ │ energy dip with our special! ☕ │ │
│ └─────────────────────────────────┘ │
│                                    │
│ [🎯 Preview Deal] [💾 Save Draft]   │
│ [🚀 Publish Deal] [📱 Notify Community]│
└─────────────────────────────────────┘
```
**Business Value**: Easy deal creation transforms dead hours into revenue opportunities

### 7.4 Live Deal Management
```
┌─────────────────────────────────────┐
│ 🔥 Active Deals Dashboard           │
│ Manage your live offers             │
├─────────────────────────────────────┤
│                                    │
│ 🚨 LIVE NOW (2 active deals):      │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ ☕ Afternoon Coffee Special     │ │
│ │ 35% OFF • 14:00-16:00          │ │
│ │ 📊 Today: 7/20 bookings used   │ │
│ │ 💰 Revenue: +156 MAD so far    │ │
│ │ 💬 Room activity: 12 discussing │ │
│ │ [⏸️ Pause] [✏️ Edit] [📊 Stats]  │ │
│ └─────────────────────────────────┘ │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 🌙 Evening Dinner Deal          │ │
│ │ 25% OFF • 20:00-22:00          │ │
│ │ 📊 Today: 3/15 bookings used   │ │
│ │ 💰 Revenue: +89 MAD so far     │ │
│ │ 💬 Room activity: 5 discussing  │ │
│ │ [⏸️ Pause] [✏️ Edit] [📊 Stats]  │ │
│ └─────────────────────────────────┘ │
│                                    │
│ ⚡ Quick Actions:                  │
│ [🚨 Flash Deal - Next 30min]       │
│ [📢 Boost in Community]            │
│ [⏱️ Extend Current Deal]           │
│ [🎯 Create New Deal]               │
│                                    │
│ 📊 Today's Performance:            │
│ • Deal bookings: 10 (vs 0 yesterday)│
│ • Extra revenue: +245 MAD          │
│ • Community mentions: 17           │
│ • New customers: 6                 │
│                                    │
│ 📅 Scheduled Deals (This Week):    │
│ • Mon-Fri: Afternoon Coffee (14-16)│
│ • Wed-Thu: Evening Dinner (20-22)  │
│ • Weekend: Breakfast Special (9-11)│
│                                    │
│ [📈 Performance Report] [⚙️ Settings]│
└─────────────────────────────────────┘
```
**Business Value**: Real-time deal management with immediate feedback shows platform value for businesses

### 7.5 Basic Business Analytics
```
┌─────────────────────────────────────┐
│ 📊 Business Performance Summary     │
│ Track your dead hours success       │
├─────────────────────────────────────┤
│                                    │
│ 🎯 This Month's Dead Hours Impact: │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 💰 Extra Revenue Generated      │ │
│ │ 3,450 MAD (+23% vs last month)  │ │
│ │                                 │ │
│ │ 👥 New Customers Acquired       │ │
│ │ 67 people (73% from community)  │ │
│ │                                 │ │
│ │ 🔥 Total Deal Bookings          │ │
│ │ 156 bookings (vs 12 without)    │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 📈 Dead Hours Transformation:      │
│ Before DeadHour: 25% occupancy     │
│ After DeadHour:  67% occupancy     │
│ Revenue increase: 168% during deals │
│                                    │
│ 🏆 Best Performing Deals:          │
│ • Afternoon Coffee: +89 MAD/day    │
│ • Evening Dinner: +67 MAD/day      │
│ • Weekend Brunch: +156 MAD/day     │
│                                    │
│ 💬 Community Impact:               │
│ • #coffee-afternoon-deals: 156 members│
│ • Your deals shared: 234 times     │
│ • Average rating: 4.8/5 ⭐         │
│ • Repeat customers: 78%            │
│                                    │
│ 📊 Next Steps Recommended:         │
│ • Create breakfast deal (6-9 AM)   │
│ • Try wellness category expansion  │
│ • Increase weekend evening deals   │
│                                    │
│ 📅 Quick Stats:                    │
│ • Dead hours reduced: 14 → 8 hours/week│
│ • Commission paid: 276 MAD (8%)    │
│ • Net profit increase: +3,174 MAD  │
│                                    │
│ [📈 Detailed Report] [💡 Optimization Tips]│
│ [📱 Share Success] [⚙️ Settings]   │
└─────────────────────────────────────┘
```
**Business Value**: Simple, clear analytics show direct impact of platform on dead hours revenue

### 7.6 Revenue & Commission Tracking
```
┌─────────────────────────────────────┐
│ 💰 Revenue & Commission Center      │
│ Track earnings and platform fees    │
├─────────────────────────────────────┤
│                                    │
│ 📊 This Month's Financial Summary:  │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 💵 Total Revenue Generated       │ │
│ │ 4,890 MAD (through DeadHour)    │ │
│ │ ⬆️ +34% vs last month           │ │
│ └─────────────────────────────────┘ │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 🏦 Platform Commission (8%)      │ │
│ │ 391 MAD (automatically deducted)│ │
│ │ Next payment: March 25           │ │
│ └─────────────────────────────────┘ │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 💲 Your Net Earnings             │ │
│ │ 4,499 MAD (after commission)    │ │
│ │ 💳 Paid to your account         │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 📈 Revenue Breakdown by Source:    │
│ • Deal bookings: 3,890 MAD (86%)   │
│ • Regular bookings: 600 MAD (13%)  │
│ • Room community boost: 400 MAD (1%)│
│                                    │
│ 💳 Payment Information:            │
│ Account: Attijariwafa Bank         │
│ Status: ✅ Verified                │
│ Next payment: Monday, March 25     │
│ Payment method: Direct transfer    │
│                                    │
│ 📅 Payment History (Last 3):       │
│ • Feb 25: 3,240 MAD ✅ Completed   │
│ • Jan 25: 2,890 MAD ✅ Completed   │
│ • Dec 25: 2,340 MAD ✅ Completed   │
│                                    │
│ 🎯 Revenue Optimization Tips:      │
│ • Create more 14:00-16:00 deals    │
│ • Weekend deals have +45% profit   │
│ • Community rooms boost bookings 67%│
│                                    │
│ [💳 Update Payment Info] [📊 Details]│
│ [📧 Email Statement] [❓ Help]      │
└─────────────────────────────────────┘
```
**Business Value**: Transparent commission tracking builds trust and shows clear platform ROI

---

## 8. User Profile & Settings
*(Development: Week 3 - Day 5)*

### 8.1 User Profile Screen
```
┌─────────────────────────────────────┐
│ 👤 Your Profile                     │
│ [📝 Edit] [⚙️ Settings] [📤 Share] │
├─────────────────────────────────────┤
│                                    │
│ 📸 [Profile Photo]                 │
│ Ahmed Benali                       │
│ 🏠 Local Resident • Casablanca     │
│ Member since March 2024            │
│                                    │
│ ⭐ Community Score: 4.8/5           │
│ 🎯 Deals Used: 47                  │
│ 💬 Room Messages: 234              │
│ 👥 Connections: 89                 │
│                                    │
│ 🏆 Achievements:                   │
│ • 🍕 Foodie Explorer (tried 20+)   │
│ • 💬 Community Helper (50+ msgs)   │
│ • 🔥 Deal Hunter (used 25+ deals)  │
│                                    │
│ 📊 Your Activity:                  │
│ • Favorite category: Food & Dining │
│ • Most active room: #coffee-deals  │
│ • Savings this month: 234 MAD      │
│                                    │
│ 💰 DeadHour Points: 1,240          │
│ (Earn points, get exclusive deals) │
│                                    │
│ 📱 Quick Actions:                  │
│ [💳 Payment Methods] [🎫 My Bookings]│
│ [❤️ Saved Venues] [👥 My Rooms]    │
│                                    │
│ [📊 View Full Stats]               │
└─────────────────────────────────────┘
```
**Business Value**: Show user engagement metrics and platform stickiness

### 8.2 Settings Screen
```
┌─────────────────────────────────────┐
│ ← ⚙️ Settings                       │
│                                    │
├─────────────────────────────────────┤
│ 👤 Account Settings:               │
│ • [📝 Edit Profile]                │
│ • [🔐 Privacy Settings]            │
│ • [💳 Payment Methods]             │
│ • [🔔 Notifications]               │
│                                    │
│ 🌍 App Preferences:                │
│ • [🌐 Language] Currently: العربية  │
│ • [📍 Location] Casablanca         │
│ • [🕌 Prayer Times] Enabled        │
│ • [✅ Halal Filter] Always On      │
│                                    │
│ 💬 Community Settings:             │
│ • [👥 Room Notifications] Custom   │
│ • [🔇 Do Not Disturb] Schedule     │
│ • [🚫 Blocked Users] Manage        │
│                                    │
│ 🔔 Notification Preferences:       │
│ • [⚡ Flash Deals] Enabled         │
│ • [💬 Room Messages] Enabled       │
│ • [📅 Booking Reminders] Enabled   │
│ • [🎯 Recommendations] Enabled     │
│                                    │
│ ❓ Help & Support:                 │
│ • [📚 Help Center]                 │
│ • [💬 Contact Support]             │
│ • [⭐ Rate App]                    │
│ • [📋 Terms & Privacy]             │
│                                    │
│ Version 1.0.0 (Build 15)          │
└─────────────────────────────────────┘
```
**Business Value**: Morocco cultural integration (prayer times, halal, Arabic support)

---

## 9. Essential Standard App Screens
*(Development: Week 4 - Day 5)*

### 9.1 Notifications Screen
```
┌─────────────────────────────────────┐
│ ← 🔔 Notifications                  │
│ [Mark All Read] [⚙️ Settings]      │
├─────────────────────────────────────┤
│                                    │
│ Today                              │
│                                    │
│ 🔥 Flash Deal Alert                │
│ Café Atlas: 50% OFF next 2 hours  │
│ Tap to book now • 2 min ago        │
│                                    │
│ 💬 Room Activity                   │
│ New message in #coffee-deals       │
│ "Perfect timing for afternoon..." │
│ 5 min ago                          │
│                                    │
│ ✅ Booking Confirmed               │
│ Table at Restaurant Al Fassia     │
│ Today 19:30 for 2 people          │
│ 1 hour ago                         │
│                                    │
│ Yesterday                          │
│                                    │
│ 🌟 Review Reminder                 │
│ How was your visit to Café Central?│
│ Rate your experience               │
│                                    │
│ 💬 Room Mention                    │
│ @Ahmed mentioned you in            │
│ #traditional-food-lovers           │
│                                    │
│ This Week                          │
│                                    │
│ 🎯 New Deals Available             │
│ 15 new deals in your saved venues │
│ Browse deals now                   │
│                                    │
│ [Clear All] [Settings]             │
└─────────────────────────────────────┘
```
**Business Value**: Show platform engagement and activity

### 9.2 Help & Support Screen
```
┌─────────────────────────────────────┐
│ ← ❓ Help & Support                 │
│                                    │
├─────────────────────────────────────┤
│ 🚀 Quick Help:                     │
│                                    │
│ 🎫 Booking Help                    │
│ • How to make a booking            │
│ • Cancellation policy             │
│ • Payment methods                  │
│                                    │
│ 💬 Community Features              │
│ • Joining and creating rooms       │
│ • Room etiquette guidelines        │
│ • Reporting inappropriate content  │
│                                    │
│ 🔥 Deals & Offers                  │
│ • How deals work                   │
│ • Deal notifications               │
│ • Business partnership info       │
│                                    │
│ 🌍 For Tourists                    │
│ • Premium features guide           │
│ • Local expert connections        │
│ • Cultural tips & etiquette       │
│                                    │
│ 💬 Contact Support:                │
│ [📧 Email Support]                 │
│ [💬 Live Chat] (9:00-18:00)        │
│ [📞 Call +212 522 XXX XXX]         │
│                                    │
│ 📱 App Info:                       │
│ • Version 1.0.0                    │
│ • [📋 Terms of Service]            │
│ • [🔒 Privacy Policy]              │
│ • [⭐ Rate App]                    │
│                                    │
│ Response time: Usually < 2 hours   │
└─────────────────────────────────────┘
```

---

## 10. Room-Based Social Platform (Core Innovation)
*(Development: Week 3 - Days 1-2)*

### 10.1 Room Discovery Hub
```
┌─────────────────────────────────────┐
│ 🏠 Room Discovery                   │
│ Find your community tribe           │
├─────────────────────────────────────┤
│                                    │
│ 🔥 Trending Rooms Right Now:       │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 🍕 #coffee-afternoon-deals-casa │ │
│ │ 156 members • 23 active now     │ │
│ │ "Best 3PM espresso spots?"      │ │
│ │ 🔥 5 new deals shared today     │ │
│ │ [Join Room] [Preview]           │ │
│ └─────────────────────────────────┘ │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ 🎮 #escape-rooms-weekend        │ │
│ │ 89 members • 12 active          │ │
│ │ "Saturday team formation!"      │ │
│ │ 👥 3 groups forming for weekend │ │
│ │ [Join Room] [Preview]           │ │
│ └─────────────────────────────────┘ │
│                                    │
│ 🌍 Tourism Premium Rooms: 🔒       │
│ • #marrakech-hidden-gems (234)     │
│ • #authentic-food-tours (167)      │
│ • #cultural-guides-available (89)  │
│                                    │
│ Browse by Category:                │
│ [🍕 Food] [🎮 Entertainment]       │
│ [💆 Wellness] [🌍 Tourism]         │
│ [⚽ Sports] [👨‍👩‍👧‍👦 Family]              │
│                                    │
│ [Create New Room] [Room Analytics] │
│                                    │
│ [🏠] [🔍] [💬] [👤] [🎯]         │
└─────────────────────────────────────┘
```
**Business Value**: Core innovation - Discord-like rooms where business deals become social discovery opportunities

### 10.2 Room Chat with Advanced Deal Integration
```
┌─────────────────────────────────────┐
│ ← 🍕 #coffee-afternoon-deals-casa   │
│ 156 members • 23 online • Mods: 3  │
├─────────────────────────────────────┤
│                                    │
│ Today 15:20                        │
│                                    │
│ 🤖 DeadHour Bot: 🚨 FLASH DEAL!    │
│ Café Atlas Maarif: 50% OFF         │
│ ⏰ Next 2 hours only               │
│ 👥 12 spots left                   │
│ [Book Now] [Share with Friends]    │
│                                    │
│ Fatima_Local_Guide: @everyone       │
│ This place has amazing pastries    │
│ too! Perfect for study sessions 📚 │
│                                    │
│ Ahmed_Student: Thanks @Fatima!      │
│ Anyone wants to go together?       │
│ I'll be there around 16:00         │
│                                    │
│ Sarah_Tourist_FR: @Ahmed_Student    │
│ I'd love to join! Is it tourist-   │
│ friendly? 🇫🇷                      │
│                                    │
│ Local_Expert_Omar: @Sarah_Tourist   │
│ Très accueillant! They speak       │
│ French. I can guide you there 😊   │
│ [Start Private Chat]               │
│                                    │
│ 📍 Live Location Sharing:          │
│ Omar_Expert shared live location   │
│ "At Café Atlas now - great vibes!" │
│                                    │
│ 💡 Room Tip: 3 people booking      │
│ together = extra 10% discount!     │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │ Share deal 📤 Photo 📷 Voice 🎤│ │
│ │ Type message...                 │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```
**Business Value**: PERFECT example of ADDON amplification - business deal creates social discovery + Guide ADDON connection

### 10.3 Create New Room Screen
```
┌─────────────────────────────────────┐
│ ← ➕ Create New Room                │
│                                    │
├─────────────────────────────────────┤
│                                    │
│ Room Details:                      │
│                                    │
│ Room Name                          │
│ ┌─────────────────────────────────┐ │
│ │ #spa-weekend-deals-casa         │ │
│ └─────────────────────────────────┘ │
│                                    │
│ Category                           │
│ [💆 Wellness ▼]                   │
│                                    │
│ Description                        │
│ ┌─────────────────────────────────┐ │
│ │ Share weekend spa deals and     │ │
│ │ wellness experiences in Casa    │ │
│ └─────────────────────────────────┘ │
│                                    │
│ Location                           │
│ [📍 Casablanca ▼]                 │
│                                    │
│ Room Settings:                     │
│ ☑️ Public room (anyone can join)   │
│ ☐ Private room (invite only)       │
│ ☑️ Allow deal sharing              │
│ ☑️ Enable live locations           │
│ ☐ Tourism premium only 🔒          │
│                                    │
│ Cultural Settings:                 │
│ ☑️ Prayer-time aware               │
│ ☑️ Halal-only venues               │
│ ☑️ Ramadan mode compatible         │
│                                    │
│ Moderation:                        │
│ Auto-approve members: ☑️ Yes       │
│ Content filtering: ☑️ Enabled      │
│                                    │
│ [Create Room] [Save as Draft]      │
└─────────────────────────────────────┘
```
**Business Value**: Enable community-driven business discovery and deal sharing

---

## 11. Tourism Premium Features
*(Development: Week 4 - Days 1-2)*

### 11.1 Premium Upgrade Flow
```
┌─────────────────────────────────────┐
│ 🌟 Upgrade to Tourism Premium       │
│ Unlock Authentic Morocco            │
├─────────────────────────────────────┤
│                                    │
│     Welcome to Premium Morocco! 🇲🇦  │
│                                    │
│ What you get for 15€/month:        │
│                                    │
│ ✅ **Local Expert Access**         │
│    Personal cultural guides        │
│    Real-time chat support          │
│    Insider knowledge & tips        │
│                                    │
│ ✅ **Exclusive Premium Rooms**     │
│    #marrakech-hidden-gems 🔒       │
│    #authentic-experiences 🔒       │
│    #vip-cultural-events 🔒         │
│                                    │
│ ✅ **Priority Booking**            │
│    Best venues, best times         │
│    Skip waiting lists              │
│    Premium-only time slots         │
│                                    │
│ ✅ **Cultural Integration**        │
│    Prayer-time smart planning      │
│    Islamic calendar awareness      │
│    Halal guarantee verification    │
│                                    │
│ ✅ **24/7 Tourist Support**        │
│    Emergency assistance            │
│    Translation help                │
│    Cultural etiquette guidance     │
│                                    │
│ 💎 Current Offer: 7-Day Free Trial │
│                                    │
│ Payment Options:                   │
│ 💳 15€/month • 💳 150€/year (save 17%)│
│                                    │
│ [Start Free Trial] [Learn More]    │
│ [Continue as Free User]            │
└─────────────────────────────────────┘
```
**Business Value**: Premium revenue stream (30% of total revenue) + authentic Morocco positioning

### 11.2 Local Expert Matching Screen
```
┌─────────────────────────────────────┐
│ 🌍 Your Local Expert                │
│ Personal Morocco cultural guide     │
├─────────────────────────────────────┤
│                                    │
│ 📱 Matched Expert:                  │
│                                    │
│ ┌─────────────────────────────────┐ │
│ │     [Expert Photo]              │ │
│ │   🌟 Samir Ben-Ali              │ │
│ │   📍 Marrakech Cultural Guide   │ │
│ │   ⭐ 4.9/5 • 156 tourists helped│ │
│ │   🗣️ Arabic, French, English   │ │
│ │                                 │ │
│ │   "Ahlan wa sahlan! I'm here   │ │
│ │   to show you authentic Morocco │ │
│ │   beyond tourist traps!"        │ │
│ └─────────────────────────────────┘ │
│                                    │
│ What Samir can help with:          │
│ ✅ Restaurant recommendations       │
│ ✅ Cultural site guidance          │
│ ✅ Shopping & bargaining tips      │
│ ✅ Prayer time coordination        │
│ ✅ Local event invitations         │
│ ✅ Emergency assistance            │
│                                    │
│ 💬 Quick Chat Starters:            │
│ • "Where's best authentic tagine?" │
│ • "What should I wear to mosque?"  │
│ • "Any local festivals this week?" │
│ • "Help me plan my day around      │
│   prayer times"                    │
│                                    │
│ [💬 Start Chat] [📞 Voice Call]    │
│ [📍 Meet in Person] [Switch Expert]│
│                                    │
│ Samir earned: 47€ this month       │
│ from helping tourists like you     │
└─────────────────────────────────────┘
```
**Business Value**: Local expert monetization creates sustainable local economy + authentic tourism experience

### 11.3 Cultural Integration Dashboard
```
┌─────────────────────────────────────┐
│ 🕌 Cultural Dashboard               │
│ Your Morocco cultural assistant     │
├─────────────────────────────────────┤
│                                    │
│ Today - Thursday, March 15         │
│ Regular day • No special events    │
│                                    │
│ 🕐 Prayer Schedule - Marrakech:     │
│ ✅ Fajr: 06:18 (Completed)         │
│ ✅ Dhuhr: 13:42 (Completed)        │
│ ⏰ Asr: 16:55 (in 1h 25min)        │
│ 🌅 Maghrib: 18:28                  │
│ 🌙 Isha: 19:54                     │
│                                    │
│ 🎯 Smart Planning for Today:       │
│ • Best activity window: Now-16:30  │
│ • Mosque visits: After Asr only    │
│ • Shopping: Avoid 16:45-17:15      │
│ • Dining: Book dinner after 20:00  │
│                                    │
│ 📅 Cultural Calendar:              │
│ March 20 - Spring Equinox 🌸       │
│ Garden festivals begin             │
│                                    │
│ April 10 - Ramadan Begins 🌙       │
│ Special Iftar experiences          │
│ Modified business hours            │
│                                    │
│ 🧭 Cultural Tips Today:            │
│ • Dress modestly for old medina    │
│ • Right hand for greetings/eating  │
│ • "Inshallah" = God willing        │
│ • Bargain expected in souks        │
│                                    │
│ 🆘 Emergency Contacts:             │
│ Tourist Police: 190                │
│ [Your Embassy] [Medical Help]      │
│ [Your Expert: Samir] [Translation] │
│                                    │
│ [🏠] [🔍] [💬] [👤] [🎯]         │
└─────────────────────────────────────┘
```
**Business Value**: Morocco cultural differentiation - no competitor offers this level of cultural integration

---

## 21. Standard App Screens
*(Development: Week 4 - Day 5)*

### 21.1 About Us Screen
```
┌─────────────────────────────────────┐
│ ← ℹ️ About DeadHour                 │
│                                    │
├─────────────────────────────────────┤
│                                    │
│         🕐 DeadHour                │
│      Version 1.0.0 (Build 15)      │
│                                    │
│ 🎯 Our Mission:                    │
│ Connecting businesses with customers│
│ during off-peak hours while building│
│ authentic local communities that    │
│ help everyone discover the real     │
│ Morocco.                           │
│                                    │
│ 🌟 What Makes Us Different:        │
│ • First infinite-scalability ADDON platform      │
│ • Morocco cultural integration     │
│ • Room-based social discovery      │
│ • Tourism + local expertise        │
│ • Prayer-time aware scheduling     │
│                                    │
│ 👥 Team & Company:                 │
│ Founded in 2024 in Casablanca      │
│ Dedicated to empowering local      │
│ businesses and building bridges    │
│ between tourists and locals.       │
│                                    │
│ 🌍 Our Impact So Far:              │
│ • 12,450+ users helped             │
│ • 1.2M+ MAD saved by community     │
│ • 350+ venues optimized            │
│ • 2,340+ tourist-local connections │
│ • 47 active community rooms        │
│                                    │
│ 📞 Contact Information:            │
│ 📧 hello@deadhour.ma               │
│ 📱 +212 5XX-XXX-XXX               │
│ 📍 Casablanca, Morocco             │
│ 🌐 www.deadhour.ma                 │
│                                    │
│ 🤝 Connect With Us:                │
│ [📘 Facebook] [📷 Instagram]       │
│ [🐦 Twitter] [💼 LinkedIn]         │
│                                    │
│ 📄 Legal & Policies:               │
│ [Terms of Service] [Privacy Policy]│
│ [Cookie Policy] [Data Rights]      │
│                                    │
│ 💝 Acknowledgments:                │
│ Built with ❤️ for Morocco          │
│ Special thanks to our beta testers │
│ and local business partners        │
└─────────────────────────────────────┘
```
**Business Value**: Brand mission and ADDON stacking value proposition explanation

### 21.2 Privacy & Data Management
```
┌─────────────────────────────────────┐
│ ← 🔒 Privacy & Data                 │
│                                    │
├─────────────────────────────────────┤
│                                    │
│ 🛡️ Your Data, Your Control          │
│                                    │
│ 📊 Data We Collect:                │
│ ☑️ Profile information (name, photo)│
│ ☑️ Location (for nearby venues)     │
│ ☑️ Booking history & preferences    │
│ ☑️ Community interactions          │
│ ☑️ App usage analytics             │
│                                    │
│ 🎯 How We Use Your Data:           │
│ • Personalized venue recommendations│
│ • Prayer time accurate scheduling  │
│ • Community room suggestions       │
│ • Booking optimization insights    │
│ • Customer support assistance      │
│                                    │
│ 🔐 Privacy Controls:               │
│                                    │
│ Profile Visibility:                │
│ ● Public (everyone can see)        │
│ ○ Friends only                     │
│ ○ Private (only me)                │
│                                    │
│ Location Sharing:                  │
│ ● Share with nearby venues         │
│ ○ Community members only           │
│ ○ Never share location             │
│                                    │
│ Activity Visibility:               │
│ ☑️ Show my bookings to friends     │
│ ☐ Show room participation         │
│ ☑️ Allow venue recommendations     │
│ ☐ Share with local experts         │
│                                    │
│ 📱 Data Portability:               │
│ [📥 Download My Data]              │
│ [📤 Export Booking History]        │
│ [📊 View Analytics Dashboard]      │
│                                    │
│ 🗑️ Data Deletion:                 │
│ [Delete Specific Data Types]       │
│ [Deactivate Account]               │
│ [Permanently Delete Account]       │
│                                    │
│ 📧 Communication Preferences:      │
│ ☑️ Deal notifications              │
│ ☑️ Community messages              │
│ ☑️ Booking confirmations           │
│ ☐ Marketing emails                 │
│ ☑️ Safety & security alerts        │
│                                    │
│ 📄 Legal Documents:                │
│ [Privacy Policy] [Terms of Service]│
│ [Cookie Policy] [Data Protection]  │
│                                    │
│ Last updated: March 15, 2024       │
└─────────────────────────────────────┘
```
**Business Value**: GDPR compliance and user trust - essential for international expansion

### 21.3 Language & Region Settings
```
┌─────────────────────────────────────┐
│ ← 🌍 Language & Region              │
│                                    │
├─────────────────────────────────────┤
│                                    │
│ 🗣️ App Language                    │
│                                    │
│ ● العربية (Arabic)                 │
│   Right-to-left interface          │
│   Full Morocco localization        │
│                                    │
│ ○ Français (French)                │
│   Standard French with Morocco     │
│   cultural adaptations             │
│                                    │
│ ○ English                          │
│   International English with       │
│   Morocco context explanations     │
│                                    │
│ 📍 Current Region: Morocco 🇲🇦      │
│                                    │
│ 🏙️ Active City: Casablanca         │
│ [Change City ▼]                    │
│ Options: Casa, Rabat, Marrakech,   │
│ Fes, Tangier, Agadir              │
│                                    │
│ 💰 Currency Display                │
│ ● Moroccan Dirham (MAD)           │
│ ○ Euro (EUR) - For tourists        │
│ ○ US Dollar (USD) - International  │
│                                    │
│ 🕐 Date & Time Format              │
│ ● 24-hour format (15:30)          │
│ ○ 12-hour format (3:30 PM)        │
│                                    │
│ Islamic Calendar: ✅ Show alongside │
│ Gregorian dates for cultural events│
│                                    │
│ 🕌 Cultural Preferences            │
│ ☑️ Prayer time integration         │
│ ☑️ Islamic calendar events         │
│ ☑️ Ramadan mode auto-enable        │
│ ☑️ Halal venue prioritization      │
│ ☑️ Cultural etiquette tips         │
│                                    │
│ 🔄 Auto-Update Settings            │
│ ☑️ Download prayer time updates    │
│ ☑️ Cultural calendar sync          │
│ ☑️ Local holiday notifications     │
│                                    │
│ [Apply Changes] [Reset to Default] │
│ [Preview Interface]                │
└─────────────────────────────────────┘
```
**Business Value**: Morocco market cultural adaptation - Arabic RTL support, prayer times, Islamic calendar

---

## Technical Implementation (MVP)

### Firebase Backend Stack
**Core Technologies**:
- **Authentication**: Firebase Auth with phone verification
- **Database**: Firestore for real-time data (venues, bookings, rooms)
- **Storage**: Firebase Storage for venue images
- **Messaging**: FCM for deal notifications and room messages
- **Functions**: Cloud Functions for business logic (commission calculations)

### 4-Week Development Plan
**Week 1**: Authentication (including business registration) + Navigation + Home screens  
**Week 2**: Categories + Venue details + Booking flow + Basic business onboarding  
**Week 3**: Room-based chat + Search + User profiles + Deal creation interface  
**Week 4**: Complete business dashboard + Dead hours analytics + Tourism features + Revenue tracking  

### Success Metrics (MVP)
**Business Platform Validation**:
- Businesses can identify dead hours and create deals in <5 minutes
- Dead hour bookings increase by 40%+ within first month
- Business revenue during dead hours increases by 60%+
- Platform commission generates sustainable revenue stream

**Dual-Problem Validation**:
- Business deals create 20%+ booking increase during dead hours  
- Community rooms drive 40%+ social-based bookings
- Tourist premium conversion rate >15%
- Network effects: Cross-problem engagement >30%

**Business Adoption Metrics**:
- 80%+ of businesses create their first deal within 7 days
- Average business creates 3+ recurring dead hour deals
- 70%+ of businesses see positive ROI within first month

---

## Investor Demo Flow

**Perfect User Journey to Show Investors**:

1. **Business Problem**: Show business dashboard with dead hours = lost revenue
2. **Social Problem**: Show user struggling to discover authentic venues 
3. **Dual Solution**: Business posts deal in room → Community engages → User books → Business gets revenue
4. **Network Effects**: More users = more audience for deals = more deals = more discovery options
5. **Revenue**: Commission from booking + Premium tourism subscriptions + Business SaaS

**Key Screen Sequence**:
Business Dashboard → Room Chat with Deal → User Books → Revenue Generated

This MVP proves the **entire ADDON stacking platform concept** with 90% of the value in just 4 weeks of development.