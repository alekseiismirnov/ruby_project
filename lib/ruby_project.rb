#!/usr/bin/ruby

ROOT_DIRECTORIES = %w{lib spec}

def ruby_project project_name
  Dir.mkdir project_name
  Dir.chdir project_name

  ROOT_DIRECTORIES.each do |dirname|
    Dir.mkdir dirname
  end

  gemfile = File.new("Gemfile", "w")
  gemfile.syswrite <<EOF
gem 'rspec'
gem 'pry'
EOF
  gemfile.close

  gitignore = File.new('.gitignore', 'w')
  gitignore.syswrite('*.swp')
  gitignore.close
end

def to_snake camel
  return camel.gsub(/(.)([A-Z])/,'\1_\2').downcase
end

def class_files class_name
  spec = File.new("spec/#{to_snake(class_name)}_spec.rb", 'w')
  spec.syswrite <<EOF
require '#{to_snake(class_name)}'
require 'rspec'

describe #{class_name} do

end

EOF

  source = File.new("lib/#{to_snake(class_name)}.rb", 'w')
  source.syswrite <<EOF
class #{class_name}

end

EOF

end

def more? prompt
  puts prompt
  return gets.strip.downcase != 'n'
end

project_name = ARGV[0]

ruby_project project_name

until more? 'Wanna add some class? (Y/N)' do
  puts 'Input class name, please'
  class_name = gets.strip
  class_files class_name 
end

