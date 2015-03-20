require 'rubygems'

desc 'Generate and publish site using Travis CI'
task :travis do
  repo = %x(git config remote.origin.url).gsub(/^git:/, 'https:')
  source_branch = 'jekyll'
  deploy_branch = 'master'

  system "git config user.name '#{ENV['GIT_NAME']}'"
  system "git config user.email '#{ENV['GIT_EMAIL']}'"
  system 'git config credential.helper "store --file=.git/credentials"'
  system "git checkout #{source_branch}"

  File.open('.git/credentials', 'w') do |f|
    f.write("https://#{ENV['GH_TOKEN']}:@github.com")
  end

  system 'bundle exec jekyll build'

  system 'rm -rf ../theroyalliar.github.io.master'
  system "git clone https://#{ENV['GH_TOKEN']}@github.com/theroyalliar/theroyalliar.github.io.git ../theroyalliar.github.io.master"
  system 'cp -R _site/* ../theroyalliar.github.io.master'

  system 'cd ../theroyalliar.github.io.master'
  system 'touch .nojekyll'

  system 'git add -A .'
  system "git commit -am 'Travis #{ENV['TRAVIS_BUILD_NUMBER']}'"
  system "git push origin #{deploy_branch}"

  File.delete '.git/credentials'
end
