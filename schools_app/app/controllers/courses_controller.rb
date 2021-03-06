class CoursesController < ApplicationController
  add_breadcrumb 'Cursos', :courses_path

  def index
    @courses = Course.all
    search_by_query(params[:q]) if params.has_key?(:q) && !params[:q].blank?
    filter_school(params[:course][:school_id]) if (
      params.fetch(:course, {}).fetch(:school_id, false) &&
      !params[:course][:school_id].blank?
    )
    @courses = @courses.order(updated_at: :desc)
  end

  def new
    add_breadcrumb 'Novo'
    @course = Course.new
  end

  def edit
    add_breadcrumb 'Editar'
    @course = set_course
  end

  def create
    add_breadcrumb 'Novo'
    @course = Course.create(course_params)
    respond_with @course
  end

  def update
    add_breadcrumb 'Editar'
    @course = set_course
    @course.update(course_params)
    respond_with @course
  end

  def destroy
    @course = set_course
    @course.destroy
    respond_with @course
  end

  private

  def set_course
    Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :school_id, :description, :content, :duration, :price)
  end

  def search_by_query(query)
    @courses = Course.search_title(query)
  end

  def filter_school(school_id)
    @courses = @courses.where(school_id: school_id)
  end
end
