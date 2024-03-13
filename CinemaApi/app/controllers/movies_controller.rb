class MoviesController < ApplicationController

    def create
        @director = Director.find(params[:director_id])
        @movie = @director.movies.build(movies_params)
    
        if @movie.save
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end

    def movies_por_director
        director = Director.find(params[:director_id])
        @movies = director.movies
        render json: @movies
    end

    def update
        @director = Director.find(params[:director_id])
        @movie = @director.movies.find(params[:movie_id])
    
        if @movie.update(movies_params)
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end

    def buscar_por_keyword
        @movies = Movie.all
        movies_keyword = @movies.select { |movie| movie.sinopsis.include?(params[:keyword])}
        render json: movies_keyword
    end

    private
        def movies_params
            params.require(:movie).permit(:title, :sinopsis, :duration, :premiere, :director)
        end
    end
