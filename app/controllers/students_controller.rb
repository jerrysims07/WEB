class StudentsController < ApplicationController
  def index
    @students = current_parent.students
  end

  def create
    @student = Student.where(student_params).first
    @student = Student.create(student_params) if @student.nil?
    @students = current_parent.students
    render 'index'
  end

  def edit
  end

  def new
  end

  def show
  end

  def update
    @student = Student.find(params[:id])
    @student.shadow_spot = ShadowSpot.find(student_params[:shadow_spot])
    @shadow_spot = @student.shadow_spot
  end

  def change_lunch
    @student = Student.find(params[:id])
    @student.update_attribute(:lunch, !!params[:lunch])
  end

  private
  def student_params
    params.require(:student).permit(:first_name, :grade, :last_name, :parent_id).merge(parent_id: current_parent.id)
  end

end
