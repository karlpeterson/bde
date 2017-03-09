class ChallengesController < ApplicationController
	
	def dashboard
		if current_user
			@current_challenge = Challenge.last
		else
			redirect_to '/users/login'
		end
	end

	def rankings
		if current_user

		else

		end
	end

	def index
		@challenges = Challenge.all
	end

	def show
		@challenge = Challenge.find(params[:id])
	end

	def edit
		@challenge = Challenge.find(params[:id])
	end

	def new
		@challenge = Challenge.new
	end

	def create
		@challenge = Challenge.new(challenge_params)

		if @challenge.save
			redirect_to @challenge
		else
			render 'new'
		end
	end

	def update
		@challenge = Challenge.find(params[:id])

		if @challenge.update(challenge_params)
			redirect_to @challenge
		else
			render 'edit'
		end
	end

	def destroy
		@challenge = Challenge.find(params[:id])
		@challenge.destroy

		redirect_to challenges_path
	end

	private
	def challenge_params
		params.require(:challenge).permit(:name, :start_date, :duration, :user_ids => [])
	end
end
