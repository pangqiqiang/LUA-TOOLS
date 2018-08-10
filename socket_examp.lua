--1. socket方式请求
-- socket方式请求
local socket = require("socket")
local host = "100.42.237.125"
local file = "/"
local sock = assert(socket.connect(host, 80))  -- 创建一个 TCP 连接，连接到 HTTP 连接的标准 80 端口上
sock:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
repeat
    local chunk, status, partial = sock:receive(1024) -- 以 1K 的字节块来接收数据，并把接收到字节块输出来
    -- print(chunk or partial)
until status ~= "closed"
sock:close()  -- 关闭 TCP 连接

---2HTTP访问请求

-- http访问请求
http=require("socket.http")
result=http.request("http://ip.taobao.com/service/getIpInfo.php?ip=123.189.1.100")
print(result)


--3、SMTP方法发送mail

-- smtp方法发送mail
local smtp = require("socket.smtp")

from = "<youmail@126.com>" -- 发件人

-- 发送列表
rcpt = {
    "<youmail@126.com>",
    "<youmail@qq.com>"
}

mesgt = {
    headers = {
        to = "youmail@gmail.com", -- 收件人
        cc = '<youmail@gmail.com>', -- 抄送
        subject = "This is Mail Title"
    },
    body = "This is  Mail Content."
}

r, e = smtp.send{
    server="smtp.126.com",
    user="youmail@126.com",
    password="******",
    from = from,
    rcpt = rcpt,
    source = smtp.message(mesgt)
}

if not r then
   print(e)
else
   print("send ok!")
end


