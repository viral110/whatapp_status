import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta/HomePage/bottombarhome.dart';
import 'package:insta/HomePage/homewhatsapp.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyAppHome());
}

class MyAppHome extends StatefulWidget {
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  int _storagePermissionCheck;
  Future<int> _storagePermissionChecker;

  Future<int> checkStoragePermission() async {
    final result = await Permission.storage.status;
    print("checking storage permission" + result.toString());

    setState(() {
      _storagePermissionCheck = 1;
    });
    if (result.isDenied) {
      return 0;
    } else if (result.isGranted) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<int> requestStoragePermission() async {
    final result = await [Permission.storage].request();
    print(result);
    setState(() {
      if (result[Permission.storage].isDenied) {
        return 0;
      } else if (result[Permission.storage].isGranted) {
        return 1;
      } else {
        return 0;
      }
    });
  }


  @override
  void initState() {
    super.initState();

    _storagePermissionChecker = (() async {
      int storagePermissionCheckInt;
      int finalPermission;

      print('Initial Values of $_storagePermissionCheck');
      if (_storagePermissionCheck == null || _storagePermissionCheck == 0) {
        _storagePermissionCheck = await checkStoragePermission();
      } else {
        _storagePermissionCheck = 1;
      }
      if (_storagePermissionCheck == 1) {
        storagePermissionCheckInt = 1;
      } else {
        storagePermissionCheckInt = 0;
      }

      if (storagePermissionCheckInt == 1) {
        finalPermission = 1;
      } else {
        finalPermission = 0;
      }

      return finalPermission;
    })();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
      ),
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Viral",
        theme: theme,
        darkTheme: darkTheme,
        home: DefaultTabController(
          length: 2,
          child: FutureBuilder(
            future: _storagePermissionChecker,
            builder: (context, snapshot) {
              print(snapshot.data);
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  if(snapshot.data == 1){
                    return HomeWhatApp();
                  }else{
                    return Scaffold(
                      body: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.lightBlue[100],
                                Colors.lightBlue[200],
                                Colors.lightBlue[300],
                                Colors.lightBlue[200],
                                Colors.lightBlue[100],
                              ],
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Storage Permission Required',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            FlatButton(
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                'Allow Storage Permission',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: Colors.indigo,
                              textColor: Colors.white,
                              onPressed: () {
                                _storagePermissionChecker =
                                    requestStoragePermission();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }else{
                  return Scaffold(
                    body: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.lightBlue[100],
                              Colors.lightBlue[200],
                              Colors.lightBlue[300],
                              Colors.lightBlue[200],
                              Colors.lightBlue[100],
                            ],
                          )),
                      child: const Center(
                        child: Text(
                          '''
Something went wrong.. Please uninstall and Install Again.''',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  );
                }
              }else{
                return const Scaffold(
                  body: SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
