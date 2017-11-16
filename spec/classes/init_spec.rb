require 'spec_helper'
describe 'icecc' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
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
        it { should contain_class('icecc::install').that_comes_before('Class[icecc::configure]') }
        it { should contain_class('icecc::configure') }

        it { should contain_service('iceccd') }
        it { should contain_service('iceccd').that_subscribes_to('File[/etc/icecc/icecc.conf]') }

        it { should contain_file('/etc/icecc/icecc.conf') }
      end
    end
  end
end
