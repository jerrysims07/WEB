class StudentsController < ApplicationController
  def index
  end

  def create
    @student = Student.where(student_params).first
    @student = Student.create(student_params) if @student.nil?
    respond_to do |format|
      format.js { }
    end
  end

  def show
  end

  def update
    @student = Student.find(params[:id])
    @student.shadow_spot = ShadowSpot.find(student_params[:shadow_spot])
    @shadow_spot = @student.shadow_spot
  end

  private
  def student_params
    params.require(:student).permit(:email_address, :first_name, :grade,
      :last_name, :parent_first_name, :parent_last_name, :shadow_spot)
    end


end