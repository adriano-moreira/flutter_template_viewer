import 'package:flutter/material.dart';
import 'package:flutter_template_viewer/src/devices.dart';

class SingleTemplateViewer extends StatelessWidget {
  final Widget Function(BuildContext context) templateBuilder;

  SingleTemplateViewer({
    @required this.templateBuilder,
  }) : assert(templateBuilder != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeviceViewPort(
            device: iphone5,
            widget: templateBuilder(context),
          ),
          DeviceViewPort(
            device: motoG4,
            widget: templateBuilder(context),
          ),
          DeviceViewPort(
            device: iphone6,
            widget: templateBuilder(context),
          ),
//          DeviceViewPort(
//            device: iphone6Plus,
//            widget: templateBuilder(context),
//          ),
        ],
      ),
    );
  }
}

class TemplateData {
  String name;
  Widget Function(BuildContext context) templateBuilder;

  TemplateData({
    @required this.name,
    @required this.templateBuilder,
  });
}

class TemplateViewer extends StatefulWidget {

  final List<TemplateData> templates;

  TemplateViewer({
    @required this.templates
  });

  @override
  _TemplateViewerState createState() => _TemplateViewerState();
}

class _TemplateViewerState extends State<TemplateViewer> {
  num selected = 0;

  @override
  Widget build(BuildContext context) {

    if(widget.templates.length == 0) {
      return Container(
        child: Center(
          child: Text('Has no templates'),
        ),
      );
    }

    return Row(
      children: [
        SizedBox(
            width: 200,
            child: ListView.builder(
              itemCount: widget.templates.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                  },
                  child: Container(
                    color: index == selected ? Colors.orange: Colors.transparent,
                    child: ListTile(
                      title: Text(widget.templates[index].name),
                    ),
                  ),
                );
              },
            )),
        Flexible(
          child: FittedBox(
            fit: BoxFit.fill,
            child: SingleTemplateViewer(
              templateBuilder: widget.templates[selected].templateBuilder,
            ),
          ),
        ),
      ],
    );
  }
}

