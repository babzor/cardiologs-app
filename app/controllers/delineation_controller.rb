class DelineationController < ApplicationController
  include DelineationHelper

  # GET /delineation
  def index
  end

  # POST /delineation
  def create
    if params[:ecg_csv_file]
      ecg_waves = extract_data_from_csv(params[:ecg_csv_file].path)
      mean_heart_rate = mean_heart_rate(ecg_waves)
      min_heart_rate, max_heart_rate = min_max_heart_rate(ecg_waves)

      @delineation_result = DelineationResult.new(mean_heart_rate, min_heart_rate, max_heart_rate)

      unless params["ecg_date_time(1i)"].blank?
        @delineation_result.date_and_time_set_up(ecg_date_time_from_params(params))
      end

      render 'index', status: :ok
    else
      render 'index'
    end
  end

  private

  def delineation_params
    params.require(:ecg_csv_file).permit(:ecg_date_time)
  end
end
