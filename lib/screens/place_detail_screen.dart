import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    var greatPlaces = Provider.of<GreatPlaces>(context);
    var place = greatPlaces.places[ModalRoute.of(context).settings.arguments as int];

    return Scaffold(
     body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(place.title),
            background: Hero(
              tag: place.id,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                place.location.address,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20,),
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => MapScreen(initialLocation: place.location, isSelecting: false,),),);
              },
              textColor: Theme.of(context).primaryColor,
              child: Text(
                'View on map',
              ),
            ),
          ]),
        ),
     ],),
    );
  }
}
