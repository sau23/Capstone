class QuestionsController < ApplicationController
  include Calculations
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:survey, :instructions, :confirmation]
  before_action :credentials?, only: [:survey, :instructions, :confirmation]
  before_action :admin?, except: [:create, :survey, :instructions, :confirmation]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all.order(sort_column(Question) + ' ' + sort_direction)
    @question = Question.new
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create

    # if admin is creating a new question
    if params[:new].to_i == 1
        q = Question.new(question_id: params[:question][:question_id], to_ask: params[:question][:to_ask], 
                        option_1: params[:question][:option_1], option_2: params[:question][:option_2], 
                        option_3: params[:question][:option_3])

        respond_to do |format|

            # pass through validation
            if q.save
                format.html { redirect_to index, notice: 'Question was successfully updated.' }
                format.js
            else
                format.html { redirect_to index }
                format.json { render json: @q.errors, status: :unprocessable_entity }

            end
        end
    else

        # find the question the user is currently reading
        question = Question.find_by(question_id: cookies.signed[@current_user.user_id])

        # record the user's response and save it to the database
        response = Response.new(question_id: question.question_id, user_id: @current_user.user_id, 
                    is_gamified: @current_user.is_gamified, selection: params[:selection], 
                    response_text: params[:response_text])

        # check if the user has selected an option
        if response.save

            # set the user's flag for the specific question as complete
            @current_user.update(completed: @current_user.completed | (1 << question.question_id))

            # delete the question id from cookie sorage
            cookies.delete(@current_user.user_id)

            # find another question for the user
            redirect_to '/questions/survey' and return

        # otherwise do not continue or mark question as completed
        else
            flash.now[:danger] = 'Please select an option'
        end

    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /questions/confirmation
  def confirmation

    # calculate corresponding point totals
    @user_point_total = calculate_user(@current_user)
    @ed_point_total = calculate_all("Emergency Department")
    @icu_point_total = calculate_all("Intensive Care Unit")
    @team_point_total = @current_user.department.eql?("Emergency Department") ? @ed_point_total : @icu_point_total

  end

  # GET /questions/instructions
  def instructions
  end

  # GET /questions/survey
  def survey

    # check if the user already has a cookie for their last saved question
    next_question = cookies.signed[@current_user.user_id] ? cookies.signed[@current_user.user_id] : random(@current_user)

    # calculate point totals for the user
    @user_point_total = calculate_user(@current_user)

    # set the question for the user
    @question = Question.find_by(question_id: next_question)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:is_gamified, :question_id, :to_ask)
    end
end
