class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:survey]
  before_action :admin?, except: [:create, :survey]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
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
        q = Question.new(question_id: params[:question][:question_id], to_ask: params[:question][:to_ask], option_1: params[:question][:option_1],
                    option_2: params[:question][:option_2], option_3: params[:question][:option_3], option_4: params[:question][:option_4])

        respond_to do |format|
            # pass through validation
            if q.save
                format.html { redirect_to index, notice: 'Question was successfully updated.' }
                format.js
            else
                format.html { redirect_to index }
                format.json { render json: @q.errozrs, status: :unprocessable_entity }
            end
        end
    else

        # find the question the user is currently reading
        question = Question.find_by(id: session[:question_id])

        # record the user's response and save it to the database
        response = Response.new(survey_id: @current_user.survey_id, question_id: question.question_id,
                user_id: @current_user.user_id, response: params[:response], response_text: params[:response_text])

        # check if the user has selected an option
        if response.save

            # set the user's flag for the specific question as complete
            @current_user.update(completed: @current_user.completed | (1 << question.question_id))

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

  # GET /questions/survey
  def survey
    if @current_user.completed == 0
        # TODO: instructions page
    end
    calculate
    random(@current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:survey_id, :question_id, :question)
    end

    # find random unanswered question for user
    def random(user)
        total_questions = Question.all.count
        
        # if user has completed all the questions
        if user.completed == 2**total_questions - 1
            calculate
            render '/layouts/finished'

        # user has not yet finished all the questions
        else
            num = rand(0..total_questions - 1)
            
            # user has already completed this question
            if (user.completed >> num) & 1 == 1
                if session[:side]
                    pos = 0
                    b = user.completed
                    while (b & 1) == 1
                        b >>= 1
                        pos += 1
                    end
                else
                    pos = total_questions - 1
                    b = user.completed.to_s(2).reverse!.to_i(2)
                    while (b & 1) == 1
                        b >>= 1
                        pos -= 1
                    end
                end
                session[:side] = !session[:side]
                @question = Question.find_by(question_id: pos)
            else
                @question = Question.find_by(question_id: num)
            end
            session[:question_id] = @question.id
        end
    end

    # calculate how many points the user currently has
    def calculate
        user_responses = Response.where(user_id: @current_user.user_id)
        @user_point_total = (user_responses.where("length(response_text) >= 40").count + 
                            @current_user.completed.to_s(2).scan(/1/).count) * 2
    end

end
