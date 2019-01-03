{CompositeDisposable} = require 'atom'

module.exports = MinimapTitles =
  subscriptions: null
  borderOn: false
  preferredLineLength: 0
  activate: (state) ->

    #@borderOn = false
    # Events subscribed to in atom's system can be
    # easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'minimap-titles:convert': => @convert()
    @subscriptions.add atom.commands.add 'atom-workspace', 'minimap-titles:border': => @border()

    # Default font to 'ANSI Shadow' if font not set
    atom.config.set 'atom-minimap-titles.font', 'ANSI Shadow' unless atom.config.get 'atom-minimap-titles.font'
  deactivate: ->
    @subscriptions.dispose()

  border: ->
    @borderOn = not @borderOn

  convert: ->
    if editor = atom.workspace.getActiveTextEditor()

      figlet = require 'figlet'
      font = atom.config.get 'atom-minimap-titles.font'

      # get file extension
      fileName = editor.getTitle()
      extension = fileName.substr(fileName.lastIndexOf('.') + 1, fileName.length)
      if extension == fileName then extension = ''

      # get multi-cursor selections
      selections = editor.getSelections()
      @preferredLineLength = atom.config.get('editor.preferredLineLength')
      for selection in selections
        do (selection, @borderOn, @preferredLineLength) ->
          if selection.isEmpty()
            # auto select word
            selection.selectLine()
            if selection.isEmpty() then return

          figlet selection.getText().trim(), { font: font }, ( error, art ) ->
            if error
              console.error error

            else
              ###
              remove font shadow (or minimap won't display it properly)
              - find unicode chars here: http://unicodelookup.com/#%E2%95%9D/1
              - convert hex (ie 0x255D) to unicode (ie \u255D)
              ###
              art = art.replace /[\u2550-\u255D]/g, " "

              # delete empty lines & tailing spaces
              art = art.replace /\s+$/gm, ""

              switch extension
                when 'bash','sh','yml','yaml','py',''
                  if not @borderOn
                    preferredLineLength = 0
                  # add '# ' to the beginning of each line
                  commentStart = Array(preferredLineLength).join('#') + '\n'
                  art = art.replace /^/, "# "
                  art = art.replace /\n/g, "\n# "
                  commentEnd = '\n' + Array(preferredLineLength).join('#') + '\n'

                when 'coffee', 'cjsx', 'cson'
                  if not @borderOn
                    preferredLineLength = 0
                  commentStart = Array(preferredLineLength).join('#') + '\n'
                  art = art.replace /^/, "# "
                  art = art.replace /\n/g, "\n# "
                  commentEnd = '\n' + Array(preferredLineLength).join('#') + '\n'

                when 'html','md'
                  if not @borderOn
                    preferredLineLength = 6
                  commentStart = '<!--' + Array(preferredLineLength-6).join('#') + '\n'
                  commentEnd = '\n' + Array(preferredLineLength-5).join('#') + '-->'

                when 'njk'
                  if not @borderOn
                    preferredLineLength = 6
                  commentStart = '{#' + Array(preferredLineLength-6).join('#') + '\n'
                  commentEnd = '\n' + Array(preferredLineLength-5).join('#') + '#}'

                when 'php'
                  if not @borderOn
                    preferredLineLength = 3
                  commentStart = '/**' + Array(preferredLineLength-3).join('*') + '\n
                  \t * Block comment\n
                  \t *\n
                  \t * @param type\n
                  \t * @return void\n'
                  commentEnd = '\n' + Array(preferredLineLength-2).join('*') + '*/\n\t'

                when 'vb','vbs'
                  commentStart = ''
                  commentEnd = ''
                  # add '' ' to the beginning of each line
                  art = art.replace /^/, "' "
                  art = art.replace /\n/g, "\n' "

                when 'tex','cls'
                  commentStart = ''
                  commentEnd = ''
                  # add '% ' to the beginning of each line
                  art = art.replace /^/, "% "
                  art = art.replace /\n/g, "\n% "

                when 'sql'
                  commentStart = ''
                  commentEnd = ''
                  # add '-- ' to the beginning of each line
                  art = art.replace /^/, "-- "
                  art = art.replace /\n/g, "\n-- "

                when 'sass','scss'
                  commentStart = ''
                  commentEnd = ''
                  # add '// ' to the beginning of each line
                  art = art.replace /^/, "// "
                  art = art.replace /\n/g, "\n// "

                else
                  if not @borderOn
                    preferredLineLength = 2
                  commentStart = '/*' + Array(preferredLineLength-2).join('*') + '\n'
                  commentEnd = '\n' + Array(preferredLineLength-2).join('*') + '*/\n'

              selection.insertText(
                "#{commentStart+art+commentEnd}\n",
                {
                  select: true,
                  autoIndent: true
                  autoIndentNewline: true
                }
              )
