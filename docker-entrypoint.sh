#!/bin/bash
# exit on error
set -e
#
# ----- find the uid and gid of the current dir
# ----- which the dockerfile set to the mounted vol
#
new_uid=$(stat -c "%u" .)
new_gid=$(stat -c "%g" .)
echo "switching dev:dev from $(id dev) to uid=$new_uid gid=$new_gid groups=$new_gid"
#
# ----- switch dev:dev to the new uid:gid
# ----- but if the new gid is already taken, just
# ----- switch the user to the group with that gid
#
usermod -u $new_uid dev
group_exists=`grep :$new_gid: /etc/group | wc -l`
if [ "$group_exists" = "0" ]; then
    groupmod -g $new_gid dev
else
    usermod -g $new_gid dev
fi
echo "dev now $(id dev)"
#
# ----- run the supplied command as the modified dev user
#
echo "exec sudo -u dev '$@'"
exec sudo -u dev "$@"
