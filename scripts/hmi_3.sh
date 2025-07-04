#!/bin/bash

# List of 9 hosts to ping
# uav6_vpn:  192.168.194.170 || 192.168.192.170
# uav7_vpn:  192.168.194.188 || 192.168.192.188
# uav8_vpn:  192.168.194.254 || 192.168.192.254
# uav9_vpn:  192.168.194.228 || 192.168.192.228
# uav10_vpn: 192.168.194.190 ||  192.168.192.190
# uav11_vpn: 192.168.194.160 ||  192.168.192.160
# uav12_vpn: 192.168.194.137 ||  192.168.192.137
# uav13_vpn: 192.168.194.144 ||  192.168.192.144
# uav14_vpn: 192.168.194.203 ||  192.168.192.203

# List of 3 hosts to ping
hosts=(
    192.168.192.137
    192.168.192.144
    192.168.192.203
)

# List of 3 users to ping
users=(
    uav12_vpn
    uav13_vpn
    uav14_vpn
)

# Create a new tmux session named "ping"
tmux new-session -s ping -d

# First row
tmux send-keys "ssh ${users[0]}" C-m
tmux split-window -h
tmux send-keys "ssh ${users[2]}" C-m
tmux split-window -h
tmux send-keys "./color_ping.sh ${hosts[2]}" C-m

# Second row
tmux select-pane -t 0
tmux split-window -v
tmux send-keys "./color_ping.sh ${hosts[0]}" C-m
tmux select-pane -t 1
tmux split-window -v
tmux send-keys "ssh ${users[1]}" C-m
tmux select-pane -t 2
tmux split-window -v
tmux send-keys "./color_ping.sh ${hosts[1]}" C-m

# Arrange layout and attach
tmux select-layout tiled
tmux attach-session -t ping
