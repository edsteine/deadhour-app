# Empty State Screen

## Purpose
Generic empty state screen component that displays engaging, contextual messages when lists, searches, or content areas are empty, helping users understand next steps and maintaining engagement.

## Features
- **Contextual Messaging**: Dynamic messages based on the type of empty content (deals, venues, rooms, etc.)
- **Visual Illustrations**: Engaging graphics and icons that match the empty state context
- **Action Buttons**: Clear call-to-action buttons to guide users toward relevant actions
- **Cultural Sensitivity**: Appropriate messaging and imagery for Morocco market
- **Multi-Language Support**: Empty state messages in Arabic, French, and English
- **Role-Specific Content**: Different empty states based on user roles (Consumer, Business, Guide)
- **Seasonal Messaging**: Special empty state content for Ramadan, holidays, and cultural events
- **Error Recovery**: Distinguish between empty content vs. error states with appropriate messaging
- **Loading States**: Handle loading vs. empty states appropriately
- **Search Suggestions**: Provide search suggestions when search results are empty
- **Onboarding Integration**: Guide new users through first actions when content is empty
- **Refresh Options**: Allow users to refresh or retry when appropriate

## Context-Specific Empty States
- **No Deals Available**: "No active deals right now, but new ones are coming soon!"
- **No Venues Found**: "No venues match your search. Try adjusting your filters."
- **Empty Community Rooms**: "Be the first to start a conversation in this room!"
- **No Bookings**: "You haven't made any bookings yet. Discover great deals nearby!"
- **No Reviews**: "No reviews yet. Be the first to share your experience!"
- **No Favorites**: "You haven't saved any favorites yet. Tap the heart icon to save deals."
- **Empty Search Results**: "No results found. Try different keywords or browse categories."
- **No Notifications**: "All caught up! No new notifications at this time."

## Morocco-Specific Empty States
- **No Halal Options**: "No halal-certified options found. Try expanding your search area."
- **Prayer Time Respect**: "Most venues are currently closed for prayer. Check back soon!"
- **Ramadan Mode**: "Special Ramadan deals will appear closer to Iftar time."
- **Cultural Events**: "No cultural events today. Check the calendar for upcoming celebrations."
- **Local Guides Empty**: "No local guides available right now. Try expanding your location."

## Role-Based Empty States
- **Business Owner**: "No bookings yet today. Consider creating a new deal to attract customers."
- **Guide**: "No tour requests yet. Make sure your profile is complete and visible."
- **Tourist**: "No tourist-friendly venues found. Try browsing popular tourist areas."
- **Premium User**: "No exclusive deals available right now. Check back for premium offers."

## Interactive Elements
- **Primary Action**: Main call-to-action button relevant to the empty state context
- **Secondary Action**: Alternative action or navigation option
- **Refresh Button**: Reload content when appropriate (network issues, outdated content)
- **Browse Alternatives**: Navigate to related content or broader categories
- **Create Content**: For applicable contexts, offer to create first content (reviews, etc.)

## Visual Design
- **Engaging Illustrations**: Custom illustrations that match DeadHour's brand and Morocco culture
- **Cultural Imagery**: Appropriate cultural elements and Moroccan design motifs
- **Accessibility Support**: High contrast options and screen reader compatibility
- **Responsive Layout**: Adapts to different screen sizes and orientations
- **Animation**: Subtle animations to maintain engagement (respecting motion reduction settings)

## User Types
- **All Users**: Context-appropriate empty state messaging and actions
- **New Users**: Onboarding-focused empty states with guidance
- **Returning Users**: Encouraging messages to re-engage with the platform
- **Role-Specific Users**: Tailored empty states based on user roles and permissions

## Navigation
- Used throughout the app wherever lists or content areas might be empty
- Integrated into search results, category browsing, and user-generated content areas
- Appears in community rooms, deal lists, venue searches, and personal content areas

## Screen Category
**Shared/UI** - Reusable empty state component for engaging user experience