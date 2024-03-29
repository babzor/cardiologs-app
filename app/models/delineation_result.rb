class DelineationResult
  attr_accessor :mean_heart_rate, :min_heart_rate, :max_heart_rate, :recorded_at

  def initialize(mean_heart_rate, min_heart_rate, max_heart_rate, recorded_at: nil)
    @mean_heart_rate = mean_heart_rate
    @min_heart_rate = min_heart_rate
    @max_heart_rate = max_heart_rate
    @recorded_at = recorded_at
  end

  def min_heart_rate_in_bpm
    @min_heart_rate[:heart_rate_in_bpm]
  end

  def min_heart_rate_started_at
    @min_heart_rate[:started_at]
  end

  def max_heart_rate_in_bpm
    @max_heart_rate[:heart_rate_in_bpm]
  end

  def max_heart_rate_started_at
    @max_heart_rate[:started_at]
  end

  def date_and_time_set_up(ecg_date_time)
    @recorded_at = ecg_date_time
    set_up_min_max_heart_rate_started_at
  end

  private

  def set_up_min_max_heart_rate_started_at
    @min_heart_rate[:started_at] = heart_rate_started_at(@min_heart_rate[:onset_started_at])
    @max_heart_rate[:started_at] = heart_rate_started_at(@max_heart_rate[:onset_started_at])
  end

  # Compute the date and time at which the heart beat started by including the onset on the Date and Time of Ecg record
  # @param wave_onset [Integer] time in milliseconds at which the wave started
  # @return [DateTime] the new date and time that takes into account the date and hour when the recording started
  def heart_rate_started_at( wave_onset)
    # Converts the onset in seconds
    onset_in_seconds = wave_onset / 1000

    time = Time.at(onset_in_seconds)
    # Extract hours, minutes, and seconds elapsed from the beginning of the ECG record
    elapsed_hours = time.hour
    elapsed_minutes = time.min
    elapsed_seconds = time.sec

    @recorded_at + elapsed_hours.hours + elapsed_minutes.minutes + elapsed_seconds.seconds
  end
end
