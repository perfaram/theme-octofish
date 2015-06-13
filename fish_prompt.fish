# name: octofish
#
# octofish is a Powerline-style, Git-aware fish theme optimized for awesome.
#
# You will probably need a Powerline-patched font for this to work:
#
#     https://powerline.readthedocs.org/en/latest/fontpatching.html
#
# I recommend picking one of these:
#
#     https://github.com/Lokaltog/powerline-fonts
#
# You can override some default options in your config.fish:
#
#     set -g theme_display_git yes
#     set -g theme_display_virtualenv no
#     set -g theme_display_ruby no
#     set -g theme_display_padlock yes
set -g __octofish_current_bg NONE

# Powerline glyphs
set __octofish_branch_glyph            \uE0A0
set __octofish_ln_glyph                \uE0A1
set __octofish_padlock_glyph           \uE0A2
set __octofish_right_black_arrow_glyph \uE0B0
set __octofish_right_arrow_glyph       \uE0B1
set __octofish_left_black_arrow_glyph  \uE0B2
set __octofish_left_arrow_glyph        \uE0B3
set __octofish_lock_glyph              \uE0A2

# Additional glyphs
set __octofish_detached_glyph          \u27A6
set __octofish_nonzero_exit_glyph      '✘ '
set __octofish_superuser_glyph         '# '
set __octofish_user_glyph              '$ '
set __octofish_bg_job_glyph            '⚙ '
set __octofish_hg_glyph                \u263F

# Python glyphs
set __octofish_superscript_glyph       \u00B9 \u00B2 \u00B3
set __octofish_virtualenv_glyph        \u25F0
set __octofish_pypy_glyph              \u1D56

# Colors
set __octofish_lt_green   addc10
set __octofish_med_green  189303
set __octofish_dk_green   0c4801

set __octofish_lt_red     C99
set __octofish_med_red    ce000f
set __octofish_dk_red     600
set __octofish_ruby_red   af0000

set __octofish_slate_blue 255e87
set __octofish_med_blue   005faf

set __octofish_lt_orange  f6b117
set __octofish_dk_orange  3a2a03

set __octofish_dk_grey    333
set __octofish_med_grey   999
set __octofish_lt_grey    ccc

set __octofish_pure_white fff

set __octofish_dk_brown   4d2600
set __octofish_med_brown  803F00
set __octofish_lt_brown   BF5E00


# ===========================
# Helper methods
# ===========================

function __octofish_pretty_parent -d 'Print a parent directory, shortened to fit the prompt'
  echo -n (dirname $argv[1]) | sed -e 's#/private##' -e "s#^$HOME#~#" -e 's#/\(\.\{0,1\}[^/]\)\([^/]*\)#/\1#g' -e 's#/$##'
end

function __octofish_project_pwd -d 'Print the working directory relative to project root'
  echo "$PWD" | sed -e "s#$argv[1]##g" -e 's#^/##'
end


# ===========================
# Segment functions
# ===========================

function __octofish_start_segment -d 'Start a prompt segment'
  set -l bg $argv[1]
  set -e argv[1]
  set -l fg $argv[1]
  set -e argv[1]

  set_color normal # clear out anything bold or underline...
  set_color -b $bg
  set_color $fg $argv
  if [ "$__octofish_current_bg" = 'NONE' ]
    # If there's no background, just start one
    echo -n ' '
  else
    # If there's already a background...
    if [ "$bg" = "$__octofish_current_bg" ]
      # and it's the same color, draw a separator
      echo -n "$__octofish_right_arrow_glyph "
    else
      # otherwise, draw the end of the previous segment and the start of the next
      set_color $__octofish_current_bg
      echo -n "$__octofish_right_black_arrow_glyph "
      set_color $fg $argv
    end
  end
  set __octofish_current_bg $bg
end

function __octofish_segment_path -d 'Display a shortened form of a directory'
  if [ -w "$argv[1]" ]
    __octofish_start_segment $__octofish_dk_grey $__octofish_med_grey
  else
    __octofish_start_segment $__octofish_dk_red $__octofish_lt_red
  end

  set -l directory
  set -l parent

  switch "$argv[1]"
    case /
      set directory '/'
    case "$HOME"
      set directory '~'
    case '*'
      set parent    (__octofish_pretty_parent "$argv[1]")
      set parent    "$parent/"
      set directory (basename "$argv[1]")
  end

  [ "$parent" ]; and echo -n -s "$parent"
  set_color fff --bold
  echo -n "$directory "
  set_color normal
end

function __octofish_finish_segments -d 'Close open prompt segments'
  if [ -n $__octofish_current_bg -a $__octofish_current_bg != 'NONE' ]
    set_color -b normal
    set_color $__octofish_current_bg
    echo -n "$__octofish_right_black_arrow_glyph "
    set_color normal
  end
  set -g __octofish_current_bg NONE
end

function __octofish_start_segment_reverse -d 'Start a prompt segment, right to left'
  set -l bg $argv[1]
  set -e argv[1]
  set -l fg $argv[1]
  set -e argv[1]

  set_color normal # clear out anything bold or underline...
  set_color -b $bg
  set_color $fg $argv
  if [ "$__octofish_current_bg" = 'NONE' ]
    # If there's no background, just start one
    echo -n ' '
  else
    # If there's already a background...
    if [ "$bg" = "$__octofish_current_bg" ]
      # and it's the same color, draw a separator
      echo -n "$__octofish_left_arrow_glyph "
    else
      # otherwise, draw the end of the previous segment and the start of the next
      set_color $__octofish_current_bg
      echo -n "$__octofish_left_black_arrow_glyph "
      set_color $fg $argv
    end
  end
  set __octofish_current_bg $bg
