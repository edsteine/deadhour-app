# DeadHour API Documentation

This document outlines the API specifications for the DeadHour platform, designed to support both consumer and business applications with comprehensive endpoints for deals, venues, users, and community features.

## 🌐 Base URL
```
Production: https://api.deadhour.ma/v1
Staging: https://staging-api.deadhour.ma/v1
Development: http://localhost:3000/api/v1
```

## 🔐 Authentication

### Overview
The API uses JWT (JSON Web Tokens) for authentication with refresh token support.

### Authentication Flow
```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "user_123",
      "email": "user@example.com",
      "name": "Ahmed Hassan",
      "type": "consumer",
      "profilePicture": "https://cdn.deadhour.ma/profiles/user_123.jpg"
    },
    "tokens": {
      "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "expiresIn": 3600
    }
  }
}
```

### Token Usage
Include the access token in the Authorization header:
```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

## 👤 User Management

### Register User
```http
POST /auth/register
Content-Type: application/json

{
  "name": "Ahmed Hassan",
  "email": "ahmed@example.com",
  "password": "securepassword",
  "phone": "+212600123456",
  "type": "consumer",
  "location": {
    "city": "Casablanca",
    "district": "Maarif"
  },
  "preferences": {
    "categories": ["food", "entertainment"],
    "priceRange": "medium",
    "radius": 5
  }
}
```

### Get User Profile
```http
GET /users/profile
Authorization: Bearer {token}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "user_123",
    "name": "Ahmed Hassan",
    "email": "ahmed@example.com",
    "phone": "+212600123456",
    "type": "consumer",
    "profilePicture": "https://cdn.deadhour.ma/profiles/user_123.jpg",
    "location": {
      "city": "Casablanca",
      "district": "Maarif",
      "coordinates": {
        "latitude": 33.5731,
        "longitude": -7.5898
      }
    },
    "preferences": {
      "categories": ["food", "entertainment"],
      "priceRange": "medium",
      "radius": 5,
      "notifications": {
        "deals": true,
        "community": true,
        "marketing": false
      }
    },
    "stats": {
      "dealsBooked": 23,
      "totalSavings": 1250.50,
      "favoriteVenues": 8,
      "communityRooms": 5
    }
  }
}
```

### Update User Profile
```http
PUT /users/profile
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "Ahmed Hassan",
  "preferences": {
    "categories": ["food", "entertainment", "wellness"],
    "radius": 10
  }
}
```

## 🏢 Venue Management

### Get Venues
```http
GET /venues?city=Casablanca&category=food&radius=5&lat=33.5731&lng=-7.5898
Authorization: Bearer {token}
```

**Query Parameters:**
- `city` (optional): Filter by city
- `category` (optional): Filter by category (food, entertainment, wellness, sports, tourism, family)
- `radius` (optional): Search radius in kilometers
- `lat`, `lng` (optional): User coordinates for distance calculation
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 20)

**Response:**
```json
{
  "success": true,
  "data": {
    "venues": [
      {
        "id": "venue_123",
        "name": "Café Atlas",
        "description": "Traditional Moroccan café with modern ambiance",
        "category": "food",
        "subcategory": "café",
        "location": {
          "address": "123 Mohammed V Avenue, Gueliz",
          "city": "Marrakech",
          "district": "Gueliz",
          "coordinates": {
            "latitude": 31.6295,
            "longitude": -7.9811
          }
        },
        "contact": {
          "phone": "+212524123456",
          "email": "info@cafeatlas.ma",
          "website": "https://cafeatlas.ma"
        },
        "images": [
          "https://cdn.deadhour.ma/venues/venue_123_1.jpg",
          "https://cdn.deadhour.ma/venues/venue_123_2.jpg"
        ],
        "rating": 4.5,
        "reviewCount": 127,
        "priceRange": "$$",
        "amenities": ["wifi", "parking", "terrace", "air_conditioning"],
        "hours": {
          "monday": "08:00-22:00",
          "tuesday": "08:00-22:00",
          "wednesday": "08:00-22:00",
          "thursday": "08:00-22:00",
          "friday": "08:00-23:00",
          "saturday": "08:00-23:00",
          "sunday": "09:00-22:00"
        },
        "activeDeals": 3,
        "distance": 2.3
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 45,
      "pages": 3
    }
  }
}
```

### Get Venue Details
```http
GET /venues/{venue_id}
Authorization: Bearer {token}
```

## 🔥 Deal Management

### Get Deals
```http
GET /deals?category=food&city=Casablanca&active=true&sort=discount_desc
Authorization: Bearer {token}
```

**Query Parameters:**
- `category` (optional): Filter by category
- `city` (optional): Filter by city
- `venue_id` (optional): Filter by specific venue
- `active` (optional): Show only active deals (default: true)
- `sort` (optional): Sort by (discount_desc, discount_asc, time_asc, time_desc, popularity)
- `min_discount` (optional): Minimum discount percentage
- `max_price` (optional): Maximum price after discount

**Response:**
```json
{
  "success": true,
  "data": {
    "deals": [
      {
        "id": "deal_123",
        "title": "Afternoon Coffee Special",
        "description": "Premium coffee with traditional Moroccan pastry",
        "venue": {
          "id": "venue_123",
          "name": "Café Atlas",
          "location": "Gueliz, Marrakech",
          "image": "https://cdn.deadhour.ma/venues/venue_123_thumb.jpg"
        },
        "category": "food",
        "subcategory": "café",
        "pricing": {
          "originalPrice": 45.00,
          "discountedPrice": 27.00,
          "discountPercentage": 40,
          "currency": "MAD"
        },
        "availability": {
          "totalSpots": 50,
          "bookedSpots": 23,
          "availableSpots": 27
        },
        "timing": {
          "validFrom": "2024-01-15T14:00:00Z",
          "validUntil": "2024-01-15T18:00:00Z",
          "timezone": "Africa/Casablanca"
        },
        "conditions": {
          "minAge": null,
          "maxGroupSize": 4,
          "advanceBooking": "30min",
          "cancellationPolicy": "2h_before"
        },
        "tags": ["popular", "limited_time", "group_discount"],
        "images": [
          "https://cdn.deadhour.ma/deals/deal_123_1.jpg"
        ],
        "bookingCount": 23,
        "rating": 4.7,
        "isBookmarked": false,
        "urgencyLevel": "high"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 89,
      "pages": 5
    }
  }
}
```

### Get Deal Details
```http
GET /deals/{deal_id}
Authorization: Bearer {token}
```

### Book Deal
```http
POST /deals/{deal_id}/book
Authorization: Bearer {token}
Content-Type: application/json

{
  "groupSize": 2,
  "bookingTime": "2024-01-15T15:30:00Z",
  "specialRequests": "Window table preferred",
  "contactPhone": "+212600123456"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "booking": {
      "id": "booking_123",
      "dealId": "deal_123",
      "userId": "user_123",
      "status": "confirmed",
      "groupSize": 2,
      "bookingTime": "2024-01-15T15:30:00Z",
      "totalAmount": 54.00,
      "savings": 36.00,
      "confirmationCode": "DH123456",
      "qrCode": "https://cdn.deadhour.ma/qr/booking_123.png",
      "venue": {
        "name": "Café Atlas",
        "address": "123 Mohammed V Avenue, Gueliz",
        "phone": "+212524123456"
      }
    }
  }
}
```

## 🏪 Business Dashboard

### Business Analytics
```http
GET /business/analytics?period=30d
Authorization: Bearer {business_token}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "overview": {
      "totalRevenue": 15750.00,
      "totalBookings": 234,
      "averageRating": 4.6,
      "activeDeals": 5,
      "newCustomers": 67,
      "returningCustomers": 167
    },
    "revenue": {
      "daily": [
        {"date": "2024-01-01", "amount": 450.00, "bookings": 8},
        {"date": "2024-01-02", "amount": 520.00, "bookings": 12}
      ],
      "byCategory": {
        "food": 12500.00,
        "beverages": 3250.00
      }
    },
    "customers": {
      "demographics": {
        "ageGroups": {
          "18-25": 45,
          "26-35": 89,
          "36-45": 67,
          "46+": 33
        },
        "locations": {
          "Gueliz": 123,
          "Medina": 67,
          "Hivernage": 44
        }
      },
      "peakHours": [
        {"hour": 14, "bookings": 23},
        {"hour": 15, "bookings": 34},
        {"hour": 16, "bookings": 28}
      ]
    },
    "deals": {
      "performance": [
        {
          "dealId": "deal_123",
          "title": "Afternoon Coffee Special",
          "bookings": 45,
          "revenue": 1215.00,
          "conversionRate": 0.23
        }
      ]
    }
  }
}
```

### Create Deal
```http
POST /business/deals
Authorization: Bearer {business_token}
Content-Type: application/json

