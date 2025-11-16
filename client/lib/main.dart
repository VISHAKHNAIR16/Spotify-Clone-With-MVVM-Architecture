import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/providers/current_user_notifier.dart';
import 'package:spotify_clone/core/theme/size_config.dart';
import 'package:spotify_clone/core/theme/theme.dart';
import 'package:spotify_clone/features/home/view/home_page.dart';
import 'package:spotify_clone/features/auth/view/pages/signup_page.dart';
import 'package:spotify_clone/features/auth/viewmodel/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreference();
  await container.read(authViewModelProvider.notifier).getData();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {

    final currentUser = ref.watch(currentUserProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify App',
      theme: AppTheme.darkThemeMode,
      home: currentUser == null ? const SignupPage() : const HomePage(),
    );
  }
}
