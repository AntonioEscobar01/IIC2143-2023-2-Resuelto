class DirectorController < ApplicationController
    def create
        @director = Director.new(director_params)
        if @director.save
            render json: @director
        else
            render json: @director.errors, status: :unprocessable_entity
        end
    end

    def index
        @director = Director.all
        render json: @director
    end

    def show
        @director = Director.find(params[:id])
        render json: @director
    end
       
    def destroy
        @director = Director.find(params[:id])
        @director.destroy
        render json: {}
    end

    def destroy_todos
        Director.destroy_all
        render json: Director.all
    end

    def show_oscars
        @directores_filtrados = Director.where(has_oscars: true)
        render json: @directores_filtrados
    end
    
    private
        def director_params
            params.require(:director).permit(:name, :age, :country, :has_oscars)
        end
    end
