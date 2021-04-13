class ElectionsController < ApplicationController
  before_action :set_election, only: [:show, :update, :destroy]

  # GET /elections
  def index
    @elections = params[:search].present? ? Election.search(params[:search]).records : Election.all
    if params[:sort]
      @elections = @elections.sort_by(&:created_at).reverse
    end
    if params[:order]
      @elections = @elections.sort_by{|e| e.votes.count}.reverse
    end
    render json: format_election_result(@elections)
    #render json: ElectionSerializer.new(@elections)
  end

  # GET /elections/1
  def show
    render json: @election
  end

  # POST /elections
  def create
    @election = Election.new(election_params)

    if @election.save
      render json: @election, status: :created, location: @election
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /elections/1
  def update
    if @election.update(election_params)
      render json: @election
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

  # DELETE /elections/1
  def destroy
    @election.destroy
  end

  def categories
    render json: Election::CATEGORIES, status: 200
  end

  private

    def format_election_result(elections)
      result = []
      elections.each do |el|
        total_polled_votes = el.votes.count
        total_eligible_users = el.group.user_groups.count
        percentage_of_votes = ((total_polled_votes/total_eligible_users)*100) unless total_polled_votes == 0 || total_eligible_users == 0
        result.push(id: el.id, 
                    name: el.name,
                    total_polled_votes: total_polled_votes,
                    total_eligible_users: total_eligible_users,
                    percentage_of_votes: percentage_of_votes || 0)
      end
      result
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_election
      @election = Election.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def election_params
      params.require(:election).permit(:name, :category, :group, :search)
    end
end
