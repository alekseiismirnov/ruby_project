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

