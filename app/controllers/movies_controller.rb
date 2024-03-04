class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html 
    end
  end

  def show
    @movie = Movie.find_by(id: params.fetch(:id)) 
  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)

    if @movie.valid? 
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully." 
    else
      render "movies/new"
    end
  end

  def edit
    @movie = Movie.find_by(id: params.fetch(:id))
  end

  def update
    @movie = Movie.find_by(id: params.fetch(:id))

    movie_attributes = params.require(:movie).permit(:title, :description)
    movie = Movie.new(movie_attributes)

    if @movie.update(movie_attributes)
      movie.save
      redirect_to movies_url, notice: "Movie updated successfully."
    else
      redirect_to movies_url, alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_id = params.fetch(:id)
    movie = Movie.where(id: the_id ).first

    movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
