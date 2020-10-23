import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/ui/screens/favourite/bloc/bloc.dart';
import 'package:movieapp/ui/screens/home/bloc/movie_block.dart';
import 'package:movieapp/ui/screens/home/bloc/movie_events.dart';
import 'package:movieapp/utils/di.dart';

class AlertDialogWidget extends StatelessWidget {
  final VoidCallback voidCallback;

  AlertDialogWidget(this.voidCallback);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(tr('Alert_title')),
        content: Text(tr('Alert_content')),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(tr('Alert_cancel')),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text(tr('Alert_clear')),
            onPressed: () {
              getIt<FavoriteBloc>().add(ClearFavorite());
              getIt<MovieBloc>().add(ReFetchMoviesEvent());

              voidCallback();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(
          tr('Alert_title'),
        ),
        content: Text(tr('Alert_content')),
        actions: <Widget>[
          FlatButton(
            child: Text(tr('Alert_cancel')),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(tr('Alert_clear')),
            onPressed: () {
              getIt<FavoriteBloc>().add(ClearFavorite());
              getIt<MovieBloc>().add(ReFetchMoviesEvent());
              voidCallback();
            },
          ),
        ],
      );
    }
  }
}
