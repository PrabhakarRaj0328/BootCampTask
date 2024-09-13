import 'package:dev_boot/pages/ListData.dart';
import 'package:dev_boot/pages/Weather.dart';
import 'package:dev_boot/pages/image.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final index;
  const Home({super.key, required this.index});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const ImagePage(),
      const Books(),
      const Weather()
    ];

    void onItemTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(139, 195, 74, 1),
            title: Center(
              child: _currentIndex == 0
                  ? const Text(
                      'Gif Page',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Merriweather',
                        color: Color.fromARGB(255, 239, 204, 4),
                      ),
                    )
                  : _currentIndex == 1
                      ? const Text(
                          'Books List',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Merriweather',
                            color: Color.fromARGB(255, 239, 204, 4),
                          ),
                        )
                      : const Text(
                          'Live Weather',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Merriweather',
                            color: Color.fromARGB(255, 239, 204, 4),
                          ),
                        ),
            )),
        body: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 239, 204, 4)),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: widgetOptions.elementAt(_currentIndex)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.gif_box_outlined),
              label: 'Images',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: 'Books List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.data_exploration_outlined),
                label: 'Live Data'),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: const Color.fromRGBO(0, 77, 153, 1),
          onTap: onItemTapped,
        ));
  }
}
