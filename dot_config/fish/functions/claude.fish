function claude --description 'claude, resuming a session under the clauth profile that last ran it'
    # herdr restores panes with a bare `claude --resume <id>`; route it to the right profile
    if not set -q CLAUDE_CONFIG_DIR
        set -l id
        for i in (seq (count $argv))
            if contains -- $argv[$i] --resume -r
                set id $argv[(math $i + 1)]
                break
            end
        end
        set -l map ~/.clauth/session_profiles.json
        if test -n "$id" -a -f $map
            set -l profile (jq -r --arg id $id '.sessions[$id].known // empty' $map 2>/dev/null)
            if test -n "$profile"
                clauth start $profile $argv
                return
            end
        end
    end
    command claude $argv
end
