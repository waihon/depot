class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: [:create]

  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    #@line_items = LineItem.all.order('id')

    # Error: undefined method 'id' for nil:NilClass
    #@line_items = LineItem.all.order(:id)
    
    @line_items = LineItem.all.order('id DESC')
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
    @readonly = false
  end

  # GET /line_items/1/edit
  def edit
    @readonly = true
  end

  # POST /line_items
  # POST /line_items.json
  def create
    #@line_item = LineItem.new(line_item_params)
    #logger.info "Product ID: #{params[:product_id]}"

    logger.info "Params: #{params}"
    #product = Product.find(params[:product_id])
    #if params[:product_id].nil?
    if params[:product_id].nil?
      product = Product.find(line_item_params[:product_id])
      quantity = line_item_params[:quantity].to_i
    else
      product = Product.find(params[:product_id])
      quantity = 1
    end
    
    #@line_item = @cart.line_items.build(product: product)
    @line_item = @cart.add_product(product.id, quantity)

    session[:counter] = 0

    respond_to do |format|
      if @line_item.save
        #format.html { redirect_to @line_item.cart, notice: 'Line item was successfully created.' }
        format.html { redirect_to @line_item.cart } # GET carts/1 => show
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      #params.require(:line_item).permit(:product_id, :cart_id)
      #params.require(:line_item).permit(:product_id)
      params.require(:line_item).permit(:product_id, :cart_id, :quantity)
      #params.require(:line_item).permit(:product_id, :quantity)
    end
end
