import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chat_hub/presentation/screens/auth/login_screen.dart';
import 'package:chat_hub/presentation/screens/auth/signup_screen.dart';
import 'package:chat_hub/router/app_router.dart';
import 'package:chat_hub/data/services/service_locator.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ---- Illustrations ----
              Image.asset("assets/images/intro_final.png", height: 240)
                  .animate()
                  .fadeIn(duration: 700.ms)
                  .slideY(begin: 0.3, end: 0, duration: 700.ms),

              const SizedBox(height: 30),

              // ---- Title ----
              Text(
                    "Welcome to ChatHub",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 12),

              // ---- Description ----
              Text(
                    "Fast, secure and effortless messaging.\nConnect with your world instantly.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 50),

              // ---- Sign Up Button ----
              SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        getit<AppRouter>().push(const SignupScreen());
                      },
                      child: const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 700.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 16),

              // ---- Login Button ----
              SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          width: 1.6,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        getit<AppRouter>().push(const LoginScreen());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 900.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
