require 'rake/testtask'

namespace :test do
  desc 'executes all unit tests'
  Rake::TestTask.new(:unit) do |t|
    t.libs << 'test'
    t.test_files = FileList['test/unit/**/*_test.rb']
    t.verbose = true
    t.options = '-v'
  end

  desc 'executes all integration tests'
  Rake::TestTask.new(:integration) do |t|
    t.libs << 'test'
    t.test_files = FileList['test/integration/**/*_test.rb']
    t.verbose = true
    t.options = '-v'
  end
end

desc 'executes all unit and integration tests'
task :test => %w(test:unit test:integration)