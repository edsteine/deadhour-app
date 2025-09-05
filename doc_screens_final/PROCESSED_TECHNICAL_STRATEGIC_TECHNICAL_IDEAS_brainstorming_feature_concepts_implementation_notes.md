# Strategic and Technical Ideas for Future Consideration

This document captures new strategic and technical ideas proposed for the DeadHour project, which require further discussion, analysis, and planning.

---

## 1. Revised Monetization Strategy: "Free First" Approach

**Current Project Vision:** The established project vision (as per `GEMINI.md` and `DeadHour_UNIFIED_VISION.md`) emphasizes a multi-role account system with immediate revenue generation through paid subscriptions for Business, Guide, and Premium roles.

**Proposed Idea:** Shift the initial monetization strategy to a "free first" approach, especially for the first months and versions of the app.

*   **Rationale:**
    *   Focus on user engagement and adoption without immediate paywalls.
    *   Allow users to "feel at home" and build a strong community base.
    *   Avoid showing premium/subscription prompts everywhere in early stages, as users may dislike it.
*   **Implications:**
    *   Requires re-evaluation of initial financial projections and revenue models.
    *   Defines a clear transition point for introducing paid features/subscriptions after achieving significant user base and traffic.
    *   Impacts the implementation of the multi-role system, potentially making all roles free initially, with premium features introduced later.

---

## 2. Robust Mock Data Architecture and Dependency Injection

**Current Development Strategy:** Development proceeds using mock data (`lib/utils/mock_data.dart`) before connecting to Firebase.

**Proposed Idea:** Implement a more robust file structure for mock data and leverage dependency injection principles.

*   **Rationale:**
    *   Facilitate easier and cleaner transitions between mock data, Firebase, and a future custom backend.
    *   Improve code maintainability and testability.
    *   Ensure proper separation of concerns for data sources.
*   **Considerations:**
    *   Define clear interfaces for data services.
    *   Utilize a dependency injection framework (e.g., Riverpod's `Provider` system for services) to manage data source switching.

---

## 3. Debug Menu Drawer for Route Navigation and Widget Gallery

**Proposed Idea:** Add a development/debug menu drawer to the app.

*   **Purpose:**
    *   **Route Navigation:** Provide quick access to all defined routes/screens in the application for testing and development purposes.
    *   **Widget Gallery (Optional but Recommended):** Include a section to showcase and test individual UI components/widgets in isolation.
*   **Rationale:**
    *   Streamline the development and testing workflow.
    *   Ensure all screens and widgets are accessible and visually correct during development.
    *   Acts as a visual "test harness" for UI elements.
*   **Implementation Notes:**
    *   This drawer should ideally only be visible in debug builds.
    *   It should dynamically list available routes.
