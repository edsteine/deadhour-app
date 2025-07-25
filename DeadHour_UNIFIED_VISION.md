# DeadHour - The Unified Vision

**Document Purpose**: This document is the single source of truth for the DeadHour project. It establishes canonical definitions, resolves all strategic inconsistencies, and provides a migration plan for aligning all other project documentation.

**Last Updated**: July 25, 2025

---

## 1. Core Identity: The Dual-Problem Platform

DeadHour's core identity is a **dual-problem platform**. We are the first platform to simultaneously solve two interconnected problems in local economies:

1.  **Business Revenue Optimization**: We help local businesses (restaurants, cafés, etc.) turn their "dead hours"—unprofitable, off-peak periods—into revenue-generating opportunities.
2.  **Social Discovery**: We help consumers (locals and tourists) discover authentic local experiences through a trusted, community-driven social platform.

### The Network Effects Synergy

The innovation of DeadHour lies in the **synergy** between these two problems. They are not solved in isolation; they amplify each other, creating exponential network effects:

-   Business deals posted during dead hours become authentic **content** for the social discovery platform.
-   An engaged community provides a valuable, targeted **audience** for business deals, making them more effective than traditional advertising.
-   More users attract more businesses, which in turn provide more options and value for users, creating a virtuous cycle of growth.

**Official Project Description**: "DeadHour is Morocco's first dual-problem platform where business deals become community discovery opportunities. We connect businesses needing to fill empty seats with a community of locals and tourists seeking authentic experiences, creating powerful network effects that benefit everyone."

---

## 2. Canonical Definitions & Data

### 2.1. Terminology: Multi-Role Account System

The flexible account system is a core **enabler** of our dual-problem solution, not the product itself. It allows a single user to participate in the ecosystem in multiple ways, strengthening the network effects.

-   **Official Term**: **Role**. A user has one account and can activate multiple roles.
-   **Deprecated Terms**: ADDON, Capability, Profile. These terms are to be removed from all documentation.

**Available Roles**:
*   **Consumer Role (Default, Free)**: Discover and book deals, participate in community rooms.
*   **Business Role (Subscription)**: For venue owners to post deals, manage their presence, and access analytics.
*   **Guide Role (Subscription)**: For local experts to share knowledge, offer curated experiences, and earn revenue.
*   **Premium Role (Subscription)**: An upgrade for any user, offering enhanced features across all their active roles.

### 2.2. Market Opportunity & Size

These are the official market size figures to be used across all documents.

-   **Total Addressable User Market**: **20M+**
    -   **Urban Locals**: 8M+
    -   **Annual Tourists**: 13M+
-   **Total Addressable Business Market**: **300,000+** venues in Morocco.

*Note: The previous 55.4M figure is deprecated as it is overly broad. The 20M+ figure is more focused and defensible.*

### 2.3. Business Model & Pricing

Our business model is diversified, leveraging multiple revenue streams that stem from solving the dual problem.

**Revenue Stream Hierarchy**:
1.  **Primary**: **Transaction Commissions (8-15%)**. A commission is taken on successful bookings made through the platform. This directly aligns our success with business success.
2.  **Secondary**: **Role Subscriptions (SaaS)**. Monthly recurring revenue from users who subscribe to Business, Guide, or Premium roles.
3.  **Tertiary**: **Social Commerce & Advertising**. Sponsored content within community rooms and partnerships with tourism boards.

#### Canonical Pricing Table

| Role / Service | Price (EUR) | Price (MAD, approx.) | Billing Cycle | Target Audience |
| :--- | :--- | :--- | :--- | :--- |
| **Business Role** | €30 / month | 330 MAD / month | Monthly | Venue Owners |
| **Guide Role** | €20 / month | 220 MAD / month | Monthly | Local Experts |
| **Premium Role** | €15 / month | 165 MAD / month | Monthly | Power Users, Tourists |
| **Tourism Premium** | €15-20 / stay | 165-220 MAD | One-time | Tourists |
| **Booking Commission** | 8-15% | 8-15% | Per Transaction | Businesses |

---

## 3. Technical Vision

### 3.1. Technical Architecture Evolution

DeadHour will follow a phased technical evolution to balance speed-to-market with long-term scalability.

-   **Phase 1: MVP (Flutter + Firebase)**
    -   **Purpose**: Rapidly validate the core dual-problem hypothesis and network effects in the Moroccan market.
    -   **Stack**: Flutter (iOS/Android), Firebase (Auth, Firestore, Storage, Cloud Functions).
    -   **Rationale**: Fast development, low initial cost, real-time capabilities perfect for social features.

