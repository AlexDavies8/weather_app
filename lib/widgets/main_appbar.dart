import 'package:flutter/material.dart';

/// A class representing the title bar on the home page
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black45, Colors.transparent]),
        ),
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Heatmap button
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed("/heatmap"),
          icon: const Icon(
            Icons.map,
            size: 24.0,
          ),
        ),
        const Expanded(child: SizedBox()),
        // Location icon
        const Icon(Icons.place_outlined),
        const SizedBox(width: 10),
        // Currently selected location
        Text(title, style: const TextStyle(fontSize: 24, fontFamily: 'Nunito')),
        const Expanded(child: SizedBox()),
        // Location list button
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed("/locations"),
          icon: const Icon(
            Icons.list,
            size: 24.0,
          ),
        ),
        // Settings button
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed("/settings"),
          icon: const Icon(
            Icons.settings,
            size: 24.0,
          ),
        )
      ]),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
