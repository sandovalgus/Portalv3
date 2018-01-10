class ZonesController < ApplicationController
  before_action :set_zone, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json, :js
   
  # GET /zones
  # GET /zones.json
  def index
    @zones= Zone.all

    @polyjson = []
    schoolpoints = []
    @zones.each do |zone|
      CoordinateZone.where(:zone_id => zone.id).each do |point|
         schoolpoints << { :zone => point.zone_id,  :lng => point.longitud, :lat => point.latitud}
      end
    end
   # puts "********schoolpoints***********"
   # puts schoolpoints.inspect
 
    @polyjson = schoolpoints
    @polyjson = @polyjson.to_json
  end

  # GET /zones/1
  # GET /zones/1.json
  def show
  end

  # GET /zones/new
  def new
    @zone = Zone.new
  end

  # GET /zones/1/edit
  def edit
      @polyjson = []
      zonepoints = []
      # @zones.each do |zone|
        CoordinateZone.where(:zone_id => params[:id]).each do |point|
           zonepoints << { :zone => point.zone_id,  :lng => point.longitud, :lat => point.latitud}
        # end
      end
     # puts "********schoolpoints***********"
     # puts schoolpoints.inspect
   
      @polyjson = zonepoints
      @polyjson = @polyjson.to_json
  end

  # POST /zones
  # POST /zones.json
  def create

    has = params["area"].to_json
    data_has =  JSON.parse(has)
    @zone = Zone.new();
    @zone.nombre_zona = params["nombre_zona"]
    @zone.color = params["color"]

    respond_to do |format|
      if @zone.save
       
        data_has.each do |geo|
          @coordenada = CoordinateZone.new()
          geo.each do |data|
            @coordenada.zone_id = @zone.id
            @coordenada.latitud =  data["lat"].to_f
            @coordenada.longitud = data["lng"].to_f 
          end
          @coordenada.save
        end

        format.html { redirect_to @zone, notice: 'Zone was successfully created.' }
        format.js 
        # format.js { render js: "window.location.href=#{ directories_path }" }
        format.json { render :show, status: :created, location: @zone }
         
      else
        format.html { render :new }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /zones/1
  # PATCH/PUT /zones/1.json
  def update

     @zone = Zone.find(params[:id])
     @zone.nombre_zona = params["nombre_zona"]
      has = params["area"].to_json
      data_has =  JSON.parse(has)

    if params[:status_z] == "1"
        @coordenada = CoordinateZone.where('zone_id = ?', @zone.id)
        @coordenada.each do |cz|
          cz.destroy
        end

        data_has.each do |geo|
          @coordenada = CoordinateZone.new()
          geo.each do |data|
            @coordenada.zone_id = @zone.id
            @coordenada.latitud =  data["lat"].to_f
            @coordenada.longitud = data["lng"].to_f 
          end
          @coordenada.save
        end
    end
    respond_to do |format|
     if @zone.update(zone_params)
        format.html { redirect_to @zone, notice: 'Zone was successfully updated.' }
        format.js 
        format.json { render :show, status: :ok, location: @zone }
      else
        format.html { render :edit }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zones/1
  # DELETE /zones/1.json
  def destroy
    @zone.destroy
    respond_to do |format|
      format.html { redirect_to action: "index" }
      format.json { head :no_content }
      #testing
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zone
      @zone = Zone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zone_params
       params.permit(:zone, :nombre_zona, :color)
    end
end
