import 'package:flutter_test/flutter_test.dart';
import 'package:vstech_home_services/app.dart';
import 'package:vstech_home_services/core/di/injection.dart';
import 'package:vstech_home_services/core/router/app_router.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/splash_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/onboarding_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/splash_page.dart';

import 'helpers/mocks.dart';

void main() {
  testWidgets('App boots with SplashPage and navigates to OnboardingPage', (tester) async {
    final session = SessionCubit(MockAuthTokenStore());
    addTearDown(session.close);
    getIt.registerFactory<SplashCubit>(() => SplashCubit(session, MockGetProfileUseCase()));
    addTearDown(getIt.reset);
    await tester.pumpWidget(VstechHomeServicesApp(router: createAppRouter(session: session)));
    await tester.pump();

    // Verify SplashPage is initially mounted
    expect(find.byType(SplashPage), findsOneWidget);

    // Wait for splash timer (2500ms) and navigation transition to complete
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();

    // Verify OnboardingPage is presented
    expect(find.byType(OnboardingPage), findsOneWidget);
  });
}
