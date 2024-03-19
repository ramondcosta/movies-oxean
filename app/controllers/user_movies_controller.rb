class UserMoviesController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:user_movie][:movie_id])
    current_user.movies << @movie
    @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def batch
    puts "Batch!"
    puts params
    params.permit!
    for user_movie in params[:user_movies]
      puts "UserMovie!"
      puts user_movie
      @user_movie_id = user_movie[:movie_id];
      puts "UserMovieId!"
      puts @user_movie_id
      @movie = Movie.find(@user_movie_id)
      puts "@Movie!"
      puts @movie
      puts "CurrentUser.Movies!"
      puts  current_user.movies
      current_user.movies << @movie
      @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
      @user_movie.update(score: user_movie[:score])
      puts "Updated!"
    end
    puts "Batch!"
  end
end
