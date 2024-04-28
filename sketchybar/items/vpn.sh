
#!/bin/bash

sketchybar --add item vpn right \
           --set vpn  update_freq=2 \
                      icon.font="SF Pro:Semibold:18.0" \
                      icon=􁅏  \
                      script="$PLUGIN_DIR/vpn.sh" \
                      icon.padding_left=12                  \
                     icon.padding_right=0
