import 'package:flutter/material.dart';
import 'package:food_receipe/IngredientPage.dart';
import 'package:food_receipe/ListDemo.dart';
import 'package:food_receipe/ListView2.dart';
import 'package:food_receipe/ListView3.dart';
import 'package:food_receipe/ProductionInfor.dart';
import 'package:food_receipe/RandomRecipe.dart';
import 'package:food_receipe/model/Food.dart';
import 'package:food_receipe/ListView1.dart';
import 'package:food_receipe/searchrecipe.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe',
      // home: MainPage(),
      home:SearchRecipe(),
      theme:ThemeData(
        fontFamily: 'Nunito'
      )
    );
  }
}

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonresponse = json.decode(response.body);
    return Album.fromJson(jsonresponse);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
Future<Food> fetchFood() async {
  final response =
      await http.get('https://api.spoonacular.com/recipes/search?query=Grilled Cheese&number=3&apiKey=1a74b3a4abad4b11ba5a0de2815e5c41');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Food.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load food');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   Future<Album> futureAlbum;
   Future<Food> futureFood;
  @override
  void initState() {
    futureAlbum = fetchAlbum();
    futureFood = fetchFood();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Food Recipe')
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: FutureBuilder<Food>(
            future: futureFood,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                
               return  new ListView(
                 children: <Widget>[
                   Container(
                     height:250,
                     child:ListView(
                       scrollDirection: Axis.vertical,
                       children: <Widget>[
                         GestureDetector(
                           onTap:(){
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>Listview1()));
                           },
                           child:Text('ListView 1')
                         ),
                         GestureDetector(
                           onTap:(){
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>ListView2()));
                           },
                           child:Text('ListView 2 JSON')
                         )
                         ,
                         GestureDetector(
                           onTap:(){
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>ListView3()));
                           },
                           child:Text('ListView 3 JSON')
                         )
                         ,
                         GestureDetector(
                           onTap:(){
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>IngredientPage()));
                           },
                           child:Text('ListView4 Ingredient')
                         )
                         ,
                         GestureDetector(
                           onTap:(){
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductInfor()));
                           },
                           child:Text('Product Infor')
                         )
                         ,
                         GestureDetector(
                           onTap:(){
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchRecipe()));
                           },
                           child:Text('Search recipes')
                         )
                         ,
                         GestureDetector(
                           onTap:(){
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>ListDemoPage()));
                           },
                           child:Text('ListView demo')
                         )
                       ],
                     )
                   ),
                   Container(
                     margin: EdgeInsets.all(8),
                     child: Card(
                       child: GestureDetector(
                         onTap:(){
                           Navigator.push(context, MaterialPageRoute(builder: (_)=>RandomRecipe()));
                         },
                         child: ListTile(
                           leading: Container(
                             height:60,width:60,
                             decoration:BoxDecoration(
                               /* image:DecorationImage(
                                //  image:NetworkImage('https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Chichen-Itza-at-night.jpg')
                                //  image:NetworkImage('${snapshot.data.baseUri+snapshot.data.results[0].imageUlrs[0].toString()}'),
                               ) */
                             )
                           ),
                           subtitle: Text('Numer : ${snapshot.data.number.toString()}\nOffset: ${snapshot.data.offset} \nTotalResults: ${snapshot.data.totalResults.toString()}'
                           ),
                           title: Container(
                             width:double.infinity,
                             child: Text('ID: ${snapshot.data.results[0].id.toString()}\nServings: ${snapshot.data.results[0].servings.toString()}\nReadyInMinutes: ${snapshot.data.results[0].readyInMinutes.toString()}\nTitle: ${snapshot.data.results[0].title.toString()}\nBaseUri: ${snapshot.data.baseUri.toString()}\nImageArray: [${snapshot.data.baseUri}]',
                            ),
                           )
                         ),
                       ),
                     ),
                   )
                 ],
               );
               
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          )
      ),
    );
  }
}