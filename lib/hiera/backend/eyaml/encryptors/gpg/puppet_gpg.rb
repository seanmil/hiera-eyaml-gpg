require 'puppet/util/execution'
require 'puppet/file_system/uniquefile'

class Hiera
module Backend
module Eyaml
module Encryptors
class Gpg
class PuppetGpg
  include RubyGpg

  def run_command(command, input = nil)
    Puppet::FileSystem::Uniquefile.new('puppet-gpg-input') do |stdinfile|
      puts stdinfile input

      output = Puppet::Util::Execution.execute(command, stdinfile: stdinfile.path)
      stdinfile.unlink

      if output.exitstatus != 0
        raise "GPG command (#{command.join(' ')}) failed with: #{output}"
      end
      output
    end
  end
end
end
end
end
end
end
