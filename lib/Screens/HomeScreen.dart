import 'package:bronya/Repository/PlacesRepository.dart';
import 'package:bronya/model/Place.dart';
import 'package:flutter/material.dart';
import 'package:bronya/ui/AppDrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Place>> _futurePlaces;
  final _placesRepository = PlacesRepository();

  @override
  void initState() {
    super.initState();
    _futurePlaces = _placesRepository.fetchPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Бронирование заведений"),
        backgroundColor: Colors.teal,
      ),
      drawer: AppDrawer(),
      // Предполагается, что AppDrawer уже вынесен в отдельный класс
      body: FutureBuilder<List<Place>>(
        future: _futurePlaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Пока данные загружаются – показываем индикатор
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // При ошибке – показываем сообщение
            return Center(child: Text("Ошибка: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Если данных нет
            return const Center(child: Text("Нет заведений"));
          } else {
            final places = snapshot.data!;
            // Отображаем список заведений
            return ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Изображение заведения с обработкой ошибки загрузки
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.network(
                          place.imageUrl?? "",
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              color: Colors.grey.shade300,
                              child: const Center(
                                child: Icon(
                                  Icons.error,
                                  size: 50,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              place.description,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Здесь можно реализовать логику бронирования заведения
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Бронирование ${place.name}"),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text("Забронировать"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
