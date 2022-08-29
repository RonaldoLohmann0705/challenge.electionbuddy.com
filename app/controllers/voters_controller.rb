# frozen_string_literal: true

class VotersController < ApplicationController
  before_action :authenticate_user!, except: %i[ballot submit]
  before_action :set_voter, only: %i[show edit update destroy]
  before_action :set_election, only: %i[index new create]

  # GET /voters
  # GET /voters.json
  def index
    @voters = Voter.all
  end

  # GET /voters/1
  # GET /voters/1.json
  def show; end

  # GET /voters/new
  def new
    @voter = Voter.new
  end

  # GET /voters/1/edit
  def edit; end

  # POST /voters
  # POST /voters.json
  def create
    @voter = Voter.new(voter_params.merge(election: @election))

    respond_to do |format|
      if @voter.save
        format.html { redirect_to @voter, notice: 'Voter was successfully created.' }
        format.json { render :show, status: :created, location: @voter }
      else
        format.html { render :new }
        format.json { render json: @voter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /voters/1
  # PATCH/PUT /voters/1.json
  def update
    respond_to do |format|
      if @voter.update(voter_params.merge(updated_by: current_user.id))
        format.html { redirect_to @voter, notice: 'Voter was successfully updated.' }
        format.json { render :show, status: :ok, location: @voter }
      else
        format.html { render :edit }
        format.json { render json: @voter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voters/1
  # DELETE /voters/1.json
  def destroy
    election = @voter.election
    @voter.destroy
    respond_to do |format|
      format.html { redirect_to election_voters_url(election), notice: 'Voter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ballot; end

  def submit; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voter
    @voter = Voter.find(params[:id])
  end

  def set_election
    @election = Election.find(params[:election_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def voter_params
    params.require(:voter).permit(:name, :email, :election_id)
  end
end
