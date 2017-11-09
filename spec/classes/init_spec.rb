require 'spec_helper'
describe 'icecc' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "firewall off" do
        let(:params) do
          {
            'manage_firewall' => false
          }
        end

        it { should_not contain_firewall('800 Allow ICEcc/TCP Daemon') }
      end

      context "firewall on" do
        let(:params) do
          {
            'manage_firewall' => true
          }
        end

        it { should contain_firewall('800 Allow ICEcc/TCP Daemon') }
      end

      it { should contain_class('icecc') }
    end
  end
end
