import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:umte_project/opts/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart'
  hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart'
    show ChangeNotifier;

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  Set<WordPair> favorites = <WordPair>{};

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  MyAppState() {
    initFirebase();
  }

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      _loggedIn = user != null;
      notifyListeners();
    });
  }

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (!favorites.add(current)) {
      favorites.remove(current);
    }

    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}