{
  "title": "Happy Hour Special",
  "description": "Traditional Moroccan tea with pastries",
  "category": "food",
  "subcategory": "beverages",
  "originalPrice": 35.00,
  "discountPercentage": 30,
  "totalSpots": 40,
  "validFrom": "2024-01-20T16:00:00Z",
  "validUntil": "2024-01-20T19:00:00Z",
  "conditions": {
    "maxGroupSize": 6,
    "advanceBooking": "15min"
  },
  "images": ["base64_encoded_image_data"]
}
```

## 💬 Community Features

### Get Community Rooms
```http
GET /community/rooms?city=Casablanca&category=food
Authorization: Bearer {token}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "rooms": [
      {
        "id": "room_123",
        "name": "Casablanca Foodies",
        "displayName": "🍽️ Casa Food Lovers",
        "description": "Discover the best food deals and restaurants in Casablanca",
        "category": "food",
        "categoryIcon": "🍽️",
        "city": "Casablanca",
        "memberCount": 1247,
        "onlineCount": 89,
        "lastActivity": "2024-01-15T10:30:00Z",
        "isJoined": true,
        "isPrivate": false,
        "rules": [
          "Be respectful to all members",
          "Share genuine deals and experiences",
          "No spam or promotional content"
        ],
        "moderators": ["user_456", "user_789"],
        "tags": ["food", "restaurants", "deals", "casablanca"]
      }
    ]
  }
}
```

### Join Room
```http
POST /community/rooms/{room_id}/join
Authorization: Bearer {token}
```

### Get Room Messages
```http
GET /community/rooms/{room_id}/messages?page=1&limit=50
Authorization: Bearer {token}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "messages": [
      {
        "id": "msg_123",
        "userId": "user_456",
        "userName": "Fatima Zahra",
        "userAvatar": "https://cdn.deadhour.ma/avatars/user_456.jpg",
        "content": "Just found an amazing 40% off deal at Café Central!",
        "type": "deal_alert",
        "timestamp": "2024-01-15T14:30:00Z",
        "metadata": {
          "dealId": "deal_789",
          "venueName": "Café Central",
          "discount": "40%",
          "validUntil": "18:00"
        },
        "reactions": {
          "🔥": 12,
          "👍": 8,
          "❤️": 5
        }
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 50,
      "total": 1247,
      "hasMore": true
    }
  }
}
```

### Send Message
```http
POST /community/rooms/{room_id}/messages
Authorization: Bearer {token}
Content-Type: application/json

