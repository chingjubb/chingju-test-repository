#!/usr/bin/ruby

if ARGV.length != 2
  print_usage
  exit
end

release_branch = ARGV[0]
message = ARGV[1]

if (release_branch == nil || release_branch.empty?)
  print_usage
  exit
end

if (message == nil || message.empty?)
  print_usage
  exit
end

release_branch = release_branch.strip
message = message.strip

puts "Release branch #{release_branch}"

# 1. Merge release branch to master, and push to origin
puts "Merging release branch #{release_branch} to master"
system( "git checkout master" )
system( "git merge #{release_branch} -m 'Merge #{release_branch}' " )
system( "git push origin master" )

# 2. Add Tag to master
puts "Add Tag to master"
version = File.open("version", "rb").read.strip
tag = "Version #{version}, #{message}"
system( "git tag -a v#{version} -m '#{tag}'" )
system( "git push --tags" )


# 3. Merge release branch to Dev
puts "Merging release branch to Dev"
system( "git checkout dev" )
system( "git merge  #{release_branch} -m 'Merge #{release_branch} to dev' " )
system( "git push origin dev" )

# 4. Back to master
system( "git checkout master" )

BEGIN{
def print_usage
  puts "Please put release branch in argument 1"
  puts "Please put message in argument 2"
  puts 'Usage: ruby ./release_addition.rb release/v1.0.0 "Blah Blah Blah...."'
end
}
