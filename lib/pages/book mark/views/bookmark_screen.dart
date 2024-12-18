import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/routes/routes.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late WeatherProvider providerR;
  late WeatherProvider providerW;
  @override
  Widget build(BuildContext context) {
    providerR = context.read<WeatherProvider>();
    providerW = context.watch<WeatherProvider>();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text("Bookmark",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: providerW.bookmark.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      providerW.bookmark.remove(index);
                    },
                    onTap: () {
                      // providerW.city = providerW.bookmark[index];
                      providerW.getWeather();
                      Navigator.pushNamed(context, Routes.home);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              providerW.bookmark.isEmpty
                                  ? const Text('No found data')
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${providerR.bookmark[index].name}",
                                        style: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${providerR.bookmark[index].weather![0].main}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${providerR.bookmark[index].main?.temp}°C",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  // return ListTile(
                  //   title: providerW.bookmark.isEmpty
                  //       ? const Text('No found data')
                  //       : Text(providerW.bookmark[index]),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, Routes.home,
                  //         arguments: providerW.bookmark[index]);
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
