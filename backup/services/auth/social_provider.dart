// Social login providers
enum SocialProvider {
  google('Google'),
  facebook('Facebook'),
  apple('Apple');

  const SocialProvider(this.name);
  final String name;
}