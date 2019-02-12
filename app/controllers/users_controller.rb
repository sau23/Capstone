class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @feedbacks = Feedback.where(user_id: @user.user_id)
  end

  # GET /users/new
  def new
    #@user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create

    # if admin account
    if params[:user_id].eql? "admin"
        redirect_to :responses

    # user exists in database
    elsif user = User.find_by(user_id: params[:user_id])

        # login user
        login user

        # user has not filled out info
        if user.gender.empty?
            redirect_to edit_user_path(user)
        else
            redirect_to '/questions/survey'
        end

    # user does not exist in database
    else
        if params[:completed].to_i < 0
            user = User.new(user_id: make_user, survey_id: params[:user][:survey_id], gender: "",
                    age: 0, department: "", clinical_year: "", completed: 0)
            user.save
            flash[:success]
            redirect_to :users, notice: 'User ' + user.user_id + ' created'
        else
            flash[:danger] = 'User does not exist'
            redirect_to :root
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

  # GET /users/login
  def login
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

    # create new random user string
    def make_user
        require 'securerandom'
        SecureRandom.hex(10)[0, 8]
    end

end
