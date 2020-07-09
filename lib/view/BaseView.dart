import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/viewmodel/BaseModel.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({@required this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = GetIt.I.get<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => GetIt.I.get<T>(),
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
