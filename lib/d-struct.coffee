# Grab a few objects that we'll need
popen = require('child_process').exec
platform = require('os').platform

commands =
    build:
        win32: -> "start cmd /k \"cd #{atom.project.getPaths().shift()} && dub build\""
        darwin: -> "osascript -e \'tell application \"Terminal\" to do script \"cd #{atom.project.getPaths().shift()}; dub build\"\'"
        linux: -> "xterm -e \"bash -c \'cd #{atom.project.getPaths().shift()}; dub build; echo $?; read -s -n 1 line\'\""
    run:
        win32: -> "start cmd /k \"cd \"#{atom.project.getPaths().shift()}\" && dub run\""
        darwin: -> "osascript -e \'tell application \"Terminal\" to do script \"cd #{atom.project.getPaths().shift()}; dub run\"\'"
        linux: -> "xterm -e \"bash -c \'cd #{atom.project.getPaths().shift()}; dub run; echo $?; read -s -n 1 line\'\""

# Open a terminal and run dub
dub_build = ->
  # Run the terminal app
  popen commands.build[platform()]() if platform() of commands.build

# Open a terminal and run the app with dub
dub_run = ->
  # Run the terminal app
  popen commands.run[platform()]() if platform() of commands.run

module.exports =
  # Bind workspace command to run_dub
  activate: (state) ->
    atom.commands.add "atom-workspace", "d-struct:dub-build", => @dubbuild()
    atom.commands.add "atom-workspace", "d-struct:dub-run", => @dubrun()
  dubbuild: ->
    dub_build()
  dubrun: ->
    dub_run()
