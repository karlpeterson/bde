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
		@datapoint_list = @challenge.datapoints
	end

	def edit
		@challenge = Challenge.find(params[:id])
	end

	def new
		@challenge = Challenge.new
		
	end

	def create
		@challenge = Challenge.new(challenge_params)
		@user_list = @challenge.users

		if @challenge.save

			start_date	= @challenge.start_date
			end_date 	= @challenge.end_date
			# create array of dates between start_date and duration
			date_range	= start_date..end_date
			date_range	= date_range.map(&:to_s)

			# loop through all associated users
			@user_list.each do |user|
				# create join
				cohort = Cohort.new(:user_id => user, :challenge_id => @challenge.id)
				if cohort.valid?
					cohort.save
				else
					@errors += cohort.errors
				end

				# for each date in range create an empty Datapoint
				date_range.each_with_index do |day, index|
					day_count = index + 1
					datapoint = Datapoint.new(:user_id => user.id, :challenge_id => @challenge.id, :date => day, :day => day_count)
					if datapoint.valid?
						datapoint.save
					else
						@errors += datapoint.errors
					end
				end
			end

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
		params.require(:challenge).permit(:name, :start_date, :end_date, :user_ids => [])
	end
end
