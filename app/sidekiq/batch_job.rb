Sidekiq.configure_server do |config|
  config.redis = { db: 1 }  
end

class BatchJob
  include Sidekiq::Job

  def perform(params, user_id)
    JSON.parse(params)
    puts "Batch!"
    puts params
    puts "user_id"
    puts user_id
    @user_movies = JSON.parse(params, object_class: OpenStruct)[:user_movies]

    for user_movie in @user_movies
      puts "UserMovie!"
      puts user_movie
      @movie_id = user_movie[:movie_id];
      puts "MovieId!"
      puts @movie_id
      @movie = Movie.find(@movie_id)
      puts "@Movie!"
      puts @movie

      @user_movie = UserMovie.find_by(user_id: user_id, movie_id: @movie_id)
      if !@user_movie 
        UserMovie.create(user_id: user_id, movie_id: @movie_id)
      end
      @user_movie.update(score: user_movie[:score])
      puts "Updated!"
    end

    puts "Batch!"

  end
end