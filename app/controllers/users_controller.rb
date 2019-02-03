class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    if User.exists? user_id: params[:user_id]
      respond_to do |format|
        #user not yet initialized
        if User.where(user_id: params[:user_id], gender: '').count > 0
            @users = User.where(user_id: params[:user_id], gender: '')
            @users.each do |user|
                format.html{ redirect_to edit_user_path(user) }
                format.js
            end
        #user already initialized, completed nothing
        elsif User.where(user_id: params[:user_id], completed: '0').count > 0
            format.html{ redirect_to questions_path }
            format.js
        #user already initialized, completed something
        else
            format.html{ redirect_to "questions/show" }
            format.js
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to users_path, notice: 'User does not exist' }
        format.js
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_id, :gender, :age, :department, :clinical_year)
    end
end
