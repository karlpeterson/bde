class DatapointsController < ApplicationController
	def index
		@datapoints = Datapoint.all
	end

	def show
		@datapoint = Datapoint.find(params[:id])
	end

	def new
		@datapoint = Datapoint.new
	end

	def edit
		@datapoint = Datapoint.find(params[:id])
	end

	def create
		@datapoint = Datapoint.new(datapoint_params)
		@datapoint.user_id = current_user.id

		if @datapoint.save
			redirect_to @datapoint
		else
			render 'new'
		end
	end

	def update
		@datapoint = Datapoint.find(params[:id])

		if @datapoint.update(datapoint_params)
			total_points = [@datapoint.data_0,@datapoint.data_1,@datapoint.data_2,@datapoint.data_3,@datapoint.data_4,@datapoint.data_5,@datapoint.data_6,@datapoint.data_7,@datapoint.data_8,@datapoint.data_9]
			total_points = total_points.count(true)
			@datapoint.total_points = total_points
			@datapoint.save
			redirect_to '/dashboard'
		else
			render 'edit'
		end
	end

	def destroy
		@datapoint = Datapoint.find(params[:id])
		@datapoint.destroy

		redirect_to datapoints_path
	end

	private
	def datapoint_params
		params.require(:datapoint).permit(:data_0, :data_1, :data_2, :data_3, :data_4, :data_5, :data_6, :data_7, :data_8, :data_9, :user_id, :challenge_id)
	end
end
