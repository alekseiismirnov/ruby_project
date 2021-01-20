require 'ruby_project'
require 'rspec'

describe 'class_files' do
  before(:context) do
    Dir.chdir '/tmp'
    ruby_project 'test_project'
    class_files 'TestClass'
  end

  after(:context) do
    Dir.chdir '/tmp'
    FileUtils.rm_r 'test_project'
  end

  it 'makes spec file for this class' do
    expect(File::exist? 'spec/test_class_spec.rb').to eq(true)
  end

  it 'makes source file for this class' do
    expect(File::exist? 'lib/test_class.rb').to eq(true)
  end

end

