import 'package:flutter/material.dart';
import 'package:explore_mundo/components/botao_gradiente.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class ContatoScreen extends StatelessWidget {
  const ContatoScreen({super.key});

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'contato@exploremundo.com',
      query: 'subject=Olá',
    );
    await launchUrl(emailLaunchUri);
  }

  void _callPhone() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '+55 99555-2244',
    );
    await launchUrl(phoneLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contato',
          style: GoogleFonts.lora(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          // double maxWidth = screenWidth > 600 ? 400 : screenWidth * 0.9;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'em caso de dúvidas, não hesite em nos contatar!',
                    style: GoogleFonts.lora(
                      fontSize: 18,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, size: 30, color: Color.fromARGB(255, 32, 216, 72)),
                      const SizedBox(width: 10),
                      Text(
                        'Telefone:',
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '+55 99654-5479',
                    style: GoogleFonts.lora(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email, size: 30, color: Color.fromRGBO(25, 207, 86, 1)),
                      const SizedBox(width: 10),
                      Text(
                        'E-mail:',
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'contato@gmail.com',
                    style: GoogleFonts.lora(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: screenWidth > 600 ? 300 : 250,
                    child: GradientButton(
                      text: 'E-mail',
                      onPressed: _sendEmail,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: screenWidth > 600 ? 300 : 250,
                    child: GradientButton(
                      text: 'Suporte',
                      onPressed: _callPhone,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
