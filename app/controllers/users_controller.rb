class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :log_out, only: [:login]
  before_action :logged_in?, only: [:edit, :update]
  before_action :admin?, only: [:index, :show, :new, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(sort_column(User) + ' ' + sort_direction)
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def show
    fb = Feedback.where(user_id: @user.user_id)
    @feedbacks = fb.order(sort_column(Feedback) + ' ' + sort_direction)
    @responses = Response.where(user_id: @user.user_id).order("question_id")
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

    # if admin account
    if params[:user_id].eql? ENV["ADMIN"]
        session[:admin] = true
        redirect_to :responses

    # user exists in database
    elsif user = User.find_by(user_id: params[:user_id])

        # login user
        log_in user

        # user has not filled out info
        if user.gender.empty?
            redirect_to edit_user_path(user)

        # user has not completed anything
        elsif user.completed == 0
            flash.discard
            redirect_to '/questions/instructions'

        # user has completed something
        else
            flash.discard
            redirect_to '/questions/survey'
        end

    # user does not exist in database
    else

        # make a new user if hitting button
        if params[:completed].to_i < 0
            user = User.new(user_id: make_user, is_gamified: params[:is_gamified], gender: "",
                    age: 0, department: "", role: "", years_worked: "", completed: 0)
            user.save(:validate => false)
            redirect_to :root, notice: 'Your user ID is ' + user.user_id

        # attempt to login the user from login page
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
        log_in @user
        format.html { redirect_to '/questions/instructions' }
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
      params.require(:user).permit(:user_id, :gender, :age, :department, :role, :years_worked)
    end

    # create new random user string
    def make_user
        require 'securerandom'
        SecureRandom.hex(10)[0, 8]
    end

end
