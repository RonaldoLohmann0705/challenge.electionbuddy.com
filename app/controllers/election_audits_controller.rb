# frozen_string_literal: true

class ElectionAuditsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_election

    def index
      @audits = @election.audits
    end
  
    private
  
    def set_election
      @election = Election.find(params[:election_id])
    end
  
    def election_params
      params.permit(:election_id)
    end
  end
  