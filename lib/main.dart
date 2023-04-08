import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_lokal/constants/constants.dart';
import 'package:news_lokal/constants/custom_listtile.dart';
import 'package:news_lokal/providers/news_provider.dart';
import 'package:provider/provider.dart';

import 'models/news.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NewsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              padding: const EdgeInsets.all(7),
              decoration:
                  const BoxDecoration(gradient: Constants.appBarGradient),
              child: TextFormField(
                controller: _searchController,
                onFieldSubmitted: (a) {
                  // TODO: Make the logic for searching the news
                },
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  label: Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white24,
                ),
              ),
            ),
          ),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      dropdownColor: Colors.grey[200],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 5,
                      items: Provider.of<NewsProvider>(context)
                          .getCountries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (a) {
                        Provider.of<NewsProvider>(context, listen: false)
                            .setSelectedCountry(a!);
                      },
                      value:
                          Provider.of<NewsProvider>(context).selectedCountry),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FutureBuilder(
                    future: http.get(Constants.makeUri(
                        Provider.of<NewsProvider>(context).selectedCountry !=
                                'Select a Country'
                            ? Provider.of<NewsProvider>(context).selectedCountry
                            : 'everything')),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Text('none');
                        case ConnectionState.active:
                          return const Text('active');
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                          List res =
                              jsonDecode(snapshot.data!.body)['articles'];
                          List<News> newsList = [];

                          for (var i in res) {
                            newsList.add(News.fromMap(i));
                          }
                          return ListView.separated(
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(thickness: 1.5),
                            ),
                            itemCount: 15,
                            //currently displaying only 15 news items
                            itemBuilder: (context, index) {
                              return CustomListTile(
                                  newsList: newsList, index: index);
                            },
                          );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
