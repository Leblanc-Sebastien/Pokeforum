import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ArticlesScreen(),
    );
  }
}

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  // Liste fictive d'articles
  final List<Map<String, String>> articles = const [
    {
      'title': 'Premier Article',
      'content': 'Contenu du premier article... Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Deuxième Article',
      'content': 'Contenu du deuxième article... Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'title': 'Troisième Article',
      'content': 'Contenu du troisième article... Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi.',
    },
  ];

  // Liste pour stocker les commentaires des articles
  final List<List<String>> comments = [[], [], []];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Articles'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article['title']!, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  // Affichage d'un aperçu du contenu
                  Text(
                    article['content']!.substring(0, 50) + '...', // Extrait du contenu
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigation vers la page de détail de l'article
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(
                            title: article['title']!,
                            content: article['content']!,
                            comments: comments[index],
                            onCommentAdded: (comment) {
                              setState(() {
                                comments[index].add(comment);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text('Voir l\'article complet'),
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

class ArticleDetailScreen extends StatefulWidget {
  final String title;
  final String content;
  final List<String> comments;
  final Function(String) onCommentAdded;

  const ArticleDetailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.comments,
    required this.onCommentAdded,
  });

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  bool showCommentForm = false;  // Contrôle de l'affichage du formulaire de commentaire

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.content, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            const Text("Commentaires", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // Affichage des commentaires existants
            ...widget.comments.map((comment) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(comment),
            )),
            const SizedBox(height: 16),

            // Affichage du bouton "Commenter"
            if (!showCommentForm)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showCommentForm = true;  // Afficher le formulaire de commentaire
                  });
                },
                child: const Text('Commenter'),
              ),

            // Affichage du formulaire pour le pseudo et le commentaire
            if (showCommentForm)
              Column(
                children: [
                  TextField(
                    controller: pseudoController,
                    decoration: const InputDecoration(hintText: 'Entrez votre pseudo'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: commentController,
                    decoration: const InputDecoration(hintText: 'Entrez votre commentaire'),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final pseudo = pseudoController.text;
                      final comment = commentController.text;

                      if (pseudo.isNotEmpty && comment.isNotEmpty) {
                        widget.onCommentAdded('$pseudo: $comment');
                        pseudoController.clear();
                        commentController.clear();
                        setState(() {
                          showCommentForm = false;  // Cacher le formulaire après l'ajout du commentaire
                        });
                      }
                    },
                    child: const Text('Ajouter un commentaire'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
