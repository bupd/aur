# Option 1: Directly in your script
echo "## Version Updates"
echo ""

if [ -z "$NVLOG_DIFF" ]; then
  echo "No version changes detected."
else
  # echo "The following tools have been updated:"
  # echo ""
  # echo "```diff"
  # echo "$NVLOG_DIFF"
  # echo "```"
  echo ""
  echo "## Summary of Changes:"
  echo ""

  echo "$NVLOG_DIFF" | while IFS= read -r line; do
    if [[ "$line" =~ ^\<[[:space:]]*(.*):[[:space:]]*updated[[:space:]]*to[[:space:]]*([0-9]+\.[0-9]+\.[0-9]+.*) ]]; then
      tool_name=${BASH_REMATCH[1]}
      old_version=${BASH_REMATCH[2]}
      declare -g "OLD_VER_${tool_name//[^a-zA-Z0-9_]/_}"="$old_version"
    elif [[ "$line" =~ ^\>[[:space:]]*(.*):[[:space:]]*updated[[:space:]]*to[[:space:]]*([0-9]+\.[0-9]+\.[0-9]+.*) ]]; then
      tool_name=${BASH_REMATCH[1]}
      new_version=${BASH_REMATCH[2]}
      old_version_var="OLD_VER_${tool_name//[^a-zA-Z0-9_]/_}"
      old_version="${!old_version_var}"

      if [ -n "$old_version" ]; then
        echo "- **${tool_name}**: Updated from \`${old_version}\` to \`${new_version}\`"
        unset "$old_version_var"
      else
        echo "- **${tool_name}**: New version \`${new_version}\`"
      fi
    fi
  done
fi
