require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      if /freebsd/i =~ host
        on host, 'pkg install -y ruby23-gems'
        on host, 'pkg install -y puppet4'

        # FIXME: mdelaney
        # Beaker has a bug where when :disable_updates is true, and on FreeBSD,
        # the file /etc/hosts is updated to only contain the disabled
        # updated.puppetlabs.com entry
        #
        # on host, 'echo 127.0.0.1\tlocalhost >> /etc/hosts'
      else
        run_puppet_install_helper
      end

      puppet_module_install(source: proj_root, module_name: 'icecc')
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))
    end
  end
end
