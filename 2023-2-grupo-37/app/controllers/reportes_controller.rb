  class ReportesController < ApplicationController

    def show
      @producto = Producto.find(params[:id])
      @reportes = @producto.reportes
    end

    def new
      @reporte = Reporte.new
    end

    def create
      @producto = Producto.find(params[:id])
    
      if @producto.reportes.count >= 3
        @producto.destroy
        redirect_to productos_path, 
                    notice: 'El producto ha sido eliminado debido a que ha superado el número máximo de reportes.'
      else
        @reporte = Reporte.new(reporte_params)
        @reporte.producto = @producto
        @reporte.user = current_user 
    
        if @reporte.save
          redirect_to @producto, notice: 'Reporte enviado con éxito.'
        else
          render :new, status: :unprocessable_entity
        end
      end
    end

    def page_update
      @reporte = Reporte.find(params[:id])
    end

    #def update
    #  @reporte = Reporte.find(params[:id])
    # @producto = Producto.find(@reporte.producto_id)
    # if @reporte.update(reporte_params)
    #   redirect_to root_path, notice: 'Reporte acutualizado con exito.'
    # else
    #   render :new, status: :unprocessable_entity
    # end
    #end

    def destroy
      @reporte = Reporte.find(params[:id])
      @reporte.destroy
      redirect_to root_path, notice: 'Reporte eliminado con éxito.'
    end

  private

    def reporte_params
      params.require(:reporte).permit(:producto_id, :user_id, :descripcion)
    end
end