require 'rubygems'
require 'pp'
require 'awesome_print'
require 'irb/completion'

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

def copy(data)
	File.popen('pbcopy', 'w') { |p| p << data.to_s }
	$?.success?
end

AwesomePrint.irb!
