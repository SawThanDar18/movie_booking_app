import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_booking_app/blocs/movie_details_bloc.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/pages/cinema_day_time_slot_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/floating_button_view.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;
  final String movieTitle;

  MovieDetailsPage({required this.movieId, required this.movieTitle});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ChangeNotifierProvider(
      create: (BuildContext context) => MovieDetailsBloc(movieId),
      child: Scaffold(
        body: Selector<MovieDetailsBloc, MovieVO>(
            selector: (context, bloc) => bloc.movieDetails!,
            builder: (context, movieDetails, child) => CustomScrollView(
            slivers: <Widget>[
              SliverAppBarView(
                    () => Navigator.pop(context),
                movie: movieDetails,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: EdgeInsets.only(left: MARGIN_16),
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MovieDetailTextView(
                          text: movieDetails.title ?? "",
                          fontSize: FONT_SIZE_25,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: SIZED_BOX_HEIGHT_10,
                        ),
                        Row(
                          children: [
                            MovieDetailTextView(
                              text: movieDetails.getRunTimeAsString(),
                              color: DETAIL_SUMMARY_TEXT_COLOR,
                            ),
                            SizedBox(
                              width: SIZED_BOX_HEIGHT_10,
                            ),
                            RatingBarView(
                              movie: movieDetails,
                            ),
                            SizedBox(
                              width: SIZED_BOX_HEIGHT_10,
                            ),
                            MovieDetailTextView(
                              fontSize: DETAIL_SUMMARY_TEXT_SIZE,
                              color: DETAIL_SUMMARY_TEXT_COLOR,
                              text: "Imdb ${movieDetails.voteAverage.toString()}",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SIZED_BOX_HEIGHT_10,
                        ),
                        GenreSectionView(genreList: movieDetails.getGenreListAsStringList()),
                        SizedBox(
                          height: SIZED_BOX_HEIGHT_20,
                        ),
                        MovieDetailTextView(
                          text: "Plot Summary",
                          fontSize: FONT_SIZE_20,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: SIZED_BOX_HEIGHT_10,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: MARGIN_16),
                          child: MovieDetailTextView(
                            text: movieDetails.overview ?? "",
                            color: DETAIL_SUMMARY_TEXT_COLOR,
                          ),
                        ),
                        SizedBox(
                          height: SIZED_BOX_HEIGHT_20,
                        ),
                        MovieDetailTextView(text: "Cast", fontSize: FONT_SIZE_20, fontWeight: FontWeight.bold,),
                        SizedBox(
                          height: SIZED_BOX_HEIGHT_10,
                        ),
                        Selector<MovieDetailsBloc, List<ActorVO>?>(
                          selector: (context, bloc) => bloc.cast,
                          builder: (BuildContext context, casts,
                              Widget? child) {
                            return ActorsSectionView(
                              actorsList: casts,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Selector<MovieDetailsBloc, MovieVO>(
            selector: (context, bloc) => bloc.movieDetails!,
            builder: (context, movieDetails, child) => FloatingButtonView(
            onTapView: () {
              MovieDetailsBloc movieDetailsBloc = Provider.of(context, listen: false);
            _navigateToChoosingTimePage(context, movieDetailsBloc.movieDetails!);
            },
            text: 'Get your ticket',
          ),
        ),
      ),
    );
  }

  _navigateToChoosingTimePage(BuildContext context, MovieVO movieDetails) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              CinemaDayTimeSlotPage(movieId: movieId, movieTitle: movieTitle, moviePoster: movieDetails.posterPath ?? "",)));
  }
}

class ActorsSectionView extends StatelessWidget {
  final List<ActorVO>? actorsList;

  ActorsSectionView({required this.actorsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CIRCLE_SHAPE_LIST_VIEW_HEIGHT,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
        children: actorsList
            ?.map((actor) =>
            CircleShapeHorizontalListView(
              actorProfilePath: actor.profilePath ?? "",
            ),
        ).toList() ?? [],
      ),
    );
  }
}

class RatingBarView extends StatelessWidget {
  final MovieVO? movie;

  RatingBarView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return
      RatingBar.builder(
        initialRating: ((movie?.voteAverage) ?? 0 /2),
        allowHalfRating: true,
        itemBuilder: (BuildContext context, int index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemSize: RATING_BAR_ITEM_SIZE,
        onRatingUpdate: (rating) {
          print(rating);
        },
      );
  }
}

class CircleShapeHorizontalListView extends StatelessWidget {

  final String actorProfilePath;

  CircleShapeHorizontalListView({required this.actorProfilePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_16),
      width: CIRCLE_SHAPE_LIST_VIEW_WIDGET_WIDTH,
      child: Container(
        child: CachedNetworkImage(
          imageUrl: '$IMAGE_BASE_URL$actorProfilePath',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset(
              "assets/images/movie_loading.jpg",
              fit: BoxFit.cover,
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error_outlined, color: SPLASH_SCREEN_BACKGROUND_COLOR,),
        ),
      ),
    );
    // return Container(
    //   margin: EdgeInsets.only(right: MARGIN_16),
    //   width: CIRCLE_SHAPE_LIST_VIEW_WIDGET_WIDTH,
    //   child: Container(
    //     width: CIRCLE_IMAGE_WIDTH,
    //     height: CIRCLE_IMAGE_HEIGHT,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       image: DecorationImage(
    //         image: NetworkImage("$IMAGE_BASE_URL$actorProfilePath"),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    // );
  }
}

class GenreSectionView extends StatelessWidget {

  const GenreSectionView({
    required this.genreList,
  });

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...genreList
            .map((genre) => GenreChipView(genre)).toList(),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_5),
      child: Chip(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: LABEL_TEXT_COLOR, width: CHIP_BORDER_WIDTH),
          borderRadius: BorderRadius.circular(CHIP_BORDER_RADIUS),
        ),
        backgroundColor: Colors.transparent,
        label: Padding(
          padding: const EdgeInsets.all(PADDING_8),
          child: Text(
            genreText,
            style: TextStyle(color: DETAIL_SUMMARY_TEXT_COLOR),
          ),
        ),
      ),
    );
  }
}

class SliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movie;

  SliverAppBarView(this.onTapBack, {required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: SLIVER_EXPANDED_HEIGHT,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: SliverAppBarImageView(
                    imageUrl: movie?.posterPath ?? "",
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MARGIN_XX_LARGE,
                      left: MARGIN_MEDIUM_2,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        this.onTapBack();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: CIRCLE_ICON_SIZE,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ROUND_CORNER_HEIGHT,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ROUND_CORNER_RADIUS),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverAppBarImageView extends StatelessWidget {
  final String imageUrl;

  SliverAppBarImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$IMAGE_BASE_URL$imageUrl",
      height: LIST_VIEW_IMAGE_HEIGHT,
      fit: BoxFit.cover,
      placeholder: (context, url) => Image.asset(
        "assets/images/movie_loading.jpg",
        fit: BoxFit.cover,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

class MovieDetailTextView extends StatelessWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final String text;
  final Color color;

  MovieDetailTextView(
      {required this.text,
        this.fontSize = FONT_SIZE_14,
        this.color = SLIVER_LABEL_COLOR,
        this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}

class DetailLabelView extends StatelessWidget {
  final String text;

  DetailLabelView(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: DETAIL_SUMMARY_TEXT_SIZE,
        color: DETAIL_SUMMARY_TEXT_COLOR,
      ),
    );
  }
}

/*
class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  final String movieTitle;

  MovieDetailsPage({required this.movieId, required this.movieTitle});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  CinemaModel cinemaModel = CinemaModelImpl();

  MovieVO? movieDetails;
  List<ActorVO>? cast;

  @override
  void initState() {
    cinemaModel.getMovieDetailsFromDatabase(widget.movieId).listen((event) {
      setState(() {
        this.movieDetails = event;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    // cinemaModel.getMovieDetails(widget.movieId).then((movieDetails) {
    //   setState(() {
    //     this.movieDetails = movieDetails;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    cinemaModel.getCreditsByMovieFromDatabase(widget.movieId).listen((event) {
      setState(() {
        this.cast = event;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    // cinemaModel.getCreditsByMovie(widget.movieId).then((castAndCrew) {
    //   setState(() {
    //     this.cast = castAndCrew.first;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ChangeNotifierProvider(
      create: (BuildContext context) => MovieDetailsBloc(widget.movieId),
      child: Scaffold(
        body: Selector<MovieDetailsBloc, MovieVO>(
            selector: (context, bloc) => bloc.movieDetails!,
            builder: (context, movieDetails, child) => CustomScrollView(
              slivers: <Widget>[
                SliverAppBarView(
                      () => Navigator.pop(context),
                  movie: movieDetails,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      margin: EdgeInsets.only(left: MARGIN_16),
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MovieDetailTextView(
                            text: movieDetails.title ?? "",
                            fontSize: FONT_SIZE_25,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: SIZED_BOX_HEIGHT_10,
                          ),
                          Row(
                            children: [
                              MovieDetailTextView(
                                text: movieDetails.getRunTimeAsString() ?? "",
                                color: DETAIL_SUMMARY_TEXT_COLOR,
                              ),
                              SizedBox(
                                width: SIZED_BOX_HEIGHT_10,
                              ),
                              RatingBarView(
                                movie: movieDetails,
                              ),
                              SizedBox(
                                width: SIZED_BOX_HEIGHT_10,
                              ),
                              MovieDetailTextView(
                                fontSize: DETAIL_SUMMARY_TEXT_SIZE,
                                color: DETAIL_SUMMARY_TEXT_COLOR,
                                text: "Imdb ${movieDetails.voteAverage.toString() ?? ""}",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SIZED_BOX_HEIGHT_10,
                          ),
                          GenreSectionView(genreList: movieDetails.getGenreListAsStringList() ?? []),
                          SizedBox(
                            height: SIZED_BOX_HEIGHT_20,
                          ),
                          MovieDetailTextView(
                            text: "Plot Summary",
                            fontSize: FONT_SIZE_20,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: SIZED_BOX_HEIGHT_10,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: MARGIN_16),
                            child: MovieDetailTextView(
                              text: movieDetails.overview ?? "",
                              color: DETAIL_SUMMARY_TEXT_COLOR,
                            ),
                          ),
                          SizedBox(
                            height: SIZED_BOX_HEIGHT_20,
                          ),
                          MovieDetailTextView(text: "Cast", fontSize: FONT_SIZE_20, fontWeight: FontWeight.bold,),
                          SizedBox(
                            height: SIZED_BOX_HEIGHT_10,
                          ),
                          Selector<MovieDetailsBloc, List<ActorVO>?>(
                            selector: (context, bloc) => bloc.cast,
                            builder: (BuildContext context, casts,
                                Widget? child) {
                              return ActorsSectionView(
                                actorsList: casts,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingButtonView(
          onTapView: () {
            _navigateToChoosingTimePage(context);
          },
          text: 'Get your ticket',
        ),
      ),
    );
  }

  _navigateToChoosingTimePage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CinemaDayTimeSlotPage(movieId: widget.movieId, movieTitle: widget.movieTitle, moviePoster: movieDetails?.posterPath ?? "",)));
  }
}*/
