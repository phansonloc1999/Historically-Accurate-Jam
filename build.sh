boon build . --target windows --version 11.0
git tag -d latest
git tag latest
git push origin latest --force
gh release delete latest --yes
gh release create latest --notes "" --prerelease ./release/Historically-Accurate-Jam-win64.zip ./release/Historically-Accurate-Jam.love