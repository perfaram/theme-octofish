function fish_greeting -d 'Write out the greeting'
  if [ "$theme_display_disclaimer" = 'yes' ]
    echo 'Unauthorized access or use of this computer system may subject violators to criminal, civil and/or administrative action.'
  end
  if [ "$theme_display_zen" = 'yes' ]
    curl https://api.github.com/zen
  end
  set USERFULL (finger (id -un) | head -1 | cut -d: -f3-)
  set UPTIME (uptime | awk '{sub(/[0-9]|user\,|users\,|load/, "", $6); sub(/mins,|min,/, "min", $6); sub(/user\,|users\,/, "", $5); sub(",", "min", $5); sub(":", "h ", $5); sub(/[0-9]/, "", $4); sub(/day,/, " day", $4); sub(/days,/, " days", $4); sub(/mins,|min,/, "min", $4); sub("hrs,", "h", $4); sub(":", "h ", $3); sub(",", "min", $3); print $3$4}')
  set EXTIP (curl -s ipecho.net/plain ; echo)
  set fish_color_user "ff5f00"
  echo -n 'Howdy,' & set_color $fish_color_user & echo -n "$USERFULL" & set_color $fish_color_normal & echo ' !'
  echo 'System up since '"$UPTIME"', accessible on IP '"$EXTIP"
end
