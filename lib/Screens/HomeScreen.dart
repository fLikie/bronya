import 'package:bronya/model/Place.dart';
import 'package:flutter/material.dart';
import 'package:bronya/ui/AppDrawer.dart';

class HomeScreen extends StatelessWidget {

  final List<Place> places = [
    Place(
      name: "Ресторан La Bella",
      description: "Изысканная итальянская кухня",
      imageUrl: "https://picsum.photos/400/2",
    ),
    Place(
      name: "Кафе Sunrise",
      description: "Лучшие завтраки в городе",
      imageUrl: "https://picsum.photos/400/300",
    ),
    Place(
      name: "Бар Night Owl",
      description: "Живая музыка и коктейли",
      imageUrl: "https://picsum.photos/400/5",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Бронирование")),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    place.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        place.description,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Здесь можно открыть экран бронирования
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Бронирование ${place.name} пока не доступно")),
                          );
                        },
                        child: const Text("Забронировать"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}