class IntercambiosController < ApplicationController
  before_action :authenticate_user!
  # POST
  #def new
  #  @intercambio = Intercambio.new
  #end

  def create
    @producto = Producto.find(params[:id])
    @intercambio = Intercambio.new(id_propietario: @producto.user.id, id_cliente: current_user.id,
                                   estado: 'Pendiente')

    @producto.update(disponible: false, intercambio: @intercambio)

    if @intercambio.save
      redirect_to action: 'index'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  # GET
  def index
    @intercambios = Intercambio.all
  end

  def show
    # redirect_to action: 'index'
  end

  # PATCH
  def page_update
    @intercambio = Intercambio.find(params[:id])
  end
  
  def update
    @intercambio = Intercambio.find(params[:id])
    if @intercambio.update(intercambio_params)
      redirect_to action: 'index', id: @intercambio.id
    else 
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @intercambio = Intercambio.find(params[:id])
    @producto = @intercambio.producto
    @producto.update(disponible: true)
    @intercambio.destroy

    redirect_to root_path, notice: 'Intercambio eliminado exitosamente.'
  end

  # ATRIBUTTES
  private 
  def intercambio_params
    params.require(:intercambio).permit(:id_propietario, :id_cliente, :estado)
  end
end
