#!/usr/bin/ruby

feature_branch = ARGV[0]
release_branch = ARGV[0]
message = ARGV[1]

puts "Release branch #{release_branch}"

# 1. Merge Release Branch
system( "git checkout master" )
system( "git merge #{release_branch}" )



system( "git add ." )
system( "git commit -m 'increment version # to #{new_version}'" )
system( "git push origin dev" )

# 3. Create a release branch and push to origin
release_branch = "release/v#{new_version}"
puts "Create release branch: #{release_branch}"
system(" git checkout -b #{release_branch}" )
system(" git push origin #{release_branch}" )



BEGIN {
def increment_version
  version_string = File.open("version", "rb").read
  version_string = version_string.strip
  puts "old version: #{version_string}"
  version_components = version_string.split(".")
  puts version_components[0]
  new_middle_digit = version_components[1].to_i + 1
  puts "old middle digit #{version_components[1]}"
  puts "new middle digit #{new_middle_digit}"
  puts version_components[2]
  new_version = "#{version_components[0]}.#{new_middle_digit}.#{version_components[2]}"
  puts "new version: #{new_version}"
  File.write('version', new_version)
  new_version
end
}
