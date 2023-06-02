# clean plugins
echo "clean plugins..."
rm -rf ./plugins
mkdir plugins
echo "done!"
# use tpm
echo "getting tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "finished."
