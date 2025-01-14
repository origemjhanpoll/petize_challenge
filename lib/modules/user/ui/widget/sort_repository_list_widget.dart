import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum SortEnum { created, updated, pushed, full_name }

enum DirectionEnum { asc, desc }

class SortRepositoryListWidget extends StatefulWidget {
  final Function(String sort, String direction)? onPressed;
  final String title;

  const SortRepositoryListWidget({
    super.key,
    this.onPressed,
    required this.title,
  });

  @override
  State<SortRepositoryListWidget> createState() =>
      _SortRepositoryListWidgetState();
}

class _SortRepositoryListWidgetState extends State<SortRepositoryListWidget> {
  DirectionEnum _currentDirection = DirectionEnum.desc;
  SortEnum _currentSort = SortEnum.updated;

  final Map<SortEnum, String> _sortLabels = {
    SortEnum.created: 'Criação',
    SortEnum.updated: 'Atualização',
    SortEnum.pushed: 'Lançamento',
    SortEnum.full_name: 'Nomeado',
  };

  void _toggleDirection() {
    setState(() {
      _currentDirection = _currentDirection == DirectionEnum.desc
          ? DirectionEnum.asc
          : DirectionEnum.desc;
    });

    _notifyChanges();
  }

  void _toggleSort() {
    setState(() {
      _currentSort =
          SortEnum.values[(_currentSort.index + 1) % SortEnum.values.length];
    });

    _notifyChanges();
  }

  void _notifyChanges() {
    if (widget.onPressed != null) {
      widget.onPressed!(_currentSort.name, _currentDirection.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: IconButton.outlined(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            side: WidgetStatePropertyAll(
                BorderSide(color: theme.primaryColor, width: 2.0))),
        onPressed: widget.onPressed != null ? _toggleDirection : null,
        icon: Icon(
          Icons.swap_vert,
          color: theme.primaryColor,
        ),
      ),
      title: Text(
        widget.title,
        style: theme.textTheme.titleMedium,
      ),
      horizontalTitleGap: 8.0,
      contentPadding: EdgeInsets.only(left: 16.0, right: 12.0),
      trailing: OutlinedButton.icon(
        iconAlignment: IconAlignment.end,
        onPressed: widget.onPressed != null ? _toggleSort : null,
        label: Text(
          _sortLabels[_currentSort]!,
        ),
        icon: Icon(Icons.swap_horiz),
        style: ButtonStyle(
            padding:
                WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12.0)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            side: WidgetStatePropertyAll(
                BorderSide(color: theme.primaryColor, width: 2.0))),
      ),
    );
  }
}
