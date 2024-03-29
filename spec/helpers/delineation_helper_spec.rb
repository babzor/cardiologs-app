require 'rails_helper'

RSpec.describe DelineationHelper, type: :helper do
  let(:ecg_wave_1) { EcgWave.new("P", 836, 924, ["ectopic"]) }
  let(:ecg_wave_2) { EcgWave.new("QRS", 964, 1055, []) }
  let(:ecg_wave_3) { EcgWave.new("T", 1055, 1339, []) }
  let(:ecg_wave_4) { EcgWave.new("P", 2033, 2145, []) }
  let(:ecg_wave_5) { EcgWave.new("QRS", 2181, 2270, ["premature", "junctional"]) }
  let(:ecg_wave_6) { EcgWave.new("T", 2270, 2564, []) }

  let(:ecg_waves) { [ecg_wave_1, ecg_wave_2, ecg_wave_3, ecg_wave_4, ecg_wave_5, ecg_wave_6] }

  describe "#extract_data_from_csv" do
    let(:file_path) { "tmp/test.csv" }
    subject { helper.extract_data_from_csv(file_path)}

    context "functionality" do
      it 'returns an array of ecg_waves' do
        expect(subject.size).to eq(ecg_waves.size)
        expect(subject.class).to eq(Array)
        expect(subject.first.type).to eq("P")
        expect(subject.last.type).to eq("T")
      end
    end
  end

  describe "#mean_heart_rate" do
    subject { helper.mean_heart_rate(ecg_waves)}
    let(:expected_mean_heart_rate){69}

    context "functionality" do
      it "returns the mean heart rate of the recording" do
        expect(subject).to eq(expected_mean_heart_rate)
      end
    end
  end

  #TODO: test the other methods
end
