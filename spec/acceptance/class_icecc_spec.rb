require 'spec_helper_acceptance'

describe 'icecc class' do
  context 'default parameters' do
    it 'should work with no errors' do
      pp = <<-EOS
        include ::icecc
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('icecc') do
      it { is_expected.to be_installed }
    end
  end
end
