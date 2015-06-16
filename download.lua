local args = {...}
if #args ~= 2 then
	print("usage: download <address> <filename>")
else
local filen = args[2]
local add = args[1]

http.request(add)
local requesting = true

 while requesting do

   local event, url, sourceText = os.pullEvent()

   if event == "http_success" then

     local respondedText = sourceText.readAll()

	local f = fs.open(filen, "w")
	f.write(respondedText)
	f.close()

     requesting = false

   elseif event == "http_failure" then

     print("Server didn't respond.")

     requesting = false

   end
 end
 end