boon build . --target windows --version 11.0
gh release delete latest --yes
gh release create latest ./release/Historically-Accurate-Jam-win64.zip ./release/Historically-Accurate-Jam.love