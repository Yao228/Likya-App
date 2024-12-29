import 'package:flutter/material.dart';
import 'package:likya_app/presentation/auth/pages/auth_screen.dart';
import 'package:likya_app/common/widgets/container_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 90,
              top: 90,
            ),
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                //first page
                buildImageContainer(
                  Colors.white,
                  'Votre santé, notre priorité.',
                  'Créez des cagnottes en toute simplicité, mobilisez vos proches et financez vos soins médicaux sans souci.',
                  'assets/images/onboarding_1.png',
                ),

                // Second page
                buildImageContainer(
                  Colors.white,
                  'Cagnotte de contributions.',
                  'Cartes bancaires, mobile money, ou virements – vos contributeurs ont le choix pour soutenir vos besoins.',
                  'assets/images/onboarding_2.png',
                ),

                //last page
                buildImageContainer(
                  Colors.white,
                  'Payez sans inetrmédiaire.',
                  'Utilisez votre cagnotte pour régler directement vos frais médicaux chez nos prestataires partenaires, via QR code sécurisé.',
                  'assets/images/onboarding_3.png',
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton.icon(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showAuthPage', true);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AuthPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: Color(0xFF94A2AB),
              ),
              iconAlignment: IconAlignment.end,
              label: const Text(
                "Passer",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF94A2AB),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmoothPageIndicator(
              controller: controller,
              count: 3, // Nombre de pages
              effect: ExpandingDotsEffect(
                activeDotColor: const Color(0xFF2FA9A2),
                dotColor: Colors.grey.shade300,
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 3,
              ),
            ),
            const SizedBox(height: 20),
            _currentPage == 0
                ? SizedBox(
                    width: double.infinity, // Full wide
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: const Color(0xFF2FA9A2),
                        minimumSize: const Size(198, 40),
                      ),
                      onPressed: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        "Suivant",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage > 0)
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: const Color(0xFF2FA9A2),
                            minimumSize: const Size(120, 40),
                          ),
                          onPressed: () {
                            controller.previousPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text(
                            "Précédent",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        )
                      else
                        const SizedBox(width: 120),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: const Color(0xFF2FA9A2),
                          minimumSize: const Size(120, 40),
                        ),
                        onPressed: () async {
                          if (_currentPage == 2) {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('showAuthPage', true);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const AuthPage(),
                              ),
                            );
                          }
                          {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(
                          _currentPage == 2 ? "Terminé" : "Suivant",
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