-   **Phase 2: Production (Flutter + Django)**
    -   **Purpose**: Scale the platform to handle a larger user base, more complex analytics, and international expansion.
    -   **Stack**: Flutter (iOS/Android), Django (Python) Backend, PostgreSQL Database, Redis for caching.
    -   **Rationale**: Greater scalability, powerful backend capabilities, robust data management, and suitability for the AI-powered recommendation engine.

This evolution from Firebase to Django is a planned strategic migration, not a correction.

### 3.2. Morocco Cultural Requirements

The following features are critical for the Morocco market and must be integrated from the MVP stage.

-   **Multi-Language Support**: Full UI support for **Arabic (RTL)**, **French**, and **English**.
-   **Prayer Time Integration**: The platform must be aware of the five daily prayer times (Fajr, Dhuhr, Asr, Maghrib, Isha) and account for them in deal scheduling and notifications.
-   **Ramadan Mode**: A special mode during Ramadan with awareness of Suhoor and Iftar timings for deals and events.
-   **Halal Verification**: A system for filtering and displaying halal-certified venues.
-   **Local Currency**: Moroccan Dirham (MAD) as the primary currency, with EUR support for tourists.
-   **Cultural Calendar**: Awareness of religious holidays (e.g., Eid, Mawlid) and local festivals.

---

## 4. Financial Outlook

Financial projections should be presented with both a realistic base case and an optimistic upside case to build investor confidence.

-   **Base Case (Realistic)**: This scenario assumes moderate user adoption and network effects.
    -   **Year 1 Revenue**: $150,000
    -   **Year 2 Revenue**: $1,200,000
    -   **Year 3 Revenue**: $4,000,000

-   **Upside Case (Optimistic)**: This scenario assumes strong network effects and faster international expansion.
    -   **Year 1 Revenue**: $250,000
    -   **Year 2 Revenue**: $2,000,000
    -   **Year 3 Revenue**: $7,500,000

*Note: The base case projections are the primary figures to be used in pitch decks and executive summaries.*

---

## 5. Documentation Migration Plan

This section outlines the plan for updating all existing documents to align with this Unified Vision.

### Priority of Updates

1.  **Critical (Update Immediately)**: `README.md`, `01_executive_summary_MERGED.md`, `10_updated_investor_pitch_flow_MERGED.md`. These are the first documents investors and new team members will see.
2.  **High (Update Next)**: `03_business_strategy_MERGED.md`, `04_financial_projections_MERGED.md`, `claude.md`. These core strategy documents must be aligned.
3.  **Medium (Update as needed)**: All other technical and market analysis documents.

### Document Update Checklist

| Document to Update | Priority | Key Changes Needed |
| :--- | :--- | :--- |
| `README.md` | Critical | - Replace "ADDON platform" with "dual-problem platform".<br>- Update market size to 20M+.<br>- Standardize on "Roles". |
| `claude.md` | High | - Set "dual-problem platform" as the primary definition.<br>- Standardize all terminology to "Roles".<br>- Update pricing to match canonical table. |
| `01_executive_summary_MERGED.md` | Critical | - Ensure the "dual-problem" framing is central.<br>- Use canonical market size and pricing figures. |
| `02_market_analysis_MERGED.md` | High | - Update all market size numbers to the canonical figures (8M+13M). |
| `03_business_strategy_MERGED.md` | High | - Solidify the primary/secondary revenue stream hierarchy.<br>- Embed the canonical pricing table. |
| `04_financial_projections_MERGED.md` | High | - Align all revenue stream assumptions with the Business Strategy.<br>- Use the Base Case projections as the default. |
| `06_mvp_development_guide_MERGED.md` | Medium | - Clarify the MVP is on Firebase as part of the planned evolution. |
| `07_production_app_architecture.md` | Medium | - Add a preamble explaining this is the post-investment architecture, evolving from the Firebase MVP. |
| `10_updated_investor_pitch_flow.md` | Critical | - Re-center the entire pitch around the "dual-problem" narrative. |

### Standardized Language Templates

Use this exact language in all documents to ensure consistency.

-   **To describe the project**: "DeadHour is Morocco's first dual-problem platform where business deals become community discovery opportunities."
-   **To describe the account system**: "The platform features a multi-role account system, allowing a single user to act as a Consumer, Business, Guide, or Premium user, which enhances the network effects of the dual-problem solution."
-   **To explain the core value**: "By solving business revenue optimization and social discovery simultaneously, DeadHour creates exponential network effects that are more powerful and defensible than single-problem solutions."
