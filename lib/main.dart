import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(const CaesarNeonApp());

class CaesarNeonApp extends StatelessWidget {
  const CaesarNeonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent, 
          brightness: Brightness.dark
        ),
      ),
      home: const CaesarScreen(),
    );
  }
}

class CaesarScreen extends StatefulWidget {
  const CaesarScreen({super.key});

  @override
  State<CaesarScreen> createState() => _CaesarScreenState();
}

class _CaesarScreenState extends State<CaesarScreen> {
  final _controller = TextEditingController();
  double _shift = 3;
  String _result = "Здесь будет шифр...";

  String _caesarCipher(String text, int shift) {
    var output = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      int charCode = text.codeUnitAt(i);
      int newCode = charCode;

      if (charCode >= 65 && charCode <= 90) {
        newCode = (charCode - 65 + shift) % 26 + 65;
      } else if (charCode >= 97 && charCode <= 122) {
        newCode = (charCode - 97 + shift) % 26 + 97;
      } else if (charCode >= 1040 && charCode <= 1071) {
        newCode = (charCode - 1040 + shift) % 32 + 1040;
      } else if (charCode >= 1072 && charCode <= 1103) {
        newCode = (charCode - 1072 + shift) % 32 + 1072;
      }
      
      output.write(String.fromCharCode(newCode));
    }
    return output.toString();
  }

  void _process() {
    setState(() {
      _result = _caesarCipher(_controller.text, _shift.round());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        title: const Text("NEON CIPHER v1.0", 
          style: TextStyle(fontFamily: 'Courier', letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.greenAccent.withOpacity(0.1), Colors.transparent],
            center: Alignment.center,
            radius: 1.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                onChanged: (_) => _process(),
                style: const TextStyle(color: Colors.greenAccent, fontFamily: 'Courier'),
                decoration: InputDecoration(
                  labelText: "ВВОД СЕКРЕТНЫХ ДАННЫХ",
                  labelStyle: const TextStyle(color: Colors.greenAccent, fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.greenAccent, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.vpn_key, color: Colors.greenAccent),
                ),
              ),
              const SizedBox(height: 30),
              Text("КЛЮЧ СМЕЩЕНИЯ: ${_shift.round()}", 
                style: const TextStyle(color: Colors.white, fontFamily: 'Courier', fontWeight: FontWeight.bold)),
              Slider(
                value: _shift,
                min: 0, max: 25,
                activeColor: Colors.greenAccent,
                inactiveColor: Colors.greenAccent.withOpacity(0.2),
                onChanged: (val) {
                  setState(() => _shift = val);
                  _process();
                },
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.greenAccent.withOpacity(0.5)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text("ЗАШИФРОВАННЫЙ ТЕКСТ:", 
                          style: TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: 1)),
                        const SizedBox(height: 15),
                        Text(
                          _result,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.greenAccent,
                            fontFamily: 'Courier',
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(color: Colors.greenAccent.withOpacity(0.7), blurRadius: 15)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}