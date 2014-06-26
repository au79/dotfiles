export SCION_SVN=http://depot.sf.dhapdigital.com/repos/TMS/scion
export SCION_SVN_DHAP=${SCION_SVN}/branches/DHAP
export SCION_SVN_TRUNK=${SCION_SVN}/trunk
export SCION_SVN_ARCHIVE=${SCION_SVN}/branches/DHAP/Archive
export SCION_SVN_QA=${SCION_SVN}/branches/DHAP/QA

scion_create_branch_from_trunk () {
    if [ -z "$1" ]
    then
        echo "Usage: scion_create_branch_from_trunk {branch-name} [commit-message]" >&2
        echo "       The default commit-message is "'"'"Branching for {branch-name}"'"'" since it is usually a JIRA ticket ID."
        return 1
    fi

    local branch_name="$1"
    shift

    local message="Branching for ${branch_name}"

    if [ ! -z "$1" ]
    then
        message="$*"
    fi

    svn copy ${SCION_SVN_TRUNK} "${SCION_SVN_DHAP}/${branch_name}" -m "${message}"
}

