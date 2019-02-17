class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]
  before_action :admin?
  helper_method :sort_column, :sort_direction

  # GET /responses
  # GET /responses.json
  def index
    @users = User.all
    @questions = Question.all
    @responses = Response.all
    #@responses_g = Response.where(is_gamified: "true").order(sort_column + ' ' + sort_direction)
    #@responses_n = Response.where(is_gamified: "false").order(sort_column + ' ' + sort_direction)
    @feedbacks = Feedback.all
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses
  # POST /responses.json
  def create

#    @response = Response.new(response_params)
#
#    respond_to do |format|
#      if @response.save
#        format.html { redirect_to @response, notice: 'Response was successfully created.' }
#        format.json { render :show, status: :created, location: @response }
#      else
#        format.html { render :new }
#        format.json { render json: @response.errors, status: :unprocessable_entity }
#      end
#    end

  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      params.require(:response).permit(:question_id, :user_id, :selection, :response_text)
    end

    # table sorting helpers
    def sort_column
        Response.column_names.include?(params[:sort]) ? params[:sort] : "question_id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
