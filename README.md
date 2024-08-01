# nginx filter with lua

Sets up basic nginx filter with Lua and OpenResty

File that is valid

`curl -X POST -F "file=@Gemfile" http://localhost/artifact`

File that is rejected

`curl -X POST -F "file=@foo.exe" http://localhost/artifact`
