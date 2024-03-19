class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: :average_score) }
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    puts "MovieParams!"
    puts movie_params
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie was successfully created."
    else
      render :new
    end
  end

  def batch
    CreateMovieBatchJob.perform_async(params.to_json)
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
