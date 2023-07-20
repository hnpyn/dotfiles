# clean plugins
echo ""
echo " clean plugins..."
echo ""

rm -rf ./plugins
mkdir plugins

echo " done!"
echo ""

# use tpm
echo " getting tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo ""
echo " finished."
echo " please use tqm to get plugins."
