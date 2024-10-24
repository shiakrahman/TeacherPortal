class StudentsController < ApplicationController
    before_action :set_student, only: [:edit, :update, :destroy]
  
    def index
      @students = current_teacher.students
    end
  
    def new
      @student = current_teacher.students.build
    end
  
    def create
      @student = current_teacher.students.find_or_initialize_by(name: params[:student][:name], subject: params[:student][:subject])
      if @student.new_record?
        @student.marks = params[:student][:marks].to_i
      else
        @student.marks += params[:student][:marks].to_i
      end
      if @student.save
        redirect_to students_path
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @student.update(student_params)
        redirect_to students_path
      else
        render :edit
      end
    end
  
    def destroy
      @student.destroy
      redirect_to students_path
    end
  
    private
  
    def set_student
      @student = current_teacher.students.find(params[:id])
    end
  
    def student_params
      params.require(:student).permit(:name, :subject, :marks)
    end
end
  