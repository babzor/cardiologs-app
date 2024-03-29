module DelineationHelper
  require 'csv'

  # Read the ECG .csv file to extract the waves data: type, onset, offset and tags (optional)
  # @param file_path [String] the path of the csv file
  # @return ecg_waves [Array<EcgWave>] an array of all the ecg waves
  def extract_data_from_csv(file_path)
    ecg_waves = []

    CSV.foreach(file_path, headers: false) do |row|
      wave_type = row[0]
      wave_onset = row[1].to_i
      wave_offset = row[2].to_i
      wave_tags = row[3..-1].reject(&:nil?).map(&:strip)

      ecg_wave = EcgWave.new(wave_type, wave_onset, wave_offset, wave_tags)
      ecg_waves << ecg_wave
    end

    ecg_waves
  end

  # Extract date and time from params of delineation post request
  # @param params [ActionController::Parameters]
  # @return [DateTime]
  def ecg_date_time_from_params(params)
    DateTime.new(
      params["ecg_date_time(1i)"].to_i,  # year
      params["ecg_date_time(2i)"].to_i,  # month
      params["ecg_date_time(3i)"].to_i,  # day
      params["ecg_date_time(4i)"].to_s.gsub(/^0/, '').to_i,  # hour
      params["ecg_date_time(5i)"].to_s.gsub(/^0/, '').to_i   # minute
    )
  end

  # Compute the mean heart rate of a ECG recording (Frequency at which QRS complexes appear)
  # @param ecg_waves [Array<EcgWave>]
  # @return frequency [Integer]
  def mean_heart_rate(ecg_waves)
    qrs_waves_count = ecg_waves.count { |wave| wave.type == 'QRS'}.to_f
    ecg_duration_in_milliseconds = ecg_waves_end(ecg_waves) - ecg_waves_start(ecg_waves)
    ecg_duration_in_minutes = ecg_duration_in_milliseconds.to_f / 60000 #to bpm
    frequency = qrs_waves_count.to_f / ecg_duration_in_minutes
    frequency.round
  end

  # Compute the min and max heart rate of a ECG recording
  # @param ecg_waves [Array<EcgWave>]
  def min_max_heart_rate(ecg_waves)
    qrs_waves = ecg_waves.select { |wave| wave.type == 'QRS'}
    heart_rates_data = []

    prev_wave_onset = qrs_waves.first.onset
    qrs_waves.each do |current_wave|
      if current_wave == qrs_waves.first
        next
      end

      interval_in_milliseconds = current_wave.onset - prev_wave_onset
      heart_rates_data << {
        interval_in_milliseconds: interval_in_milliseconds,
        heart_rate_in_bpm: (60 / (interval_in_milliseconds.to_f/1000)).round,
        onset_started_at: prev_wave_onset
      }

      prev_wave_onset = current_wave.onset
    end

    min_heart_rate_data = heart_rates_data.min_by { |heart_rate| heart_rate[:heart_rate_in_bpm] }
    max_heart_rate_data = heart_rates_data.max_by { |heart_rate| heart_rate[:heart_rate_in_bpm] }

    [min_heart_rate_data, max_heart_rate_data]
  end

  private

  def ecg_waves_start(ecg_waves)
    ecg_waves.first.onset
  end

  def ecg_waves_end(ecg_waves)
    ecg_waves.last.offset
  end
end

