class CreateMovieBatchJob
  include Sidekiq::Job

  def perform(params)
    puts "Batch!"
    puts params

    @movies = JSON.parse(params, object_class: OpenStruct)[:movies]
    for movie in @movies
      puts "Movie!"
      puts movie
      @movie = Movie.new(movie.to_h)
      puts "Movie Created!"
      puts movie
      @movie.save
      puts "Movie Saved!"
    end
    puts "Batch!"
  end
end
