class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all_except(current_user)

    @room = Room.new
    @rooms = Room.public_rooms
    @room_name = get_name(@user, current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    render 'rooms/index'
  end
  
  def cuenta_visita
    @user = User.find(params[:id])
  end

  def calificar_usuario
    @user = User.find(params[:id])

    if @user.calificacion == 0
      promedio_estrellas = params[:calificacion].to_i
    else
      promedio_estrellas = (@user.calificacion + params[:calificacion].to_i) / 2
    end

    @user.update(calificacion: promedio_estrellas)
    if @user.save
      redirect_to root_path, notice: 'Calificación actualizada exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def page_update
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path, notice: 'Usuario actualizado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def favoritos
    @user = User.find(current_user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: 'Usuario eliminado exitosamente.'
  end

  private
  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