{
  "content": "Has anyone tried the new restaurant in Maarif?",
  "type": "text",
  "replyTo": "msg_456"
}
```

## 📊 Search and Discovery

### Global Search
```http
GET /search?q=coffee&type=all&city=Marrakech
Authorization: Bearer {token}
```

**Query Parameters:**
- `q`: Search query
- `type`: Search type (all, deals, venues, rooms)
- `city`: Filter by city
- `category`: Filter by category

**Response:**
```json
{
  "success": true,
  "data": {
    "deals": [
      {
        "id": "deal_123",
        "title": "Coffee Special",
        "venue": "Café Atlas",
        "discount": 40,
        "type": "deal"
      }
    ],
    "venues": [
      {
        "id": "venue_123",
        "name": "Coffee House",
        "category": "food",
        "rating": 4.5,
        "type": "venue"
      }
    ],
    "rooms": [
      {
        "id": "room_123",
        "name": "Coffee Lovers",
        "memberCount": 234,
        "type": "room"
      }
    ]
  }
}
```

## 📱 Notifications

### Get Notifications
```http
GET /notifications?unread=true
Authorization: Bearer {token}
```

### Mark as Read
```http
PUT /notifications/{notification_id}/read
Authorization: Bearer {token}
```

### Update Notification Preferences
```http
PUT /users/notification-preferences
Authorization: Bearer {token}
Content-Type: application/json

