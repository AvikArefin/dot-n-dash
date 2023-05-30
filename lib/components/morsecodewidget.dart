import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torch_light/torch_light.dart';

class MorseCodeWidget extends StatefulWidget {
  const MorseCodeWidget({super.key});

  @override
  MorseCodeWidgetState createState() => MorseCodeWidgetState();
}

class MorseCodeWidgetState extends State<MorseCodeWidget> {
  final TextEditingController _textController = TextEditingController();
  String _morseCode = '';

  final Map<String, String> _morseCodeMap = {
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',
    '0': '-----',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '.': '.-.-.-',
    ',': '--..--',
    '?': '..--..',
    "'": '.----.',
    '!': '-.-.--',
    '/': '-..-.',
    '(': '-.--.',
    ')': '-.--.-',
    '&': '.-...',
    ':': '---...',
    ';': '-.-.-.',
    '=': '-...-',
    '+': '.-.-.',
    '-': '-....-',
    '_': '..--.-',
    '"': '.-..-.',
    '\$': '...-..-',
    '@': '.--.-.',
    ' ': '/',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Morse Code Converter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _morseCode,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Enter Text',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _convertToMorseCode,
              label: const Text('Convert to Morse Code'),
              icon: const Icon(Icons.code),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _playMorseCodeSound,
                  label: const Text('Play sound'),
                  icon: const Icon(Icons.play_arrow),
                ),
                ElevatedButton.icon(
                  onPressed: _flashMorseCodeLight,
                  label: const Text('Flash light'),
                  icon: const Icon(Icons.flashlight_on),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _convertToMorseCode() {
    final String enteredText = _textController.text;
    String morseCode = '';

    for (int i = 0; i < enteredText.length; i++) {
      final String character = enteredText[i].toUpperCase();
      final String? code = _morseCodeMap[character];
      if (code != null) {
        morseCode += '$code ';
      }
    }

    setState(() {
      _morseCode = morseCode;
    });
  }

  // TODO: To be implemented
  void _playMorseCodeSound() {}

  Future<void> _flashMorseCodeLight() async {
    for (int i = 0; i < _morseCode.length; i++) {
      switch (_morseCode[i]) {
        case '.':
          await torchControl(
              upTime: 200, downTime: 200); // A dot is 1 time unit
          break;
        case '-':
          await torchControl(
              upTime: 200 * 3, downTime: 200); // A dash is 3 time unit
          break;
        case ' ':
          await Future.delayed(const Duration(milliseconds: 200 * 3));
          break;
        case '/':
          await Future.delayed(const Duration(milliseconds: 200 * 7));
          break;
      }
    }
  }

  Future<void> torchControl(
      {required int upTime, required int downTime}) async {
    try {
      await TorchLight.enableTorch();
      await Future.delayed(Duration(milliseconds: upTime));
      await TorchLight.disableTorch();
      await Future.delayed(Duration(milliseconds: downTime));
    } on Exception catch (_) {
      debugPrint('Torch can not be accessed');
    }
  }
}
