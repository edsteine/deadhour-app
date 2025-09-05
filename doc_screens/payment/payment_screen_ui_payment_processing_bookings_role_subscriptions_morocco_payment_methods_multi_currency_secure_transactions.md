# Payment Screen

## Purpose
Handles all payment processing for bookings, role subscriptions, and premium features within the DeadHour platform. Provides secure payment methods tailored for Moroccan and international users.

## Features
- **Multiple Payment Methods**: Credit/debit cards, bank transfers, mobile money, and cash at venue
- **Subscription Management**: Handle Business Role (€30/month), Guide Role (€20/month), Premium Role (€15/month)
- **Booking Payments**: Process deal bookings with 8-15% commission structure
- **Multi-currency Support**: MAD (Moroccan Dirham) primary, EUR for tourists
- **Payment Security**: Encrypted transactions with PCI compliance
- **Split Payments**: Group booking payment distribution
- **Receipt Generation**: Digital receipts with tax information
- **Payment History**: Complete transaction records
- **Refund Processing**: Automated refund handling for cancellations
- **Installment Options**: Payment plans for premium subscriptions

## User Types
- **All User Roles**: Consumer, Business, Guide, Premium users need payment processing
- **Tourists**: International payment methods and currency conversion
- **Group Leaders**: Managing split payments for group bookings
- **Business Owners**: Processing subscription and commission payments

## Navigation
- **Access Points**:
  - Booking Flow → Payment Selection
  - Profile → Role Management → Upgrade/Subscribe
  - Deal Booking → Checkout Process
  - Group Booking → Payment Split
- **Exit Points**:
  - Payment Success → Booking Confirmation
  - Payment Failed → Retry Payment
  - Cancel → Return to Previous Screen
  - Complete → Main Dashboard

## Screen Category
**Transaction Processing** - Core payment handling interface for all monetary transactions

## Integration Points
- **Booking System**: Process deal and experience payments
- **Role Management**: Handle role subscription payments and upgrades
- **Banking APIs**: Integration with Moroccan and international payment processors
- **Group Booking Service**: Split payment calculations and processing
- **Analytics Service**: Track payment success rates and revenue metrics
- **Notification Service**: Payment confirmation and failure alerts
- **Receipt Service**: Generate and store digital receipts
- **Refund Service**: Process cancellation refunds
- **Currency Conversion**: Real-time MAD/EUR exchange rates
- **Tax Calculator**: Moroccan tax calculation and reporting

## Morocco-Specific Features
- **Local Payment Methods**: Integration with Moroccan mobile money and banking
- **MAD Currency Priority**: Native Dirham support with clear currency indication
- **Tourist Payment Support**: EUR acceptance with transparent conversion rates
- **Local Banking Integration**: Support for major Moroccan banks (Attijariwafa, BMCE, etc.)
- **Cultural Payment Preferences**: Cash-at-venue option for cultural comfort
- **Ramadan Payment Adjustments**: Special handling during religious periods