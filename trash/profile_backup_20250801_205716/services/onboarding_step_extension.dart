import 'onboarding_step.dart';

extension OnboardingStepExtension on OnboardingStep {
  String get title {
    switch (this) {
      case OnboardingStep.welcome:
        return 'Welcome to DeadHour';
      case OnboardingStep.features:
        return 'Discover Features';
      case OnboardingStep.categories:
        return 'Explore Categories';
      case OnboardingStep.community:
        return 'Join the Community';
      case OnboardingStep.guestOrSignup:
        return 'Get Started';
      case OnboardingStep.completed:
        return 'Ready to Explore';
    }
  }

  String get description {
    switch (this) {
      case OnboardingStep.welcome:
        return 'Find amazing deals during businesses\' dead hours across Morocco';
      case OnboardingStep.features:
        return 'Book deals, join community rooms, and discover authentic experiences';
      case OnboardingStep.categories:
        return 'Food, Entertainment, Wellness, Tourism, Sports, and Family activities';
      case OnboardingStep.community:
        return 'Connect with locals and tourists in category-based rooms';
      case OnboardingStep.guestOrSignup:
        return 'Explore as a guest or create an account for the full experience';
      case OnboardingStep.completed:
        return 'You\'re all set! Start discovering Morocco\'s hidden gems';
    }
  }

  String get imagePath {
    switch (this) {
      case OnboardingStep.welcome:
        return 'https://images.unsplash.com/photo-1539650116574-75c0c6d45d2e?w=400&h=400&fit=crop';
      case OnboardingStep.features:
        return 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=400&fit=crop';
      case OnboardingStep.categories:
        return 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=400&fit=crop';
      case OnboardingStep.community:
        return 'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=400&h=400&fit=crop';
      case OnboardingStep.guestOrSignup:
        return 'https://images.unsplash.com/photo-1633356122544-f134324a6cee?w=400&h=400&fit=crop';
      case OnboardingStep.completed:
        return 'https://images.unsplash.com/photo-1521791136064-7986c2920216?w=400&h=400&fit=crop';
    }
  }
}