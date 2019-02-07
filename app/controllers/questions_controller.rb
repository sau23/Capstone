class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index]

  # GET /questions
  # GET /questions.json
  def index
    random(@user)
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
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:survey_id, :question_id, :question)
    end

    # check user session
    def set_user
        @user = User.find_by(id: session[:user_id])
        session[:side] = true
    end

    # find random unanswered question for user
    def random(user)
        total_questions = Question.all.count - 1
        
        # if user has completed all the questions
        if user.completed >= 2**total_questions
        
        # user has not yet finished all the questions
        else
            num = rand(0..total_questions)
            
            # user has already completed this question
            if user.completed & (1 << num) == 1
                if session[:side]
                    pos = 0
                    b = 1
                    while user.completed & b == 1
                        b << 1
                        pos += 1
                    end
                else
                    pos = total_questions
                    b = 1 << total_questions
                    while user.completed & b == 1
                        b >> 1
                        pos -= 1
                    end
                end
                session[:side] = !session[:side]
                question = Question.find_by(question_id: pos)
            else
                question = Question.find_by(question_id: num)
            end
            redirect_to question
        end
    end

end
