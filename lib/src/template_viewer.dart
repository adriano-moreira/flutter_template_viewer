import 'package:flutter/material.dart';
import 'package:flutter_template_viewer/src/devices.dart';
import 'package:provider/provider.dart';

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
          DeviceViewPort(
            device: iphone11,
            widget: templateBuilder(context),
          ),
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

class TemplateGroup {
  final String name;
  final List<TemplateData> templates;

  TemplateGroup({
    this.name,
    this.templates,
  });
}

class TemplateViewModel extends ChangeNotifier {
  final List<TemplateGroup> groups;
  TemplateData _current;

  TemplateViewModel({this.groups}) {
    _current = groups[0].templates[0];
  }

  TemplateData get current => _current;

  set current(TemplateData value) {
    _current = value;
    notifyListeners();
  }
}

class TemplateViewer extends StatelessWidget {
  final List<TemplateGroup> groups;

  TemplateViewer({this.groups});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TemplateViewModel(groups: groups),
      child: Row(
        children: [
          Menu(),
          Body(),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<TemplateViewModel>();
    return SizedBox(
      width: 180,
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          children: [
            ...model.groups
                .map(
                  (group) => toExpansionPanel(group, context),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}

ExpansionPanel toExpansionPanel(TemplateGroup group, BuildContext context) {
  List<Widget> _buildItems(BuildContext context) {
    return group.templates
        .map<Widget>(
          (t) => InkWell(
            onTap: () {
              context.read<TemplateViewModel>().current = t;
            },
            child: ListTile(
              title: Text(t.name),
            ),
          ),
        )
        .toList();
  }

  return ExpansionPanel(
    headerBuilder: (_, __) => Text(group.name),
    body: Column(
      children: _buildItems(context),
    ),
    isExpanded: true,
  );
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<TemplateViewModel>();
    return Expanded(
      child: FittedBox(
        child: SingleChildScrollView(
          child: SingleTemplateViewer(
            templateBuilder: model.current.templateBuilder,
          ),
        ),
      ),
    );
  }
}
