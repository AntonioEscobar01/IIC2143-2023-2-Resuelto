
class ProductosController < ApplicationController
  # GET
  def index
    # @users = User.all
    @productos = Producto.all
  end

  # GET
  def show
    @producto = Producto.find(params[:id])
    @producto.agregar_visita
  end
  
  # GET
  def new
    @producto = Producto.new
  end

  def favoritos
    @user = User.find(current_user.id)
    new_fav = @user.productos_fav
    if !new_fav.values.include?(Producto.find(params[:id]))
      new_fav[params[:id]] = Producto.find([params[:id]])
    end
    
    @user.update(productos_fav: new_fav)
    redirect_to action: 'favoritos', controller: 'users'
  end

  def eliminar_favorito
    @user = User.find(current_user.id)
    new_fav = @user.productos_fav
    new_fav.delete(params[:id])
    @user.update(productos_fav: new_fav)
    redirect_to action: 'favoritos', controller: 'users'
  end

  def mas_visitados
    @productos = Producto.order(visitas: :desc).limit(15)
    render :index
  end
  
  # PATCH
  def page_update
    @producto = Producto.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    @producto = Producto.find(params[:id])
    if @producto.update(producto_params)
      redirect_to action: 'show', id: @producto.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  # POST
  def create
    @user = User.find(current_user.id)
    @producto = @user.productos.new(producto_params)
    @producto.update(user: @user, disponible: true)
    if @producto.save
      redirect_to action: 'show', id: @producto.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE 
  def destroy
    @user = User.find(current_user.id)
    @producto = Producto.find(params[:id])

    new_fav = @user.productos_fav
    new_fav.delete(params[:id])
    @user.update(productos_fav: new_fav)

    @producto.destroy

    redirect_to root_path, notice: 'Producto eliminado exitosamente.'
  end
  
  private
  def producto_params
    params.require(:producto).permit(:nombre, :descripcion ,:categoria, :image)
  end
end
