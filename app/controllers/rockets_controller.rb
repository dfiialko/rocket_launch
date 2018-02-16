class RocketsController < ApplicationController
  before_action :set_rocket, only: [:show, :edit, :update, :destroy]

  # GET /rockets
  # GET /rockets.json
  def index
    @rockets = Rocket.all
  end

  # GET /rockets/1
  # GET /rockets/1.json
  def show
  end

  # GET /rockets/new
  def new
    @rocket = Rocket.new
  end

  # GET /rockets/1/edit
  def edit
  end

  # POST /rockets
  # POST /rockets.json
  def create
    @rocket = Rocket.new(rocket_params)

    respond_to do |format|
      if @rocket.save
        format.html { redirect_to @rocket, notice: 'Rocket was successfully created.' }
        format.json { render :show, status: :created, location: @rocket }
      else
        format.html { render :new }
        format.json { render json: @rocket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rockets/1
  # PATCH/PUT /rockets/1.json
  def update
    respond_to do |format|
      if @rocket.update(rocket_params)
        format.html { redirect_to @rocket, notice: 'Rocket was successfully updated.' }
        format.json { render :show, status: :ok, location: @rocket }
      else
        format.html { render :edit }
        format.json { render json: @rocket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rockets/1
  # DELETE /rockets/1.json
  def destroy
    @rocket.destroy
    respond_to do |format|
      format.html { redirect_to rockets_url, notice: 'Rocket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rocket
      @rocket = Rocket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rocket_params
      params.fetch(:rocket, {})
    end
end
