class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    # @customers = Customer.all
    @customers= Customer.includes(:addresses).all.paginate(page: params[:page], per_page: 10)
    @addres = Address.all

    @map_hash = Gmaps4rails.build_markers(@addres) do |address, marker|
      customer = Customer.select(:nombre, :apellido, :n_socio, :estado).where(:id => address.customer_id).last
      marker.lat address.latitude
      marker.lng address.longitude
      marker.infowindow render_to_string(:partial => "info", :locals =>{:address => address, :customer => customer}) 
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    # @customers= Customer.includes(:addresses).all
      @customers= Customer.includes(:addresses).find(params[:id])
      @addres = Address.where(customer_id: @customers.id).first
      @map_hash = Gmaps4rails.build_markers(@addres) do |address, marker|
      marker.lat address.latitude
      marker.lng address.longitude
      # marker.infowindow [address.address,"</br>", address.latitude,address.latitude].join('-')

      marker.infowindow render_to_string(:partial => "info", :locals =>{:address => @addres, :customer => @customers})
    
    end

  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @customer.addresses.build
  end

  # GET /customers/1/edit
  def edit  
      @customers= Customer.includes(:addresses).find(params[:id])
      @addres = Address.where(customer_id: @customers.id).first
      @map_hash = Gmaps4rails.build_markers(@addres) do |address, marker|
        marker.lat address.latitude
        marker.lng address.longitude
        marker.infowindow [address.address,"</br>", address.latitude,address.latitude].join('-')
    end
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # CHECK /customers/1
  # CHECK /customers/1.json
  def check
    @import = Import.last
    puts @import.state
    render js: @import.state.to_s
  end

  def checkok
    @import = Import.create(state: false)
    puts import.state
  end

  def import
    #Customer.import(params[:file])

    if params[:file].blank?
      flash[:error] = 'Debes seleccionar un archivo valido.'
      redirect_to '/customers/load'
    else
      ext = params[:file]
      ImportWorker.perform_async(ext.path, ext)
      redirect_to root_url, notice: "Los se están importando. Te estaremos avisando cuando estén listos."
    end

  end

  def load
    puts "okokokokokok"
    puts "okokokokokok"
    puts "okokokokokok"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:n_socio, :nombre, :apellido, addresses_attributes: [:id, :address, :latitude, :longitude])
    end
end

