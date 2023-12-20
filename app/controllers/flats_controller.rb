class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_flat, only: [:show, :edit, :update, :destroy]
  before_action :set_user, except: [:index, :show]


  def index
    @flats = Flat.all
  end

  def show
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update

    @flat.update(flat_params)
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_path, status: :see_other
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :number_of_guest, :rating)
  end

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def set_user
    @user = current_user
  end

end
