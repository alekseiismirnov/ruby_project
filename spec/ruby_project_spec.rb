require 'ruby_project'
require 'rspec'

describe 'ruby_project' do
  before(:context) do
    Dir.chdir '/tmp'
    ruby_project 'test_project'
  end

  after(:context) do
    Dir.chdir '/tmp'
    FileUtils.rm_r 'test_project'
  end

  it 'assures that `project_name` directory exists' do
    expect(File.basename Dir.pwd).to eq('test_project')
  end

  it 'makes `lib` and `spec` directories' do
    expect(Dir::exist? 'lib').to eq(true)
    expect(Dir::exist? 'spec').to eq(true)
  end

  it 'creates Gemfile' do
    expect(File::exist? 'Gemfile').to eq(true)
  end

  it 'creates .gitignore' do
    expect(File::exist? '.gitignore').to eq(true)
  end
end

