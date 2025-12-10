library;

// SDK Configuration
export 'src/core/auth_ninja_config.dart';

// Utilities
export 'src/core/auth_ninja_logger.dart';

// Domain / Public API
export 'src/domain/auth_ninja.dart';

// Export public APIs
export 'src/presentation/auth_ninja_screen.dart';

export 'src/presentation/widgets/email_password_form.dart';
export 'src/core/auth_ninja_state.dart';


/*

Headless use:

final ninja = AuthNinja.instance;

await ninja.signInWithEmail(email, password);
await ninja.signInWithGoogle();
await ninja.signInWithApple();
await ninja.signInWithFacebook();

 */
