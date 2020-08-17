import 'package:flutter/material.dart';
import 'package:flutter_template_viewer/flutter_template_viewer.dart';

void main() {
  runApp(AppDemo());
}

class MyTemplate extends StatelessWidget {
  final Color color;

  MyTemplate({this.color = Colors.deepPurpleAccent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: color,
          child: Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: Placeholder(
                fallbackHeight: 150,
                fallbackWidth: 150,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class AppDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TemplateViewer(
          templates: [
            TemplateData(
                name: 'Flutter Logo', templateBuilder: (ctx) => FlutterLogo()),
            TemplateData(
              name: 'Placeholder',
              templateBuilder: (ctx) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 360,
                        width: 360,
                        child: Text('Text much much text long long long', style: Theme.of(context).textTheme.headline2,),
                      ),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(
                      onPressed: () {},
                      child: Text('Button'),
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
