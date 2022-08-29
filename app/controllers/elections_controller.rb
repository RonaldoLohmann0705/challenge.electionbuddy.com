# frozen_string_literal: true

class ElectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_election, only: %i[show edit update destroy]

  # GET /elections
  # GET /elections.json
  def index
    @elections = current_user.elections
  end

  # GET /elections/1
  # GET /elections/1.json
  def show; end

  # GET /elections/new
  def new
    @election = Election.new
  end

  # GET /elections/1/edit
  def edit; end

  # POST /elections
  # POST /elections.json
  def create
    @election = Election.new(election_params.merge(user: current_user))

    respond_to do |format|
      if @election.save
        format.html { redirect_to @election, notice: 'Election was successfully created.' }
        format.json { render :show, status: :created, location: @election }
      else
        format.html { render :new }
        format.json { render json: @election.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elections/1
  # PATCH/PUT /elections/1.json
  def update
    respond_to do |format|
      if @election.update(election_params.merge(updated_by: current_user.id))
        format.html { redirect_to @election, notice: 'Election was successfully updated.' }
        format.json { render :show, status: :ok, location: @election }
      else
        format.html { render :edit }
        format.json { render json: @election.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elections/1
  # DELETE /elections/1.json
  def destroy
    @election.destroy
    respond_to do |format|
      format.html { redirect_to elections_url, notice: 'Election was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_election
    @election = Election.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def election_params
    params.require(:election).permit(:name, :start_at, :end_at, :visibility)
  end
end
