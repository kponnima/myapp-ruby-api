require 'rake/testtask'

IMAGE = 'myapp-ruby-api'.freeze
IMAGE_TAG = '0.1'

namespace :myapps-ns do
  task default: %w[test]

  desc 'Build image'
  task :build, [:image_tag] do |_t, args|
    args.with_defaults(image_tag: IMAGE_TAG)
    Rake::Task['docker:build'].invoke(IMAGE, args[:image_tag])
  end

  task :seed do
  end

  task :migrate do
  end

  task :test do
    ruby "test/unittest.rb"
  end
end