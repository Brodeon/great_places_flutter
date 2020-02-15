import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          } else {
            return Consumer<GreatPlaces>(
              builder: (ctx, greatPlaces, child) => greatPlaces.places.isEmpty ? child : ListView.builder(itemCount: greatPlaces.places.length, itemBuilder: (ctx, index) => ListTile(
                leading: Hero(tag: greatPlaces.places[index].id, child: CircleAvatar(backgroundImage: FileImage(greatPlaces.places[index].image),),),
                title: Text(greatPlaces.places[index].title),
                subtitle: Text(greatPlaces.places[index].location.address),
                onTap: () {
                  Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: index);
                },
              ),),
              child: Center(child: Text('No places yet', textAlign: TextAlign.center,)),
            );
          }
        },
      ),
    );
  }
}