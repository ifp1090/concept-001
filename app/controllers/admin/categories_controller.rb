class Admin::CategoriesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_filter :require_is_admin

  layout "admin"

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "更新成功！这年头必须随时更新自己脑子里面的概念！"
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, alert: "删除了你后悔不？后悔咋做？提取练习你今天做了吗？"
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
