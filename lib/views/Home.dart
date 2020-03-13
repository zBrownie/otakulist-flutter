import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:projectstore/Provider/animes_control.dart';
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Size get size => MediaQuery.of(context).size;



Future onSelectNotification(String payload) async {
    showDialog(context: context,
    builder: (_)=> new AlertDialog(
      title: const Text('TEXTO NOTIFI'),
      content: new Text('Attack on Titan, Darwins Game'),
    ));
}


@override
  void initState() {
    super.initState();

    var initializationSeetingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(initializationSeetingsAndroid, initializationSettingsIOS);

    var flutterLocalNotificationsPlugin= new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);

// _handleNotificationInTime(flutterLocalNotificationsPlugin);
_handleTestNotification(flutterLocalNotificationsPlugin);
  }


//DISPARAR 10HORAS TODO DIA
_handleNotificationInTime(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)async {

 var time = Time(10,0,0);

var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);


    // await flutterLocalNotificationsPlugin.showDailyAtTime(0, 'Passando Hoje', AnimesControl().getDailyAnimesNotifications(), time, platformChannelSpecifics);
}


_handleTestNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {

  String bodyText = 'Attack on Titan, Darwins Game';
  print(bodyText);
  var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('repeating channel id',
        'repeating channel name', 'repeating description');
var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);


  await flutterLocalNotificationsPlugin.periodicallyShow(0, 'Passando Hoje', bodyText, RepeatInterval.EveryMinute, platformChannelSpecifics);
}

//APP VIEWS
  @override
  Widget build(BuildContext context) {

    print(AnimesControl().nomes);
    return Scaffold(
      appBar: AppBar(
        title: Text('Otaku list',style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        backgroundColor: Color(0xFF23231f),
      ),
      body: Column(
        children: <Widget>[
          // Container(
          //   height: size.height/2-40,
          //   child: FutureBuilder(
          //     future: AnimesControl().getDailyAnimes(),
          //     builder: (context,snapshot){
          //       if (snapshot.connectionState == ConnectionState.waiting ||
          //         snapshot.connectionState == ConnectionState.none ||
          //         !snapshot.hasData) {
          //       return Center(
          //         child: CircularProgressIndicator(
          //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          //         ),
          //       );
          //     } 

          //     List animes = snapshot.data;

          //     return StaggeredGridView.count(
          //       crossAxisCount: 2,
          //       mainAxisSpacing: 1,
          //       crossAxisSpacing: 1,
          //       staggeredTiles: animes.map((anime){
          //         return StaggeredTile.count(1, 2);
          //       }).toList(),
          //       children: animes.map((anime){
          //         return FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: anime['img_url'],fit: BoxFit.cover,);
          //       }).toList()
          //     );

          //     } 
          //   ),
          // ),
          Container(
            height: size.height-80,
            child: FutureBuilder(
              future: AnimesControl().getSeasonAnimes(),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none ||
                  !snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              } 

              List animes = snapshot.data;

              return StaggeredGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                staggeredTiles: animes.map((anime){
                  return StaggeredTile.count(1, 2);
                }).toList(),
                children: animes.map((anime){
                  return FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: anime['img_url'],fit: BoxFit.cover,);
                }).toList()
              );

              } 
            ),
          )
        ],
      ),
    );
  }
}