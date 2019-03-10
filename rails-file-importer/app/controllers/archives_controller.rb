# frozen_string_literal: true

class ArchivesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_archive, only: %i[show edit update destroy]

  # GET /archives
  # GET /archives.json
  def index
    all = current_user.archives.all
    @archives = current_user.archives.paginate(page: params[:page])
    @items = all.sum(:purchase_count)
    @purchasers = all.count
    @gross = all.sum('item_price*purchase_count')
    @count = all.count
  end

  # GET /archives/1
  # GET /archives/1.json
  def show; end

  # GET /archives/new
  def new
    @archive = Archive.new
  end

  # GET /archives/1/edit
  def edit; end

  # POST /archives
  def create
    archives = FileImporterService.importer(archive_params, current_user)
    result = Archive.import(archives)
    respond_to do |format|
      if result.failed_instances.empty?
        format.html { redirect_to archives_path, notice: 'Archive was successfully created.' }
      else
        @archive = result.failed_instances.first
        @archive.validate
        format.html { render :new }
      end
    end
  rescue ActiveModel::UnknownAttributeError => error
    respond_to do |format|
      @archive = Archive.new
      flash[:alert] = 'Verifique o arquivo e tente novamente'
      format.html { render :new }
    end
  end

  # PATCH/PUT /archives/1
  # PATCH/PUT /archives/1.json
  def update
    respond_to do |format|
      if @archive.update(archive_params)
        format.html { redirect_to @archive, notice: 'Archive was successfully updated.' }
        format.json { render :show, status: :ok, location: @archive }
      else
        format.html { render :edit }
        format.json { render json: @archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archives/1
  # DELETE /archives/1.json
  def destroy
    @archive.destroy
    respond_to do |format|
      format.html { redirect_to archives_url, notice: 'Archive was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_archive
    @archive = Archive.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def archive_params
    params.require(:archive).permit(:name, :user_id, :file)
  end

end
