class ChallengesController < ApplicationController
	
	before_action :authenticate_user!

	def dashboard
		@today = Date.today
		@user = current_user
		user_challenges = @user.challenges
		@current_challenge = user_challenges.where("DATE(?) BETWEEN start_date AND end_date", @today).last
		if @current_challenge.present?
			@stat = Stat.find_by(:challenge_id => @current_challenge.id, :user_id => current_user.id)
			@datapoint_list = Datapoint.where("challenge_id = ? AND user_id = ?", @current_challenge.id, current_user.id).order(:day)
		end
	end

	def rankings
		@today = Date.today
		@user = current_user
		user_challenges = @user.challenges
		@current_challenge = user_challenges.where("DATE(?) BETWEEN start_date AND end_date", @today).last
		# check user for current cohort
		# current_cohort = Cohort.where(:challenge_id => @current_challenge.id)
		
		if @current_challenge.present?
			@stat_list = Stat.where(:challenge_id => @current_challenge.id).order(:rank)
		end
	end

	def index
		user = current_user
		if can? :edit, Challenge
			@challenges = Challenge.all
		else
			@challenges = user.challenges
		end
	end

	def show
		@user = current_user
		@challenge = Challenge.find(params[:id])
		@stat_list = Stat.where(:challenge_id => @challenge.id).order(:rank)
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

				# create join
				stat = Stat.new(:user_id => user.id, :challenge_id => @challenge.id, :total_points => 0, :rank => 0)
				if stat.valid?
					stat.save
				else
					@errors += stat.errors
				end

				# for each date in range create an empty Datapoint
				date_range.each_with_index do |day, index|
					day_count = index + 1
					if Datapoint.where(:user_id => user.id, :challenge_id => @challenge.id, :date => day, :day => day_count)
						# do nothing if Datapoint already exists
					else
						datapoint = Datapoint.new(:user_id => user.id, :challenge_id => @challenge.id, :date => day, :day => day_count)
						if datapoint.valid?
							datapoint.save
						else
							@errors += datapoint.errors
						end
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

			start_date	= @challenge.start_date
			end_date 	= @challenge.end_date
			# create array of dates between start_date and duration
			date_range	= start_date..end_date
			date_range	= date_range.map(&:to_s)

			stat_list = Stat.where(:challenge_id => @challenge.id)
			stat_list.delete_all

			# loop through all associated users
			@user_list.each do |user|

				# check if association exists between User and Challenge
				association = Stat.where(:user_id => user.id, :challenge_id => @challenge.id)
				if association.exists?
					# do nothing if association already exists
				else

					# create join
					cohort = Cohort.new(:user_id => user, :challenge_id => @challenge.id)
					if cohort.valid?
						cohort.save
					else
						@errors += cohort.errors
					end

					#create join & update stats
					datapoints = Datapoint.where(:user_id => user.id, :challenge_id => @challenge.id)
					grand_total = datapoints.sum(:total_points)

					stat_list = Stat.where(:challenge_id => @challenge.id).order(:total_points).reverse_order
					rank = 1
					stat_list.each_with_index do |stat, i|
						stat_list[i-1].total_points == stat.total_points ? rank : rank = i+1
						stat.rank = rank
						stat.save
					end

					stat = Stat.new(:user_id => user.id, :challenge_id => @challenge.id, :total_points => grand_total, :rank => 0)
					if stat.valid?
						stat.save
					else
						@errors += stat.errors
					end

					# for each date in range create an empty Datapoint
					date_range.each_with_index do |day, index|
						day_count = index + 1
						if Datapoint.where(:user_id => user.id, :challenge_id => @challenge.id, :date => day, :day => day_count)
							# do nothing if Datapoint already exists
						else
							datapoint = Datapoint.new(:user_id => user.id, :challenge_id => @challenge.id, :date => day, :day => day_count)
							if datapoint.valid?
								datapoint.save
							else
								@errors += datapoint.errors
							end
						end
					end

				end
			end

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
