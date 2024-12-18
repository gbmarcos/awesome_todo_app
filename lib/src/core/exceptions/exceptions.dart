/// Exception thrown when a provider which is supposed to be overridden was not.
/// See https://riverpod.dev/docs/cookbooks/testing#overriding-the-behavior-of-a-provider-during-tests
class ProviderNotOverriddenException implements Exception {
  final String message;

  ProviderNotOverriddenException({required String name}) : message = "The provider '$name' was not overridden'";
}