{
  "deals": true,
  "community": true,
  "bookingReminders": true,
  "marketing": false,
  "pushEnabled": true,
  "emailEnabled": false
}
```

## 🗺️ Location Services

### Get Cities
```http
GET /locations/cities
```

**Response:**
```json
{
  "success": true,
  "data": {
    "cities": [
      {
        "id": "casa",
        "name": "Casablanca",
        "nameAr": "الدار البيضاء",
        "nameFr": "Casablanca",
        "coordinates": {
          "latitude": 33.5731,
          "longitude": -7.5898
        },
        "districts": [
          {"id": "maarif", "name": "Maarif"},
          {"id": "anfa", "name": "Anfa"},
          {"id": "ain_diab", "name": "Ain Diab"}
        ],
        "venueCount": 234,
        "activeDeals": 89
      }
    ]
  }
}
```

## 📈 Analytics and Reporting

### User Analytics
```http
GET /analytics/user?period=30d
Authorization: Bearer {token}
```

### Deal Performance
```http
GET /analytics/deals/{deal_id}?period=7d
Authorization: Bearer {business_token}
```

## 🔧 Utility Endpoints

### Health Check
```http
GET /health
```

### App Configuration
```http
GET /config
Authorization: Bearer {token}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "version": "1.0.0",
    "features": {
      "socialLogin": true,
      "pushNotifications": true,
      "locationServices": true
    },
    "limits": {
      "maxGroupSize": 10,
      "maxImageSize": 5242880,
      "maxMessageLength": 500
    },
    "supportedCities": ["Casablanca", "Rabat", "Marrakech", "Fez", "Tangier"]
  }
}
```

## 🚨 Error Handling

### Error Response Format
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": {
      "field": "email",
      "reason": "Invalid email format"
    },
    "timestamp": "2024-01-15T10:30:00Z",
    "requestId": "req_123456"
  }
}
```

### Common Error Codes
- `AUTHENTICATION_REQUIRED` (401): Missing or invalid token
- `AUTHORIZATION_DENIED` (403): Insufficient permissions
- `RESOURCE_NOT_FOUND` (404): Requested resource doesn't exist
- `VALIDATION_ERROR` (400): Invalid input data
- `RATE_LIMIT_EXCEEDED` (429): Too many requests
- `INTERNAL_SERVER_ERROR` (500): Server error

## 🔒 Security Considerations

### Rate Limiting
- **General API**: 1000 requests per hour per user
- **Authentication**: 5 login attempts per 15 minutes
- **Search**: 100 requests per minute
- **Messaging**: 60 messages per minute

### Data Privacy
- All personal data is encrypted at rest
- Location data is anonymized after 30 days
- User preferences can be deleted upon request
- GDPR compliant data handling

### API Security
- HTTPS required for all endpoints
- JWT tokens expire after 1 hour
- Refresh tokens expire after 30 days
- Input validation and sanitization
- SQL injection prevention
- XSS protection

---

This API documentation provides comprehensive coverage of all DeadHour platform endpoints. For additional information or support, contact the development team or refer to the integration guides.

