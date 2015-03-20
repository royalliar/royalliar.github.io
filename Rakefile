require 'rubygems'

desc 'Generate and publish site using Travis CI'
task :travis do
  repo = %x(git config remote.origin.url).gsub(/^git:/, 'https:')
  source_branch = 'jekyll'
  deploy_branch = 'master'

  system "git config user.name '#{ENV['GIT_NAME']}'"
  system "git config user.email '#{ENV['GIT_EMAIL']}'"
  system 'git config credential.helper "store --file=.git/credentials"'

  File.open('.git/credentials', 'w') do |f|
    f.write("https://#{ENV['GH_TOKEN']}:@github.com")
  end

  system './build.sh'

  system "git commit -am 'Travis #{ENV['TRAVIS_BUILD_NUMBER']}'"
  system "git push -q origin #{deploy_branch}"

  File.delete '.git/credentials'
end
