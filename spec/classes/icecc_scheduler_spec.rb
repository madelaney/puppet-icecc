require 'spec_helper'
describe 'icecc' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        context "as a scheduler" do
          context "with firewall on" do
            let(:params) do
              {
                'scheduler' => true,
                'manage_firewall' => true
              }
            end
            it { should contain_firewall('811 Accept ICEcc Scheduler/UDP traffic') }
            it { should contain_firewall('810 Accept ICEcc Scheduler/TCP traffic') }
          end

          context "with firewall off" do
            let(:params) do
              {
                'scheduler' => true
              }
            end
            it { should contain_class('icecc') }
            it { should contain_class('icecc::install').that_comes_before('Class[icecc::configure]') }
            it { should contain_class('icecc::configure') }

            it { should contain_class('icecc::service').that_subscribes_to('Class[icecc::configure]')}

            it { should_not contain_firewall('811 Accept ICEcc Scheduler/UDP traffic') }
            it { should_not contain_firewall('810 Accept ICEcc Scheduler/TCP traffic') }

            it { should contain_package('icecc') }
            it { should contain_service('icecc-scheduler') }
          end
        end
      end
    end
  end
end
