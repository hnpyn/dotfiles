# clean up plugins
echo ""
echo " clean plugins..."
echo ""

rm -rf plugins
mkdir plugins
cd plugins

echo " done!"

echo ""
echo " Install plugins..."
git clone https://github.com/alexanderjeurissen/ranger_devicons
git clone https://github.com/fdw/ranger-autojump.git
cp ./ranger-autojump/autojump.py ./autojump.py

echo ""
echo " finished."
