class EcgWave
  attr_accessor :type, :offset, :onset, :tags

  def initialize(wave_type, wave_onset, wave_offset, wave_tags)
    @type = wave_type
    @onset = wave_onset
    @offset = wave_offset
    @tags = wave_tags
  end
end
