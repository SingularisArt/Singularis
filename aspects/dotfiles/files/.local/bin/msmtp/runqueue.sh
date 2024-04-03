#!/usr/bin/env sh

QUEUEDIR=$HOME/.config/msmtp/msmtp.queue
LOCKFILE="$QUEUEDIR/.lock"
MAXWAIT=120

# Extract --msmtp-params and --file from arguments
OPTIONS=$?
MSMTP_PARAMS=""
FILE=""

# Parse args
while [ $# -gt 0 ]; do
  case "$1" in
    --msmtp-params=*)
      MSMTP_PARAMS="${1#--msmtp-params=}"
      ;;
    --file=*)
      FILE="${1#--file=}"
      ;;
    *)
      ;;
  esac
  shift
done

# Append .mail to FILE
FILE="$FILE.mail"

# eat some options that would cause msmtp to return 0 without sendmail mail
case "$MSMTP_PARAMS" in
  *--help*)
    echo "$0: send mails in $QUEUEDIR"
    echo "Options are passed to msmtp"
    exit 0
    ;;
  *--version*)
    echo "$0: unknown version"
    exit 0
    ;;
esac

# wait for a lock that another instance has set
WAIT=0
while [ -e "$LOCKFILE" ] && [ "$WAIT" -lt "$MAXWAIT" ]; do
  sleep 1
  WAIT="$((WAIT + 1))"
done
if [ -e "$LOCKFILE" ]; then
  echo "Cannot use $QUEUEDIR: waited $MAXWAIT seconds for"
  echo "lockfile $LOCKFILE to vanish, giving up."
  echo "If you are sure that no other instance of this script is"
  echo "running, then delete the lock file."
  exit 1
fi

# change into $QUEUEDIR
cd "$QUEUEDIR" || exit 1

# check for empty queuedir
if [ ! -e "$FILE" ]; then
  echo "No file found: $FILE"
  exit 1
fi

# lock the $QUEUEDIR
touch "$LOCKFILE" || exit 1

MSMTPFILE="$(echo "$FILE" | sed -e 's/mail/msmtp/')"
echo "*** Sending $FILE to $(sed -e 's/^.*-- \(.*$\)/\1/' "$MSMTPFILE") ..."
if [ ! -f "$MSMTPFILE" ]; then
  echo "No corresponding file $MSMTPFILE found"
  echo "FAILURE"

  rm -f "$LOCKFILE"
  exit
fi

# Execute msmtp command with specified params
MSMTP_PARAMS="$MSMTP_PARAMS $(cat "$MSMTPFILE")"
msmtp "$MSMTP_PARAMS" < "$FILE"
if [ $OPTIONS -eq 0 ]; then
  rm "$FILE" "$MSMTPFILE"
  echo "$FILE sent successfully"
else
  echo "FAILURE"
fi

# remove the lock
rm -f "$LOCKFILE"

exit 0
