import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/blocs/home_bloc.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/pages/movie_detail_page.dart';
import 'package:movie_booking_app/pages/splash_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/circle_image_shape_view.dart';
import 'package:movie_booking_app/widgets/movie_view.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        drawer: Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          child: Drawer(
            child: Container(
              color: SPLASH_SCREEN_BACKGROUND_COLOR,
              padding: EdgeInsets.symmetric(
                horizontal: MARGIN_16,
              ),
              child: Selector<HomeBloc, List<UserVO>?>(
                selector: (context, bloc) => bloc.users,
                builder: (BuildContext context, user, Widget? child) {
                  return (user != null) ? DrawerView(
                    name: user[0].name ?? "",
                    email: user[0].email ?? "",
                    onTapView: () {
                      HomeBloc homeBloc = Provider.of<HomeBloc>(context, listen: false);
                      homeBloc.onTapLogOut().then((value) =>
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SplashPage()))
                      );
                    },
                  ) : Container();
                },
              ),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
            IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(PADDING_16),
              child: Image.asset(
                "assets/images/search_icon.png",
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(left: MARGIN_16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SIZED_BOX_HEIGHT_10,
              ),
              Row(
                children: [
                  CircleImageShapeView('assets/images/profile.jpg'),
                  SizedBox(
                    width: SIZED_BOX_HEIGHT_20,
                  ),
                  Selector<HomeBloc, List<UserVO>?>(
                    selector: (context, bloc) => bloc.users,
                    builder: (BuildContext context, user, Widget? child) {
                      return (user != null) ? Text(
                       "Hi ${user[0].name ?? ""}!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: FONT_SIZE_25,
                          fontWeight: FontWeight.bold,
                        ),
                      ) : Container();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              Container(
                height: HOME_PAGE_SCROLL_CONTAINER_HEIGHT,
                child: SingleChildScrollView(
                  key: Key("SCROLL_MOVIE_LIST"),
                  child: Column(
                    children: [
                      Selector<HomeBloc, List<MovieVO>?>(
                        selector: (context, bloc) => bloc.nowPlayingMovies,
                        builder:
                            (BuildContext context, nowPlayingMovies,
                            Widget? child) {
                          return HorizontalMovieListView(
                            onTapMovie: (movieId, movieTitle) =>
                                _navigateToMovieDetailsPage(
                                    context, movieId, movieTitle),
                            label: "Now Showing",
                            movieLists: nowPlayingMovies,
                            genreLists: [],
                          );
                        },
                      ),
                      SizedBox(
                        height: SIZED_BOX_HEIGHT_10,
                      ),
                      Selector<HomeBloc, List<MovieVO>?>(
                        selector: (context, bloc) => bloc.comingSoonMovies,
                        builder:
                            (BuildContext context, comingSoonMovies,
                            Widget? child) {
                          return HorizontalMovieListView(
                            onTapMovie: (movieId, movieTitle) =>
                                _navigateToMovieDetailsPage(
                                    context, movieId, movieTitle),
                            label: "Coming Soon",
                            movieLists: comingSoonMovies,
                            genreLists: [],
                          );
                        },
                      ),
                      SizedBox(
                        height: SIZED_BOX_HEIGHT_10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToMovieDetailsPage(BuildContext context, int? movieId, String? movieTitle) {
    if (movieId != null && movieTitle != null) {
      Navigator.push(
          context, MaterialPageRoute(
          builder: (context) =>
              MovieDetailsPage(movieId: movieId, movieTitle: movieTitle,)));
    }
  }
}

class DrawerView extends StatelessWidget {
  final String name;
  final String email;
  final Function onTapView;

  DrawerView({required this.name, required this.email, required this.onTapView});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeaderView(
          name: name,
          email: email,
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_50,
        ),
        ListTileView(Icons.menu_book_outlined, "Promotion code", (){}),
        SizedBox(
          height: SIZED_BOX_HEIGHT_10,
        ),
        ListTileView(Icons.g_translate, "Select a language", (){}),
        SizedBox(
          height: SIZED_BOX_HEIGHT_10,
        ),
        ListTileView(Icons.description, "Term of services", (){}),
        SizedBox(
          height: SIZED_BOX_HEIGHT_10,
        ),
        ListTileView(Icons.help, "Help", (){}),
        SizedBox(
          height: SIZED_BOX_HEIGHT_10,
        ),
        ListTileView(Icons.star_rate_rounded, "Rate us", (){}),
        Spacer(),
        ListTileView(Icons.exit_to_app, "Log out", () {
          onTapView();
        }),
        SizedBox(
          height: SIZED_BOX_HEIGHT_20,
        ),
      ],
    );

  }

}

class DrawerHeaderView extends StatelessWidget {
  final String name;
  final String email;

  DrawerHeaderView({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 130,
        ),
        CircleImageShapeView(
          "assets/images/profile.jpg",
        ),
        SizedBox(
          width: SIZED_BOX_HEIGHT_20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerTextView(
              this.name,
              FONT_SIZE_20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: SIZED_BOX_HEIGHT_5,
            ),
            DrawerTextView(
              this.email,
              FONT_SIZE_12,
            )
          ],
        ),
        Spacer(),
        DrawerTextView(
          "Edit",
          FONT_SIZE_12,
        ),
      ],
    );
  }
}

class DrawerTextView extends StatelessWidget {
  final String text;
  final double textSize;
  final FontWeight fontWeight;

  DrawerTextView(this.text, this.textSize,
      {this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: textSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function onTapMovie;

  final String label;

  final List<MovieVO>? movieLists;
  final List<GenreVO>? genreLists;

  HorizontalMovieListView(
      {required this.onTapMovie,
      required this.label,
      required this.movieLists,
      required this.genreLists});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: FONT_SIZE_20,
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_20,
        ),
        Container(
          height: LIST_VIEW_HEIGHT,
          child: (movieLists != null)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieLists?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(right: MARGIN_16),
                      width: LIST_VIEW_WIDGET_WIDTH,
                      child: MovieView(
                        onTapMovie: () {
                          this.onTapMovie(
                            movieLists?[index].id,
                            movieLists?[index].title,
                          );
                        },
                        movie: movieLists?[index],
                        genre: genreLists ?? [],
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ],
    );
  }
}

class ListTileView extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTapView;

  ListTileView(this.icon, this.text, this.onTapView);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: DRAWER_CHILD_ICON_SIZE,
      ),
      title: DrawerTextView(
        text,
        FONT_SIZE_20,
      ),
      onTap: () {
        onTapView();
      },
    );
  }
}


