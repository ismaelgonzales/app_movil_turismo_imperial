import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Turismo Imperial'),
      actions: <Widget>[
        // IconButton(
        //   icon: const Icon(Icons.add_alert),
        //   tooltip: 'Show Snackbar',
        //   onPressed: () {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('This is a snackbar')),
        //     );
        //   },
        // ),
        IconButton(
          icon: const Icon(Icons.navigate_next),
          tooltip: 'Ir ala siguiente pagina',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Siguiente pagina'),
                  ),
                  body: const Center(
                    child: Text(
                      'Estamos en la siguiente pagina',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
