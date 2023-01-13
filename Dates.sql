Declare @DateCur1 date;  -- to store each date from dailyLog table
Declare @count int;  -- counter for computing in dailyLog

-- to hold two fields from Guestinfo
Declare @ArriveDateCur date;  
Declare @LeaveDateCur date;

DECLARE Cur1 CURSOR FOR
    SELECT date From dbo.dailyLog;

OPEN Cur1
FETCH NEXT FROM Cur1 INTO @DateCur1;
WHILE @@FETCH_STATUS = 0
BEGIN
       set @count = 0;   -- For each date, start from 0 counts of car
  PRINT Cast(@DateCur1 as Varchar);

  DECLARE Cur2 CURSOR FOR
  SELECT arrivedate,leavedate FROM dbo.Guestinfo$
OPEN Cur2;
FETCH NEXT FROM Cur2 INTO @ArriveDateCur,@LeaveDateCur;
--  PRINT 'Cur2here';   -- this line I used for debug
WHILE @@FETCH_STATUS = 0
BEGIN
 --   PRINT Cast(@ArriveDateCur as Varchar);   -- this line I used for debug
 --   PRINT Cast(@LeaveDateCur as Varchar);    -- this line I used for debug

if ( @DateCur1 >= @ArriveDateCur and  @DateCur1<= @LeaveDateCur)
set @count=@count+1
FETCH NEXT FROM Cur2 INTO @ArriveDateCur,@LeaveDateCur;

        END
-- print 'count99';     -- -- this line I used for debug
   update dbo.dailyLog set carNum = @count where date= @DateCur1;
   CLOSE Cur2;     -- close cur2 for every line  
DEALLOCATE Cur2;  -- Release memory cur2 for every date in dailyLog table
FETCH NEXT FROM Cur1 INTO @DateCur1;
END;
PRINT 'DONE';
CLOSE Cur1;
DEALLOCATE Cur1;

SELECT * from dbo.dailyLog 

   



	