/*
class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CinemaModel cinemaModel = CinemaModelImpl();

  String? name;
  String? email;
  String? token;

  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? comingSoonMovies;
  List<SnacksVO>? snacksList;
  List<GenreVO>? genres;

  @override
  void initState() {

    cinemaModel.getUsersFromDatabase().listen((user) {
      setState(() {
        name = user[0].name;
        email = user[0].email;
        token = user[0].token;
        print("userToken>> $token");
      });
    }).onError((error) => debugPrint(error));

    // cinemaModel.getNowPlayingMovies(1).then((movieList) {
    //   setState(() {
    //     nowPlayingMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    cinemaModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      setState(() {
        nowPlayingMovies = movieList;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    // cinemaModel.getComingSoonMovies(1).then((movieList) {
    //   setState(() {
    //     comingSoonMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    cinemaModel.getComingSoonMoviesFromDatabase().listen((movieList) {
      setState(() {
        comingSoonMovies = movieList;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    cinemaModel.getGenres().then((genres) {
      setState(() {
        this.genres = genres;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    cinemaModel.getGenresFromDatabase().then((genres) {
      setState(() {
        this.genres = genres;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    cinemaModel.getSnacksFromDatabase().listen((snacksList) {
      setState(() {
        this.snacksList = snacksList;
      });
      print("SnacksList>> ${snacksList?.length}");
    }).onError((error) => debugPrint(error.toString()));

    super.initState();
  }

  _userLogOut(BuildContext context) {
    cinemaModel.userLogOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SplashPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Drawer(
            child: Container(
              color: SPLASH_SCREEN_BACKGROUND_COLOR,
              padding: EdgeInsets.symmetric(
                horizontal: MARGIN_16,
              ),
              child: Selector<HomeBloc, List<UserVO>?>(
                selector: (context, bloc) => bloc.users,
                builder: (BuildContext context, user, Widget? child) {
                  return  DrawerView(
                    name: user?[0].name ?? "",
                    email: user?[0].email ?? "",
                    onTapView: () {
                      HomeBloc homeBloc = Provider.of(context);
                      homeBloc.onTapLogOut().then((value) =>
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SplashPage()))
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
            IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(PADDING_16),
              child: Image.asset(
                "assets/images/search_icon.png",
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(left: MARGIN_16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SIZED_BOX_HEIGHT_10,
              ),
              Row(
                children: [
                  CircleImageShapeView('assets/images/profile.jpg'),
                  SizedBox(
                    width: SIZED_BOX_HEIGHT_20,
                  ),
                  Selector<HomeBloc, List<UserVO>?>(
                    selector: (context, bloc) => bloc.users,
                    builder: (BuildContext context, user, Widget? child) {
                      return      Text(
                        "Hi ${user?[0].name ?? ""}!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: FONT_SIZE_25,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              Container(
                height: HOME_PAGE_SCROLL_CONTAINER_HEIGHT,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Selector<HomeBloc, List<MovieVO>?>(
                        selector: (context, bloc) => bloc.nowPlayingMovies,
                        builder:
                            (BuildContext context, nowPlayingMovies, Widget? child) {
                          return HorizontalMovieListView(
                            onTapMovie: (movieId, movieTitle) => _navigateToMovieDetailsPage(context, movieId, movieTitle),
                            label: "Now Showing",
                            movieLists: nowPlayingMovies,
                            genreLists: genres,
                          );
                        },
                      ),
                      SizedBox(
                        height: SIZED_BOX_HEIGHT_10,
                      ),
                      Selector<HomeBloc, List<MovieVO>?>(
                        selector: (context, bloc) => bloc.comingSoonMovies,
                        builder:
                            (BuildContext context, comingSoonMovies, Widget? child) {
                          return HorizontalMovieListView(
                            onTapMovie: (movieId, movieTitle) => _navigateToMovieDetailsPage(context, movieId, movieTitle),
                            label: "Coming Soon",
                            movieLists: comingSoonMovies,
                            genreLists: genres,
                          );
                        },
                      ),
                      SizedBox(
                        height: SIZED_BOX_HEIGHT_10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToMovieDetailsPage(BuildContext context, int? movieId, String? movieTitle) {
    if (movieId != null && movieTitle != null) {
      Navigator.push(
          context, MaterialPageRoute(
          builder: (context) => MovieDetailsPage(movieId: movieId, movieTitle: movieTitle,)));
    }
  }
}*/
