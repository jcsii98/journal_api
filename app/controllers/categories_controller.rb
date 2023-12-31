class CategoriesController < ApplicationController
before_action :authenticate_user!
before_action :set_user
before_action :set_category, only: [:show, :update, :destroy]

def index
    @categories = @user.categories
    response_data = { "categories": @categories }
    render json: response_data
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
    @category.user_id = @current_user.id

    if @category.save
        render json: @category, status: :created
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
    @category = @user.categories.find(params[:id])
end

def category_params
    params.require(:category).permit(:name)
end

def set_user
    @user = @current_user
end

end
