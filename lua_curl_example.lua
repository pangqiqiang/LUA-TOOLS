require("curl")

local ipList = 
{
    "192.168.1.1",
　　"192.168.1.1",
}

--登陆
function loginWeb(ip) 
　　c = curl.easy_init() 
　　c:setopt(curl.OPT_SSL_VERIFYHOST, 0); 
　　c:setopt(curl.OPT_SSL_VERIFYPEER, 0); 
　　c:setopt(curl.OPT_URL, "https://"..ip.."/") 
   c:setopt(curl.OPT_POSTFIELDS, "Username=admin&Password=admin&Frm_Logintoken=&action=login")

　　c:setopt(curl.OPT_WRITEFUNCTION, function(buffer)
　　　　--print(buffer)
 　 　　--print("\r\n---------------------------\r\n");
　　　　return #buffer
　　end)

   c:perform()
end

--访问页面
function accessPage(ip) 
　　c = curl.easy_init() 
　　c:setopt(curl.OPT_SSL_VERIFYHOST, 0); 
　　c:setopt(curl.OPT_SSL_VERIFYPEER, 0); 
　　c:setopt(curl.OPT_URL, "https://"..ip.."/xxpage.html")

　　c:setopt(curl.OPT_WRITEFUNCTION, function(buffer)
　　　　--print(buffer)
 　 　　--print("\r\n---------------------------\r\n");
　　　　return #buffer
　　end)

   c:perform()
end

--设置参数
function setParameter(ip, file) 
　　c = curl.easy_init() 
　　c:setopt(curl.OPT_SSL_VERIFYHOST, 0); 
　　c:setopt(curl.OPT_SSL_VERIFYPEER, 0); 
　　c:setopt(curl.OPT_URL, "https://"..ip.."/xx.php") 
　　c:setopt(curl.OPT_POSTFIELDS, "DaylightSavingsUsed=1&Dscp=-1")

　　local htmlTable = {}
　　c:setopt(curl.OPT_WRITEFUNCTION, function(buffer)
　　　　--print(buffer)
 　 　　--print("\r\n---------------------------\r\n");
　　　　table.insert(htmlTable, buffer)
　　　　return #buffer
　　end)

   c:perform()

　　local htmlStr = table.concat(htmlTable);
　　local resultBuff = "";
　　if string.match(htmlStr, "<result>SUCC</result>") ~= nil then
　　　　resultBuff = ip.." config OK\r\n";
　　　　print(resultBuff)
　　　　file:write(resultBuff);
　　else
　　　　resultBuff = ip.." config NOK\r\n";
　　　　print(resultBuff)
　　　file:write(resultBuff);

　end
end


local file = io.open(".\\result.txt", "w+");
for key,ip in ipairs(ipList) do 
　　loginWeb(ip); 
　　accessPage(ip); 
　　openLightSave(ip, file); 
end
file:close();

print("Done"