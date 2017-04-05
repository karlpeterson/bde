class ChallengesController < ApplicationController
	
	def dashboard
		@challenge = Challenge.last
		@today = Date.today
		@user = current_user
		user_challenges = @user.challenges
		@current_challenge = user_challenges.where("DATE(?) BETWEEN start_date AND end_date", @today).last
		@stat = Stat.find_by(:challenge_id => @challenge.id, :user_id => current_user.id)
		@datapoint_list = Datapoint.where("challenge_id = ? AND user_id = ?", @challenge.id, current_user.id).order(:day)
	end

	def rankings
		@current_challenge = Challenge.last
		@stat_list = Stat.where(:challenge_id => @current_challenge.id).order(:rank)
	end

	def index
		@challenges = Challenge.all
	end

	def show
		@challenge = Challenge.find(params[:id])
		@datapoint_list = Datapoint.where("challenge_id = ? AND user_id = ?", params[:id], current_user.id).order(:day)
		# @stat = Stat.where("challenge_id = ? AND user_id = ?", @current_challenge.id, current_user.id)
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

				stat = Stat.new(:user_id => user.id, :challenge_id => @challenge.id, :total_points => 0, :rank => 0)
				if stat.valid?
					stat.save
				else
					@errors += stat.errors
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
		@user_list = @challenge.users

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
