class InformationController < ApplicationController
  before_action :set_epicenter
  before_action :set_info, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @information = @epicenter.information.order(:position)
  end

  def show
  end

  def new
    @info = @epicenter.information.build
  end

  def edit
  end

  def create
    @info = @epicenter.information.build(information_params)
    if @info.save
      redirect_to epicenter_information_index_path(@epicenter), notice: 'Informationen blev oprettet'
    else
      render action: 'new'
    end
  end

  def update
    if @info.update(information_params)
      redirect_to epicenter_information_index_path(@epicenter), notice: 'Informationen blev opdateret.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @info.destroy
    redirect_to epicenter_information_index_path(@epicenter)
  end



  private

    def set_epicenter
      @epicenter = Epicenter.find_by_slug(params[:epicenter_id])
    end

    def set_info
      @info = Information.find(params[:id])
    end

    def information_params
      params.require(:information).permit(:title, :body, :position)
    end

end
