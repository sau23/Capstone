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
    user = User.find_by(user_id: params[:user_id])

    # user exists in database
    if user = User.find_by(user_id: params[:user_id])

        # login user
        login user

        # user has not filled out info
        if user.gender.empty?
            respond_to do |format|
                format.html{ redirect_to edit_user_path(user) }
                format.js
            end

        # user has not yet answered a question
        elsif user.completed == 0
            respond_to do |format|
                format.html{ render '/layouts/instructions' }
                format.js
            end

        # user has answered at least one question
        else
            redirect_to :questions
        end

    # user does not exist in database
    else
        flash[:danger] = 'User does not exist'
        redirect_to users_path
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

    # log in
    def login(user)
        session[:user_id] = user.id
    end
end
