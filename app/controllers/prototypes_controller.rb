class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]


  def index
    if user_signed_in?
      @prototype =  current_user.id
    end
    @prototypes = Prototype.all.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user == current_user
      redirect_to action: :index
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end


  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to root_path
     else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  

end
