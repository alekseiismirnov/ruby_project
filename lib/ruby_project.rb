#!/usr/bin/ruby

ROOT_DIRECTORIES = %w{lib spec}

def ruby_project project_name
  Dir.mkdir project_name
  puts 'made dir'
  Dir.chdir project_name
  puts "now we are in #{Dir.pwd}"

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
  
  readme = File.new('READ.me', 'w')
  readme.syswrite("#{project_name.split('_').map(&:capitalize).join(' ')}\n\n")
  readme.close
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
  return $stdin.gets.strip.downcase != 'n'
end

def main
  project_name = ARGV[0]

  puts "Creating place for #{project_name}"
  ruby_project project_name

  while more? 'Wanna add some class? (Y/N)' do
    puts 'Input class name, please'
    class_name = $stdin.gets.strip
    class_files class_name 
  end
end

main if ARGV[0]
