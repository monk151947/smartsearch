class SearchappsController < ApplicationController
  require 'yomu'

  def index
    @searchapps = Searchapp.text_search params[:search]
    @search_words = params[:search] ? params[:search].split(/\W/) : ''
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @searchapps }
    end
  end

  def show
    @searchapp = Searchapp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @searchapp }
    end
  end

  def new
    @searchapp = Searchapp.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @searchapp }
    end
  end

  def edit
    @searchapp = Searchapp.find(params[:id])
  end

  def create
    @searchapp = Searchapp.new(params[:searchapp])

    respond_to do |format|
      if @searchapp.save
        format.html { redirect_to @searchapp, notice: 'Searchapp was successfully created.' }
        format.json { render json: @searchapp, status: :created, location: @searchapp }
      else
        format.html { render action: "new" }
        format.json { render json: @searchapp.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @searchapp = Searchapp.find(params[:id])

    respond_to do |format|
      if @searchapp.update_attributes(params[:searchapp])
        format.html { redirect_to @searchapp, notice: 'Searchapp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @searchapp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @searchapp = Searchapp.find(params[:id])
    @searchapp.destroy
    respond_to do |format|
      format.html { redirect_to searchapps_url }
      format.json { head :no_content }
    end
  end
end