end

function __octofish_finish_segments_reverse -d 'Close open prompt segments'
  if [ -n $__octofish_current_bg -a $__octofish_current_bg != 'NONE' ]
    set_color -b normal
    set_color $__octofish_current_bg
    echo -n "$__octofish_left_black_arrow_glyph "
    set_color normal
  end
  set -g __octofish_current_bg NONE
end


# ===========================
# Theme components
# ===========================

function __octofish_prompt_user -d 'Display actual user'
  if [ "$theme_display_user" = 'yes' ]
      __octofish_start_segment $__octofish_lt_grey $__octofish_slate_blue
      echo -n -s (whoami) '@' (hostname | cut -d . -f 1) ' '
  end
end

function __octofish_prompt_dir -d 'Display a shortened form of the current directory'
  __octofish_segment_path "$PWD"
end

function __octofish_virtualenv_python_version -d 'Get current python version'
  set -l python_version (readlink (which python))
  switch "$python_version"
    case 'python2*'
      echo $__octofish_superscript_glyph[2]
    case 'python3*'
      echo $__octofish_superscript_glyph[3]
    case 'pypy*'
      echo $__octofish_pypy_glyph
  end
end

function __octofish_prompt_virtualfish -d "Display activated virtual environment (only for virtualfish, virtualenv's activate.fish changes prompt by itself)"
  [ "$theme_display_virtualenv" = 'no' -o -z "$VIRTUAL_ENV" ]; and return
  set -l version_glyph (__octofish_virtualenv_python_version)
  if [ "$version_glyph" ]
    __octofish_start_segment $__octofish_med_blue $__octofish_lt_grey
    echo -n -s $__octofish_virtualenv_glyph $version_glyph
  end
  __octofish_start_segment $__octofish_med_blue $__octofish_lt_grey --bold
  echo -n -s (basename "$VIRTUAL_ENV") ' '
  set_color normal
end

function __octofish_prompt_rubies -d 'Display current Ruby (rvm/rbenv)'
  [ "$theme_display_ruby" = 'no' ]; and return
  set -l ruby_version
  if type rvm-prompt >/dev/null 2>&1
    set ruby_version (rvm-prompt i v g)
  else if type rbenv >/dev/null 2>&1
    set ruby_version (rbenv version-name)
    # Don't show global ruby version...
    [ "$ruby_version" = (rbenv global) ]; and return
  end
  [ -z "$ruby_version" ]; and return

  __octofish_start_segment $__octofish_ruby_red $__octofish_lt_grey --bold
  echo -n -s $ruby_version ' '
  set_color normal
end

function __octofish_segment_userglyph
  set -l superuser
  set -l uid (id -u $USER)
  if [ $uid -eq 0 ]
    #set userglyph $__octofish_superuser_glyph
    __octofish_start_segment $__octofish_pure_white $__octofish_med_red -o
    echo -n -s $__octofish_superuser_glyph
  else
    __octofish_start_segment $__octofish_pure_white $__octofish_med_green -o
    echo -n -s $__octofish_user_glyph
  end
end

function __octofish_segment_user
  __octofish_start_segment $__octofish_lt_grey $__octofish_slate_blue
  echo -n -s (whoami) '@' (hostname | cut -d . -f 1) ' '
end

function __octofish_segment_path
  if [ -w "$argv[1]" ]
    __octofish_start_segment $__octofish_dk_grey $__octofish_med_grey
  else
    if [ "$theme_display_padlock" = 'no' ]
      __octofish_start_segment $__octofish_dk_red $__octofish_lt_red
    else
      __octofish_start_segment $__octofish_dk_grey $__octofish_med_grey
    end
  end

  set -l directory
  set -l parent

  switch "$argv[1]"
    case /
      set directory '/'
    case "$HOME"
      set directory '~'
    case '*'
      set parent    (__octofish_pretty_parent "$argv[1]")
      set parent    "$parent/"
      set directory (basename "$argv[1]")
  end

  [ "$parent" ]; and echo -n -s "$parent"
  set_color fff --bold
  echo -n "$directory "
  set_color normal
end

function __octofish_segment_lockwrite
  [ "$theme_display_padlock" = 'no' ]; and return
  if not test -w .
    __octofish_start_segment $__octofish_dk_red $__octofish_lt_red
    echo -n "$__octofish_padlock_glyph "
  end
end

function __octofish_segment_status
  set -l nonzero
  set -l bg_jobs

  # Last exit was nonzero
  if [ $RETVAL -ne 0 ]
    set nonzero $__octofish_nonzero_exit_glyph
  end

  # Jobs display
  if [ (jobs -l | wc -l) -gt 0 ]
    set bg_jobs $__octofish_bg_job_glyph
  end

  set -l status_flags "$nonzero$bg_jobs"

  if [ "$nonzero" -o "$bg_jobs" ]
    __octofish_start_segment fff 000
    if [ "$nonzero" ]
      set_color $__octofish_med_red --bold
      echo -n $__octofish_nonzero_exit_glyph
    end

    if [ "$bg_jobs" ]
      set_color $__octofish_slate_blue --bold
      echo -n $__octofish_bg_job_glyph
    end
    set_color normal
  end
end

# ===========================
# Apply theme
# ===========================

function fish_prompt
  set -g RETVAL $status
  __octofish_segment_userglyph
  __octofish_segment_user
  __octofish_prompt_rubies
  __octofish_prompt_virtualfish
  __octofish_segment_path "$PWD"
  __octofish_segment_lockwrite
  __octofish_segment_status
  
  __octofish_finish_segments
end
