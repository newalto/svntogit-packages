this_java='java-8-openjdk/jre'

post_install() {
  xdg-icon-resource forceupdate --theme hicolor 2> /dev/null
  echo "when you use a non-reparenting window manager"
  echo "set _JAVA_AWT_WM_NONREPARENTING=1 in"
  echo "/etc/profile.d/jre.sh"

#  update-desktop-database -q

  default=$(/usr/bin/archlinux-java get)
  if [ -z "${default}" ]; then
    /usr/bin/archlinux-java set ${this_java}
  elif [ "${default/\/jre}" = "${this_java/\/jre}" ]; then
    /usr/bin/archlinux-java fix
  else
    echo "Default Java environment is already set to '${default}'"
    echo "To set '${this_java}' as default, consider using:"
    echo "  archlinux-java set '${this_java}'"
  fi
}

post_upgrade() {
  xdg-icon-resource forceupdate --theme hicolor 2> /dev/null

#  update-desktop-database -q

  default=$(/usr/bin/archlinux-java get)
  if [ -z "${default}" ]; then
    /usr/bin/archlinux-java set ${this_java}
  elif [ "${default/\/jre}" = "${this_java/\/jre}" ]; then
    /usr/bin/archlinux-java fix
  fi
}

post_remove() {
  xdg-icon-resource forceupdate --theme hicolor 2> /dev/null

#  update-desktop-database -q

  default=$(/usr/bin/archlinux-java get)
  if [ "${default/\/jre}" = "${this_java/\/jre}" ]; then
    /usr/bin/archlinux-java fix
  fi
}
