module Calculations
    extend ActiveSupport::Concern

    # find random unanswered question for user
    def random(user)
        total_questions = Question.all.count
        
        # if user has completed all the questions
        if user.completed == 2**total_questions - 1
            @user_point_total = calculate_user(user)
            redirect_to :new_optional

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
                ret = pos
            else
                ret = num
            end
            cookies.signed[@current_user.user_id] = ret
            ret
        end
    end

    # calculate how many points a given user currently has
    def calculate_user(user)
        user_responses = Response.where(user_id: user.user_id)
        (user_responses.where("length(response_text) >= 40").count + user.completed.to_s(2).scan(/1/).count) * 2
    end

    # calculate all the points accumulated by a given department
    def calculate_all(dept)
        select_dept = User.where(is_gamified: true, department: dept)
        ret = 0
        select_dept.each do |user|
            ret += calculate_user(user)
        end
        ret
    end    

end
