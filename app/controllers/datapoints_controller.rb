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

	def create
		@datapoint = Datapoint.new(datapoint_params)

		if @datapoint.save
			redirect_to @datapoint
		else
			render 'new'
		end
	end

	private
	def datapoint_params
		params.require(:datapoint).permit(
			:data_0,
			:data_1,
			:data_2,
			:data_3,
			:data_4,
			:data_5,
			:data_6,
			:data_7,
			:data_8,
			:data_9
		)
	end
end
