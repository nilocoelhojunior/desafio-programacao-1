# frozen_string_literal: true

class SalesController < ApplicationController

  before_action :authenticate_user!

  # GET /sale
  # GET /saleson
  def index
    all = current_user.sales.all
    @sales = current_user.sales.paginate(page: params[:page])
    @items = all.sum(:purchase_count)
    @purchasers = all.count
    @gross = all.sum('item_price*purchase_count')
    @count = all.count
  end

  # GET /saleew
  def new
    @sale = Sale.new
  end

  # POST /sale
  def create
    sales = FileImporterService.importer(sale_params, current_user)
    result = Sale.import(sales)
    respond_to do |format|
      if result.failed_instances.empty?
        format.html { redirect_to sales_path, notice: 'Sale was successfully created.' }
      else
        @sale = result.failed_instances.first
        @sale.validate
        format.html { render :new }
      end
    end
  rescue ActiveModel::UnknownAttributeError => error
    respond_to do |format|
      @saleSale.new
      flash[:alert] = 'Verifique o arquivo e tente novamente'
      format.html { render :new }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def sale_params
    params.require(:sale).permit(:name, :user_id, :file)
  end

end
