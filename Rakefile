desc 'Generate site from Travis CI and publish site to GitHub Pages'
task :travis do
  repo = %x(git config remote.origin.url).gsub(/^git:/, 'https:')
  source_branch = 'jekyll'
  deploy_branch = 'master'
  sh "git remote set-url --push origin #{repo}"
  sh 'git fetch -q'
  sh "git config user.name '#{ENV['GIT_NAME']}'"
  sh "git config user.email '#{ENV['GIT_EMAIL']}'"
  sh 'git config credential.helper "store --file=.git/credentials"'
  sh "git checkout #{source_branch}"

  File.open('.git/credentials', 'w') do |f|
    f.write("https://#{ENV['GH_TOKEN']}:@github.com")
  end

  sh 'bundle exec jekyll build --trace'
  sh 'git commit -am "Generate Website"'
  sh "git push '_site' #{deploy_branch}"

  File.delete '.git/credentials'
end
