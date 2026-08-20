#!/bin/zsh
# ==============================================================================
# OneDrive Keep Alive for macOS
# 
# Author:      The Senior Geek (https://youtube.com/@TheSeniorGeek)
# Repository:  https://github.com/TheSeniorGeek/onedrive-keep-alive
# License:     MIT License
# Description: Monitors the Microsoft OneDrive process on macOS and automatically
#              restarts it if it terminates unexpectedly.
# ==============================================================================

# ------------------------------------------------------------
# OneDrive Keep Alive (Interactive .command Script)
# ------------------------------------------------------------

SCRIPT_NAME="${0:t}"
SCRIPT_VERSION="1.0"

# 1. Prevent duplicate instances from running
RUNNING_INSTANCES=$(pgrep -f "$SCRIPT_NAME" | grep -v "$$")
if [[ -n "$RUNNING_INSTANCES" ]]; then
    echo "OneDrive Keep Alive ($SCRIPT_NAME) is already running in another window."
    exit 0
fi

START_EPOCH=$(date +%s)
END_EPOCH=$(( START_EPOCH + (8 * 3600) ))

START_TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
END_TIMESTAMP=$(date -r "$END_EPOCH" '+%Y-%m-%d %H:%M:%S')

echo "============================================================"
echo " OneDrive Keep Alive Version: $SCRIPT_VERSION" 
echo " Script Started: $START_TIMESTAMP"
echo " Process ID: $$"
echo " Scheduled Auto-Exit:       $END_TIMESTAMP (8-Hour Limit)"
echo " Press [Ctrl + C] in this window at any time to stop."
echo "============================================================"
echo ""

RESTART_COUNT=0
LAST_RESTART_TIME=$START_EPOCH

# Ensure OneDrive is running on initial launch
if ! pgrep -x "OneDrive" > /dev/null; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] OneDrive is not running. Launching now..."
    open -a "OneDrive"
fi

# ------------------------------------------------------------
# Main Monitoring Loop
# ------------------------------------------------------------

while true; do

    CURRENT_EPOCH=$(date +%s)

    # 1. Exit automatically after 8 hours
    if (( CURRENT_EPOCH >= END_EPOCH )); then
        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        echo ""
        echo "============================================================"
        echo "[$TIMESTAMP] 8-hour monitoring period completed."
        echo "Script is shutting down."
        echo "============================================================"
        exit 0
    fi

    # 2. Check OneDrive process health
    if ! pgrep -x "OneDrive" > /dev/null; then

        # 60-second cooldown to let background locks clear and avoid thrashing
        sleep 60

        if ! pgrep -x "OneDrive" > /dev/null; then
            ((RESTART_COUNT++))

            NOW_EPOCH=$(date +%s)
            TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

            # Calculate active runtime (subtracting the 60s cooldown)
            ELAPSED=$(( NOW_EPOCH - LAST_RESTART_TIME - 60 ))
            (( ELAPSED < 0 )) && ELAPSED=0

            HOURS=$(( ELAPSED / 3600 ))
            MINS=$(( (ELAPSED % 3600) / 60 ))
            SECS=$(( ELAPSED % 60 ))
            DIFF_STR=" (Ran for ${HOURS}h ${MINS}m ${SECS}s)"

            LAST_RESTART_TIME=$NOW_EPOCH

            # Relaunch OneDrive
            open -a "OneDrive"

            echo "[$TIMESTAMP] OneDrive restarted (Sequence #$RESTART_COUNT)$DIFF_STR"
        fi
    fi

    sleep 5
done