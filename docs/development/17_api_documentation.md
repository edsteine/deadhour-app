# DeadHour - API Documentation

**Document Purpose**: This document outlines the API specifications for the DeadHour dual-problem platform, designed to support the multi-role account system and the interaction between business optimization and social discovery features.

**Last Updated**: July 25, 2025

---

## 🌐 Base URL
```
Production: https://api.deadhour.ma/v1
Staging: https://staging-api.deadhour.ma/v1
Development: http://localhost:8000/api/v1
```

## 🔐 Authentication

The API uses JWT (JSON Web Tokens) for authentication. All requests must include a valid `Authorization: Bearer {token}` header.

### Endpoints

-   `POST /auth/register`: Register a new user. The initial role is `consumer` by default.
-   `POST /auth/login`: Log in to receive an access token.
-   `POST /auth/refresh`: Use a refresh token to get a new access token.
-   `POST /auth/logout`: Log out and invalidate the session.

--- 

## 👤 User & Role Management

This section covers endpoints related to user profiles and the multi-role system.

### `GET /users/me`
-   **Description**: Get the profile of the currently authenticated user.
-   **Response**: A user object including their active roles and profile data.

```json
{
  "success": true,
  "data": {
    "id": "user_123",
    "name": "Ahmed Hassan",
    "email": "ahmed@example.com",
    "phone": "+212600123456",
    "active_roles": ["consumer", "guide"],
    "current_role": "consumer",
    "profile_picture_url": "...",
    "preferences": { ... }
  }
}
```

### `PUT /users/me`
-   **Description**: Update the profile of the currently authenticated user.

### `POST /roles/add`
-   **Description**: Add a new role (e.g., 'business', 'guide') to the user's account. Requires a subscription payment process.
-   **Body**: `{ "role": "business" }`

### `POST /roles/switch`
-   **Description**: Switch the user's active role.
-   **Body**: `{ "role": "guide" }`

---

## 🏢 Venue Management (Business Role)

Endpoints for business owners to manage their venues.

-   `GET /venues`: List venues, with filters for category, location, etc.
-   `POST /venues`: Create a new venue (requires Business Role).
-   `GET /venues/{venue_id}`: Get details for a specific venue.
-   `PUT /venues/{venue_id}`: Update a venue.
-   `DELETE /venues/{venue_id}`: Delete a venue.

---

## 🔥 Deal Management

Endpoints for managing dead hour deals.

-   `GET /deals`: Get a list of active deals, with filters.
-   `POST /deals`: Create a new deal (requires Business Role).
-   `GET /deals/{deal_id}`: Get details for a specific deal.
-   `POST /deals/{deal_id}/book`: Book a deal.

---

## 💬 Community & Social Features

Endpoints for managing community rooms and interactions.

-   `GET /rooms`: List all public community rooms.
-   `POST /rooms`: Create a new community room.
-   `GET /rooms/{room_id}`: Get details for a specific room.
-   `POST /rooms/{room_id}/join`: Join a room.
-   `GET /rooms/{room_id}/messages`: Get messages from a room.
-   `POST /rooms/{room_id}/messages`: Post a message to a room.

---

## 📈 Analytics

-   `GET /analytics/business`: Get performance analytics for a business owner.
-   `GET /analytics/user`: Get personal analytics for a user (savings, bookings, etc.).

---

## 🚨 Error Handling

The API uses standard HTTP status codes to indicate the success or failure of a request. The response body for an error will contain a JSON object with `code` and `message` fields.

**Common Error Codes**:
-   `401 Unauthorized`: Authentication token is missing or invalid.
-   `403 Forbidden`: User does not have permission for the action (e.g., non-business user trying to create a deal).
-   `404 Not Found`: The requested resource does not exist.
-   `422 Unprocessable Entity`: The request body is malformed or invalid.

This API is designed to be RESTful and follows standard conventions. All endpoints are versioned under `/v1`.
