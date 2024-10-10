import 'package:flutter/material.dart';
import 'package:explore_mundo/data/comentarios_repository.dart';
import 'package:explore_mundo/components/bottom_nav_bar.dart';
import 'package:explore_mundo/models/destino.dart';
import 'package:explore_mundo/components/avaliacao.dart';
import 'package:explore_mundo/models/comentario.dart';
import 'package:explore_mundo/components/comentarios.dart';
import 'package:google_fonts/google_fonts.dart';

class DestinoDetalhesScreen extends StatefulWidget {
  final Destino destino;

  const DestinoDetalhesScreen({super.key, required this.destino});

  @override
  DestinoDetalhesScreenState createState() => DestinoDetalhesScreenState();
}

class DestinoDetalhesScreenState extends State<DestinoDetalhesScreen> {
  final Map<String, String> informacoesDestinos = {
    'Grécia, Europa': 'A Grécia é um país do sudeste da Europa com milhares de ilhas espalhadas pelos mares Egeu e Jônico. Bastante influente na antiguidade, a nação é considerada o berço da civilização ocidental.',
    'Dubai, Emirados Árabes': ' Dubai é uma cidade e um emirado dos Emirados Árabes Unidos conhecida pelos shoppings de luxo, pela arquitetura ultramoderna e pela animada vida noturna.',
    'Barramas, Caribe': 'As Bahamas são um arquipélago no Oceano Atlântico cujo terreno tem origem nos corais. O país tem mais de 700 ilhas e ilhotas, muitas desabitadas e outras cheias de resorts.',
  };

  List<Comentario> comentarios = [];
  final TextEditingController _comentarioController = TextEditingController();
  final String _usuario = "Usuário";

  @override
  void initState() {
    super.initState();
    carregarComentarios();
  }

  Future<void> carregarComentarios() async {
    comentarios = await ComentarioRepository.carregarComentarios(widget.destino.titulo);
    setState(() {});
  }

  Future<void> salvarComentarios() async {
    await ComentarioRepository.salvarComentarios(widget.destino.titulo, comentarios);
  }

  @override
  Widget build(BuildContext context) {
    String destinoTitulo = widget.destino.titulo;
    String informacao = informacoesDestinos[destinoTitulo] ?? 'Informação não disponível.';

    double avaliacaoMedia = 4.5;
    int numeroAvaliacoes = 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          destinoTitulo,
          style: GoogleFonts.lora(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 77, 204, 221),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double imageHeight = screenWidth > 600 ? 500 : 200;
          double imageWidth = screenWidth > 600 ? 650 : screenWidth * 0.95;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.destino.imagem,
                    height: imageHeight,
                    width: imageWidth,
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Saiba mais sobre o seu próximo destino!",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: imageWidth,
                      child: Text(
                        informacao,
                        style: GoogleFonts.lora(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Avaliacao(
                      avaliacaoMedia: avaliacaoMedia,
                      numeroAvaliacoes: numeroAvaliacoes,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: imageWidth,
                      child: Comentarios(
                        comentarios: comentarios,
                        comentarioController: _comentarioController,
                        usuario: _usuario,
                        onComentarioSubmitted: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              final novoComentario = Comentario(
                                usuario: _usuario,
                                texto: value,
                                dataHora: DateTime.now().toLocal(),
                              );
                              comentarios.add(novoComentario);
                              salvarComentarios();
                              _comentarioController.clear();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}






