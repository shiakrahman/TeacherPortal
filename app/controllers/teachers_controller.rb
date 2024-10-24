class TeachersController < ApplicationController
    def login
    end
  
    def authenticate
      teacher = Teacher.find_by(email: params[:email])
      if teacher&.authenticate(params[:password])
        session[:teacher_id] = teacher.id
        redirect_to students_path
      else
        flash.now[:alert] = "Invalid credentials"
        render :login
      end
    end
  
    def index
      @students = current_teacher.students
    end
  
    private
  
    def current_teacher
      @current_teacher ||= Teacher.find(session[:teacher_id]) if session[:teacher_id]
    end
end
  