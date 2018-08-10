mysql = require "luasql.mysql"

local env  = mysql.mysql()
local conn = env:connect('test','root','123456', '127.0.0.1', 3306)
print(env,conn)

status,errorString = conn:execute([[CREATE TABLE sample3 (id INTEGER, name TEXT)]])
print(status,errorString )

status,errorString = conn:execute([[INSERT INTO sample3 values('12','Raj')]])
print(status,errorString )

cursor,errorString = conn:execute([[select * from sample3]])
print(cursor,errorString)

row = cursor:fetch ({}, "a")
while row do
  print(string.format("Id: %s, Name: %s", row.id, row.name))
  row = cursor:fetch (row, "a")
end
-- close everything
cursor:close()
conn:close()


--[=[
执行事务
事务是数据库中保证数据一致性的一种机制。事务有以下四个性质：

原子性：一个事务要么全部执行要么全部不执行。
一致性：事务开始前数据库是一致状态，事务结束后数据库状态也应该是一致的。
隔离性：多个事务并发访问时，事务之间是隔离的，一个事务的中间状态不能被其它事务可见。
持久性： 在事务完成以后，该事务所对数据库所做的更改便持久的保存在数据库之中，并不会被回滚。
事务以 START_TRANSACTION 开始，以 提交（commit）或 回滚（rollback）语句结束。

事务开始

为了初始化一个事务，我们需要先打开一个 MySQL 连接，再执行如下的语句：

conn:execute([[START TRANSACTION;]])
事务回滚

当需要取消事务执行时，我们需要执行如下的语句回滚至更改前的状态。

conn:execute([[ROLLBACK;]])
提交事务

开始执行事务后，我们需要使用 commit 语句提交完成的修改内容。

conn:execute([[COMMIT;]]
--]=]