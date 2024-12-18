import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WeatherProvider providerR;
  late WeatherProvider providerW;
  void showCity() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 100,
            width: 300,
            color: Colors.black,
            child: SearchBar(
              controller: providerW.controller,
              onSubmitted: (value) {
                providerW.controller.text = value;
                context.read<WeatherProvider>().city = value;
                context.read<WeatherProvider>().getWeather();
                Navigator.pop(context);
                providerW.controller.clear();
                context
                    .read<WeatherProvider>()
                    .setSearch(context.read<WeatherProvider>().city);
              },
              hintText: "Search city",
              padding: const WidgetStatePropertyAll(
                EdgeInsets.only(left: 20, top: 5),
              ),
              hintStyle: const WidgetStatePropertyAll(
                TextStyle(color: Colors.white),
              ),
              textStyle: const WidgetStatePropertyAll(
                TextStyle(color: Colors.white),
              ),
              backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () => showCity(),
    );

    context.read<WeatherProvider>().getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<WeatherProvider>();
    providerW = context.watch<WeatherProvider>();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "${providerR.getBgImage(providerW.weatherModel?.weather![0].main ?? "assets/images/Mist.jpg")}",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      icon: const Icon(Icons.add_circle),
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        providerR.controller.text = value;
                        providerR.city = value;
                        providerR.getWeather();
                        providerR.setSearch(providerR.city);
                        providerW.controller.clear();
                      },
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintText: "Search City Name",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onLongPress: () {
                        Navigator.pushNamed(context, '/bookmark');
                      },
                      child: IconButton(
                        onPressed: () {
                          providerW.bookmark.add(providerR.weatherModel!);
                        },
                        icon: const Icon(Icons.bookmark_add_outlined),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 200),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${providerR.weatherModel?.main?.temp?.toInt()}°C",
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${providerW.weatherModel?.name}",
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${providerR.weatherModel?.weather?[0].description}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Image(
                            image: AssetImage(
                              providerR.getGif(
                                  providerR.weatherModel?.weather?[0].main ??
                                      "assets/images/bg.png"),
                            ),
                            height: 100,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pressure",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                          Text(
                            "Visibility",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                          Text(
                            "Humidity",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${providerR.weatherModel?.main?.pressure} ",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            "${providerR.weatherModel?.visibility}%",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            "${providerR.weatherModel?.main?.humidity}%",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Air Quality",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                          Text(
                            "Wind",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                          Text(
                            "Clouds",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${providerW.weatherModel?.wind?.deg} AQI",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            "${providerW.weatherModel?.wind?.speed} Km/h",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            "${providerW.weatherModel?.clouds?.all} %",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Longitude",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                          Text(
                            "Latitude",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                          Text(
                            "SeaLevel",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${providerW.weatherModel?.cord?.lon}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${providerW.weatherModel?.cord?.lat}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${providerW.weatherModel?.main?.seaLevel}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemCount: 7,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         margin: const EdgeInsets.all(10),
          //         height: 50,
          //         width: 200,
          //         decoration: BoxDecoration(
          //           gradient: const LinearGradient(
          //               begin: Alignment.topLeft,
          //               end: Alignment.bottomRight,
          //               colors: [
          //                 // Color(0xFF12122C),
          //                 // Color(0xFF3E5974),
          //                 // Color(0xFF1E5058),
          //                 // Color(0xFF0A1321),
          //                 Color(0xffccf9ff),
          //                 Color(0xff55d0ff),
          //               ]),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.white.withOpacity(0.5),
          //               blurRadius: 5,
          //               offset: const Offset(0, 3),
          //             ),
          //           ],
          //           color: const Color(0xFF244558),
          //           borderRadius: BorderRadius.circular(20),
          //         ),
          //         child: const Padding(
          //           padding: EdgeInsets.all(10),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 "22°C",
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //               Icon(
          //                 Icons.cloudy_snowing,
          //                 color: Colors.white,
          //               ),
          //               Text(
          //                 "Mon",
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     }),
        ],
      ),
    );
  }
}
