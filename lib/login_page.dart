import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'evento_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializar Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Define a persistência como LOCAL
        await _auth.setPersistence(Persistence.LOCAL);

        // Faz o login com email e senha
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EventoPage()),
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'Erro de login: ${e.toString()}';
        });
      }
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Define a persistência como LOCAL
        await _auth.setPersistence(Persistence.LOCAL);

        // Faz o registro com email e senha
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EventoPage()),
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'Erro de registro: ${e.toString()}';
        });
      }
    }
  }

  Widget _buildGoogleSignInButton() {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () async {
          try {
            // Define a persistência como LOCAL
            await _auth.setPersistence(Persistence.LOCAL);

            // Faz o login com Google
            final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
            final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken,
            );
            UserCredential userCredential = await _auth.signInWithCredential(credential);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EventoPage()),
            );
          } catch (e) {
            setState(() {
              _errorMessage = 'Erro ao fazer login com Google: ${e.toString()}';
            });
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          foregroundColor: Colors.white,
          backgroundColor: Colors.brown,
        ),
        label: Text(
          "Entrar com Google",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5DDBB),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock,
                    size: 100,
                    color: Color(0xFF603C0B),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bem-Vindo!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Entre com seu login abaixo.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu email.';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Por favor, insira um email válido.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha.';
                            }
                            if (value.length < 6) {
                              return 'A senha deve ter pelo menos 6 caracteres.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _signIn,
                                child: Text('Entrar'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0xFF603C0B),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _register,
                                child: Text('Registrar'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0xFF603C0B),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            _buildGoogleSignInButton(),
                          ],
                        ),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
