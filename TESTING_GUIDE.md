# 🧪 DeadHour App - Testing Guide

## 🚀 **Quick Start Testing**

### **1. Use Development Menu**
- Open app → Pull drawer from left side
- **Dev Menu** provides quick access to all screens
- Test navigation between features easily

### **2. Test Guest Mode Flow**
```
🔓 Guest Experience Test:
1. Open app (starts in guest mode)
2. Browse deals, rooms, tourism → ✅ Should work freely
3. Try to book a deal → ❓ Login prompt should appear
4. Try to join room → ❓ Login prompt should appear  
5. Try to post message → ❓ Login prompt should appear
6. Click "Sign In" → 📱 Should go to Profile screen
```

### **3. Test Authentication Flow**
```
🔐 Auth Flow Test:
1. Go to Profile screen
2. Try "Continue as Guest" → ✅ Should enable guest mode
3. Try "Sign Up" → 📝 Should show registration  
4. Try "Login" → 🔑 Should show login form
5. Mock login → 👤 Should show full profile
```

### **4. Test Role Switching**
```
🎭 Role Management Test:
1. Login with mock user → Has Consumer + Business roles
2. Go to Profile → Role Management section
3. Switch between roles → ✅ Should change active role
4. Access role features → Business dashboard, etc.
```

## 🔍 **Feature Testing Checklist**

### **Navigation & UI**
- [ ] **Bottom Navigation** - 4 tabs: Discover, Community, Explore, Profile
- [ ] **Dev Menu Drawer** - All screens accessible
- [ ] **Back Navigation** - Proper back button behavior
- [ ] **Route Management** - Deep linking and state preservation

### **Guest Mode**
- [ ] **Free Browsing** - All content visible without login
- [ ] **Auth Prompts** - Appear only for actions requiring login
- [ ] **Multiple Prompt Styles** - Dialog vs snackbar vs redirect
- [ ] **Conversion Flow** - Guest → authenticated user path

### **Authentication**
- [ ] **Profile States** - Guest, logged out, logged in views
- [ ] **Mock Login** - Test user creation and login flow  
- [ ] **Role Management** - Multi-role switching interface
- [ ] **Session Persistence** - Login state maintained

### **Core Features**
- [ ] **Deals Browsing** - View deals, filters, categories
- [ ] **Deal Booking** - Auth required, confirmation flow
- [ ] **Community Rooms** - Browse, join (auth), create (auth)
- [ ] **Room Chat** - View messages, post (auth required)
- [ ] **Tourism** - Browse content, expert requests (auth)
- [ ] **Business Dashboard** - Role-based access

### **Morocco Integration**
- [ ] **Prayer Times** - Display and integration
- [ ] **Cultural Filters** - Halal, prayer-aware features
- [ ] **Multi-language** - Arabic, French, English
- [ ] **Local Context** - Morocco cities and culture

## 🛠️ **Development Commands**

### **Analysis & Linting**
```bash
flutter analyze          # Check for issues
dart fix --apply         # Auto-fix lint issues  
flutter pub get          # Update dependencies
```

### **Building (Testing Only)**
```bash
# DO NOT run flutter run - as per CLAUDE.md
flutter analyze          # Static analysis
flutter test            # Run tests (when available)
```

## 🐛 **Common Issues & Solutions**

### **Navigation Issues**
- **Problem**: Route not found
- **Solution**: Check AppRouter.dart for correct route definitions
- **Test**: Use Dev Menu to verify all routes work

### **Auth Issues**  
- **Problem**: Auth prompts not showing
- **Solution**: Ensure screen uses ConsumerWidget and AuthHelpers
- **Test**: Try actions as guest user

### **State Issues**
- **Problem**: Role switching not working
- **Solution**: Check RoleToggleProvider state management
- **Test**: Switch roles in Profile screen

### **Performance Issues**
- **Problem**: Slow navigation
- **Solution**: Check for unnecessary rebuilds in ConsumerWidgets
- **Test**: Monitor performance during navigation

## 📱 **Test Scenarios**

### **Scenario 1: New User Journey**
1. **Start** → App opens, user is guest
2. **Explore** → Browse deals, rooms, tourism
3. **Engage** → Try to book → Login prompt
4. **Convert** → Register → Complete profile
5. **Use** → Book deals, join rooms, switch roles

### **Scenario 2: Returning User**
1. **Start** → App opens, user logged in
2. **Navigate** → Use all features without prompts
3. **Switch** → Change roles via Profile
4. **Create** → Post in rooms, create deals

### **Scenario 3: Business Owner**
1. **Login** → Access Profile → Switch to Business role
2. **Dashboard** → View business analytics
3. **Create** → Add new deals for venue
4. **Manage** → View bookings and performance

### **Scenario 4: Tourist User**
1. **Start** → Guest mode, explore tourism
2. **Connect** → Try expert request → Login prompt
3. **Premium** → Access premium tourism features
4. **Cultural** → Use prayer times, halal filters

## ✅ **Success Criteria**

### **Guest Mode Success**
- ✅ Users can explore all content without barriers
- ✅ Auth prompts only appear for actions requiring login
- ✅ Login prompts are clear and helpful
- ✅ Conversion from guest to user is smooth

### **Navigation Success**
- ✅ All screens accessible via dev menu
- ✅ Bottom navigation works correctly
- ✅ Back button behavior is intuitive
- ✅ No navigation errors or crashes

### **Feature Success**  
- ✅ All core features work as guest (view-only)
- ✅ All interactive features require auth appropriately
- ✅ Role switching provides correct feature access
- ✅ Morocco cultural features are integrated

### **Technical Success**
- ✅ Flutter analyze shows no issues
- ✅ No runtime errors during testing
- ✅ Smooth performance across all features
- ✅ Proper error handling and user feedback

**Ready for comprehensive testing and Morocco market validation! 🇲🇦🚀**