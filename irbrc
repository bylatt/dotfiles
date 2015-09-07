require 'rubygems'
require 'irb/completion'
require 'awesome_print'
require 'pp'

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

AwesomePrint.irb!
