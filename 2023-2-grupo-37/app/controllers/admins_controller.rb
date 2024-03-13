class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
    
  def index
    @users = User.all
      @productos = Producto.all
      @reportes = Reporte.all
      @intercambios = Intercambio.all 
  end

  def productos
    @productos = Producto.all
  end

  def reportes
    @reportes = Reporte.all
  end

  def intercambios
    @intercambios = Intercambio.all
  end

  def usuarios
    @users = User.all
  end
    
    private
    
  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Access denied."
    end
  end
end
