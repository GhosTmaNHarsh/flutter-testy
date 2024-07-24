import 'package:flutter/material.dart';
import 'package:post_editor/resizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = const Offset(100, 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            const ImageManager(
              isSelected: true,
              child: Text(
                  "textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor})"),
            ),
            ImageManager(
                isSelected: true,
                child: Image.network(
                  "https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p12798844_p_v8_ao.jpg",
                  fit: BoxFit.cover,
                )),
            Align(
              alignment: Alignment.topRight,
              child: SidePanel(),
            )
          ],
        ),
      ),
    );
  }
}

class SidePanel extends StatefulWidget {
  @override
  _SidePanelState createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  TextEditingController _textController = TextEditingController();
  double _fontSize = 16.0; // Default font size
  Color _textColor = Colors.black; // Default text color
  double _sliderValue = 0.0; // Default slider value

  void _selectColor(BuildContext context) async {
    setState(() {
      _textColor = Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text Input Area
          const Text('Text:'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              controller: _textController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          // FontSize Selecter
          const Text('Font Size'),
          DropdownButton<double>(
            value: _fontSize,
            onChanged: (newValue) {
              setState(() {
                _fontSize = newValue!;
              });
            },
            items: <double>[14.0, 16.0, 18.0, 20.0, 24.0, 30.0]
                .map<DropdownMenuItem<double>>((double value) {
              return DropdownMenuItem<double>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),

          // Color selector
          const SizedBox(height: 20.0),
          const Text('Text Color'),
          GestureDetector(
            onTap: () {
              _selectColor(context);
            },
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: _textColor,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),

          // Rotation controller
          const SizedBox(height: 20.0),
          const Text('Rotate'),
          Slider(
            value: _sliderValue,
            onChanged: (double value) {
              setState(() {
                _sliderValue = value;
              });
            },
            min: 0.0,
            max: 100.0,
            divisions: 100,
            label: _sliderValue.toStringAsFixed(1),
          ),
        ],
      ),
    );
  }
}
