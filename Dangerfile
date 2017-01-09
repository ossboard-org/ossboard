# rubocop:disable all
# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
if github.pr_title.include?("[WIP]") || github.pr_title.include?("[wip]") || github.pr_labels =~ /work in progress/
  warn("PR is classed as Work in Progress")
end

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 400

# Mainly to encourage writing up some reasoning about the PR
if github.pr_body.length < 5
  fail "Please provide a summary in the Pull Request description"
end

# We don't need any debugging code in our codebase
fail "Debugging code found - binding.pry"     if `grep -r "binding.pry"       lib/ apps/ spec/`.length > 1
fail "Debugging code found - debugger"        if `grep -r "debugger"          lib/ apps/ spec/`.length > 1
fail "Debugging code found - console.log"     if `grep -r "console.log"       lib/ apps/ spec/`.length > 1
fail "Debugging code found - require 'debug'" if `grep -r "require \'debug\'" lib/ apps/ spec/`.length > 1

# Look for GIT merge conflicts
if `grep -r ">>>>\|=======\|<<<<<<<" apps spec lib`.length > 1
 fail "Merge conflicts found"
end

warn("You've added no specs for this change. Are you sure about this?") if git.modified_files.grep(/\.rb\z/) && git.modified_files.grep(/spec/).empty?

simplecov.report "coverage/coverage.json"
