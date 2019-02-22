class OptionalsController < ApplicationController
  include Calculations
  before_action :set_optional, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:new, :create]
  before_action :credentials?, only: [:new, :create]
  before_action :admin?, except: [:new, :create]

  # GET /optionals
  # GET /optionals.json
  def index
    @optionals = Optional.all.order(sort_column(Optional) + ' ' + sort_direction)
  end

  # GET /optionals/1
  # GET /optionals/1.json
  def show
  end

  # GET /optionals/new
  def new
    if @current_user.completed != 2**Question.all.count - 1
        flash[:danger] = 'Please complete the survey first'
        redirect_to :root and return
    end
    @has_responded = Optional.where(user_id: @current_user.user_id).count > 0
    @user_point_total = calculate_user(@current_user)
    @optional = Optional.new
  end

  # GET /optionals/1/edit
  def edit
  end

  # POST /optionals
  # POST /optionals.json
  def create

    # only save if the user input anything
    if !params[:response].empty?
        @optional = Optional.new(user_id: @current_user.user_id, is_gamified: @current_user.is_gamified, response: params[:response])
        @optional.save
    end

    # redirect to results
    redirect_to :new_optional

  end

  # PATCH/PUT /optionals/1
  # PATCH/PUT /optionals/1.json
  def update
    respond_to do |format|
      if @optional.update(optional_params)
        format.html { redirect_to @optional, notice: 'Optional was successfully updated.' }
        format.json { render :show, status: :ok, location: @optional }
      else
        format.html { render :edit }
        format.json { render json: @optional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /optionals/1
  # DELETE /optionals/1.json
  def destroy
    @optional.destroy
    respond_to do |format|
      format.html { redirect_to optionals_url, notice: 'Optional was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_optional
      @optional = Optional.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def optional_params
      params.require(:optional).permit(:user_id, :is_gamified, :response)
    end
end
