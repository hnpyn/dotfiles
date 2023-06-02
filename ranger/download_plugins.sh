# clean up plugins
echo "clean plugins..."
rm -rf plugins
mkdir plugins
echo "done!"
echo "Install plugins..."
git clone https://github.com/alexanderjeurissen/ranger_devicons
git clone https://github.com/fdw/ranger-autojump.git
cp ./ranger-autojump/autojump.py ./autojump.py
echo "finished."
