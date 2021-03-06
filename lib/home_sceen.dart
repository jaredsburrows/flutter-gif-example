import 'package:flutter/material.dart';

import 'account_screen.dart';
import 'settings_screen.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      drawer: _getNavDrawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Click!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: _incrementCounter,
            ),
          ));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Drawer _getNavDrawer(BuildContext context) {
    ListTile _getNavItem(IconData icon, String title, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();

            // Stop here if we are simply returning back to "home"
            if (routeName == "/") return;

            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    var _myNavChildren = [
      // Header
      DrawerHeader(
        child: Text('Header'),
      ),
      // Nav Items
      _getNavItem(Icons.home, 'Home', '/'),
      _getNavItem(Icons.account_box, 'Account', AccountScreen.routeName),
      _getNavItem(Icons.settings, 'Settings', SettingsScreen.routeName),
      // About dialog
      AboutListTile(
        child: Text('About'),
        applicationName: 'Application Name',
        applicationVersion: 'v1.0.0',
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.info),
      )
    ];

    return Drawer(
      child: ListView(children: _myNavChildren),
    );
  }
}

class ContactModal {
  final String fullName;
  final String email;

  const ContactModal({this.fullName, this.email});
}

class ContactsList extends StatelessWidget {
  final List<ContactModal> _contactModal;

  ContactsList(this._contactModal);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      children: _buildContactsList(),
    );
  }

  List<ContactListItem> _buildContactsList() {
    return _contactModal
      .map((contact) => new ContactListItem(contact))
      .toList();
  }
}

class ContactListItem extends StatelessWidget {
  final ContactModal _contactModal;

  ContactListItem(this._contactModal);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new CircleAvatar(child: new Text(_contactModal.fullName[0])),
      title: new Text(_contactModal.fullName),
      subtitle: new Text(_contactModal.email),
    );
  }
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ContactsList(
        _buildContactList(),
      ),
    );
  }

  List<ContactModal> _buildContactList() {
    List<ContactModal> items = List<ContactModal>();
    for (int i = 0; i < 10; i++) {
      items.add(ContactModal(
        fullName: 'Jared Burrows',
        email: 'jaredsburrows@gmail.com',
      ));
    }
    return items;
  }
}
