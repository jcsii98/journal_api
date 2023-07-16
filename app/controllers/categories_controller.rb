class CategoriesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :category_not_found

before_action :set_category, only: [:show, :update, :destroy]

def index
    @categories = Category.all
    
    render json: @categories.to_json
end

def show
        render json: @category
end

def new
    @category = Category.new

    render json: @category.to_json
end

def create
  @category = Category.new(category_params)

  if @category.save
    render json: @category.to_json, status: :created
  else
    render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
  end
end

def update
    if @category.update(category_params)
        render json: @category
    else
        render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity 
    end
end

def destroy
    if @category.destroy
        render json: { message: 'Category successfully deleted'}
    else
        render json: { errors: @categories.errors.full_messages }, status: :unprocessable_entity
    end
end

private 

def set_category 
    @category = Category.find(params[:id])
end

def category_not_found
    render json: { error: 'Category not found' }, status: :not_found
end

def category_params
    params.require(:category).permit(:name)
end

end
