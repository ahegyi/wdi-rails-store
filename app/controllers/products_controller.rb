class ProductsController < ApplicationController
  before_filter :get_products_in_cart, :only => [:show, :index]
  

  # PUT /product/:id/add_to_cart        add_to_cart
  # PUT /product/:id/remove_from_cart   remove_from_cart
  def add_to_cart
    @product = Product.find(params[:id])

    if @product.in_cart
      redirect_to products_url, notice: "#{@product.name} is already in your cart."
      return
    else
      @product.in_cart = true
      @product.save!
      redirect_to products_url, notice: "#{@product.name} was successfully added to cart."
      return
    end
    
  end

  def remove_from_cart
    @product = Product.find(params[:id])

    @product.in_cart = false
    @product.save!

    redirect_to products_url, notice: "#{@product.name} was successfully removed from your cart."
  end

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.sort

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    @reviews = @product.reviews

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end


  private

  def get_products_in_cart
    @products_in_cart = Product.where(:in_cart => true)
    @cart_total = @products_in_cart.map{|p| p.price}.reduce(:+)
  end
end
