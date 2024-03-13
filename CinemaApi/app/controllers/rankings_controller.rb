class RankingsController < ApplicationController
    def create
        @director = Director.find(params[:director_id])
        @ranking_creado = @director.rankings.build(rankings_params)
    
        if @ranking_creado.save
            render json: @ranking_creado
        else
            render json: @ranking_creado.errors, status: :unprocessable_entity
        end
    end

    def rankings_por_director
        director = Director.find(params[:director_id])
        @rankings_director = director.rankings
        render json: @rankings_director
    end

    def mejores_rankings
        cantidad = params[:quantity].to_i
    
        @rankings_filtrados = Ranking.all.map do |ranking|
          {
            ranking: ranking,
            key: (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)
          }
        end
    
        @rankings_ordenados = @rankings_filtrados.sort_by { |item| item[:key] }.reverse
    
        @rankings_seleccionados = @rankings_ordenados.first(cantidad).map { |item| item[:ranking] }
    
        render json: @rankings_seleccionados
    end

    def encontrar_rankings
        @movie = Movie.find(params[:movie_id])
        @id_director = @movie.director
        @rankings = Ranking.where(director: @id_director)
        render json: @rankings
    end

    def eliminar_peor_director
        @rankings_filtrados = Ranking.all.map do |ranking|
            {
              ranking: ranking,
              key: (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)
            }
        end
      
        @rankings_ordenados = @rankings_filtrados.sort_by { |item| item[:key] }
        @peor_ranking = @rankings_ordenados[0]
        @peor_director = @peor_ranking[:ranking].director
        @peor_director.destroy
        render json: @peor_director
    end

    def paginas_rankings
        # imdb
        @rankings_imdb = Ranking.where(page: "imdb")
        @imdb_con_llaves = @rankings_imdb.all.map do |ranking|
            {
              ranking: ranking,
              key: (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)
            }
        end
        @imdb_ordenados = @imdb_con_llaves.sort_by { |item| item[:key] }.reverse
    
        @imdb = @imdb_ordenados.map { |item| item[:ranking] }
        
        # metacritic
        @rankings_meta = Ranking.where(page: "metacritic")
        @meta_con_llaves = @rankings_meta.all.map do |ranking|
            {
              ranking: ranking,
              key: (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)
            }
        end
        @meta_ordenados = @meta_con_llaves.sort_by { |item| item[:key] }.reverse
    
        @metacritic = @meta_ordenados.map { |item| item[:ranking] }

        # rotten_tomatoes
        @rankings_rottentomatoes = Ranking.where(page: "rotten_tomatoes")
        @rottentomatoes_con_llaves = @rankings_rottentomatoes.all.map do |ranking|
            {
                ranking: ranking,
                key: (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)
            }
        end
        @rottentomatoes_ordenados = @rottentomatoes_con_llaves.sort_by { |item| item[:key] }.reverse
        @rottentomatoes = @rottentomatoes_ordenados.map { |item| item[:ranking] }


        @paginas = {"imdb" => @imdb, "metacritic" => @metacritic, "rotten_tomatoes" => @rottentomatoes}
        render json: @paginas
    end

    private
        def rankings_params
            params.require(:ranking).permit(:page, :min_score, :score, :max_score, :director)
        end
end
