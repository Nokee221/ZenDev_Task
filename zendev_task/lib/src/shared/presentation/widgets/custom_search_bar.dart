import 'package:flutter/material.dart';
import 'package:zendev_task/src/config/app_theme.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String)? onChanged;

  const SearchBarWidget({this.onChanged, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8F0),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 8.0,
            ),
            const Icon(
              Icons.search,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style:
                      const TextStyle(fontSize: 16.0, color: AppTheme.primaryColor),
                  onChanged: onChanged),
            ),
          ],
        ),
      ),
    );
  }
}
