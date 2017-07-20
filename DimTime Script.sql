/*Delete from dbo.dimTime*/

DECLARE @StartDate datetime
DECLARE @Enddate datetime

SET @StartDate = '01/01/2011'
SET @Enddate = '01/01/2018'

DECLARE @LoopDate datetime
SET @LoopDate = @StartDate

While @LoopDate <= @Enddate
	BEGIN
		INSERT INTO dbo.dimTime Values(
		cast(convert(varchar(8),@LoopDate,112) as int),
		DATEPART(dw,@LoopDate),
		DAY(@LoopDate),
		DATEPART(dy,@LoopDate),
		DATEPART(wk,@LoopDate),
		DATEPART(mm,@LoopDate),
		DATENAME(month, @LoopDate),
		DATEPART(YYYY,@LoopDate),
		CASE DATEPART(DW, @LoopDate)
			WHEN 1 THEN 1
			WHEN 2 THEN 0
			WHEN 3 THEN 0
			WHEN 4 THEN 0
			WHEN 5 THEN 0
			WHEN 6 THEN 0
			WHEN 7 THEN 1
			END ,
		convert(date, @LoopDate,101),
		0,
		'',
		DATENAME(dw, @LoopDate),
		datepart(day, datediff(day, 0, @LoopDate)/7 * 7)/7 + 1
		)
		SET @LoopDate = DateAdd(d, 1, @LoopDate)
	END
/********************************************************************/
/*	New Years Day*/
/********************************************************************/
UPDATE  dbo.DimTime
SET HolidayText = 'New Year”s Day',
IsHoliday = 1
--OpenFlag    = 0
WHERE   [MonthNumber] = 1
AND [DAYOfYear] = 1;

/*Marti Luthar */
UPDATE  DimTime
SET HolidayText = 'Martin Luther King Jr. Day',
IsHoliday = 1
WHERE   [MonthNumber] = 1 --January
AND [DayOfWeekName] = 'Monday'
--AND YearNumber >= 1983 --When holiday was official
AND [DayOfWeekInMonth] = 3; --Third X day of current month.
GO

--Third Monday in February.
UPDATE  DimTime
SET HolidayText = 'President”s Day',
IsHoliday = 1
WHERE   [MonthNumber] = 2 --February
AND [DayofweekName] = 'Monday'
AND [DayOfWeekInMonth] = 3; --Third occurance of a monday in this month.
GO

UPDATE  dbo.DimTime
SET HolidayText = 'Memorial Day',
IsHoliday = 1
--select *  
FROM    DimTime
WHERE   DateId IN (SELECT   MAX([DateId])
FROM     dbo.DimTime
WHERE    [MonthName] = 'May'
AND [DayOfWeekName] = 'Monday'
GROUP BY YearNumber, [MonthNumber]);


UPDATE  dbo.dimTime
SET HolidayText = '',
IsHoliday = 0
--select * from dimTime
WHERE   [MonthNumber] = 7
AND [DAYOfMonth] = 4;

UPDATE  dbo.dimTime
SET HolidayText = 'Labor Day',
IsHoliday = 1
FROM    dimTime
WHERE   DateId IN (SELECT   MIN([DateId])
FROM     dbo.dimTime
WHERE    [MonthName] = 'September'
AND [DayOfWeekName] = 'Monday'
GROUP BY YearNumber, [MonthNumber]);

UPDATE  dbo.dimTime
SET HolidayText = 'Columbus Day',
IsHoliday = 1
FROM    dimTime
WHERE   DateId IN (SELECT   MIN(DateId)
FROM     dbo.dimTime
WHERE    [MonthName] = 'October'
AND [DayOfWeekName] = 'Monday'
AND [DayOfWeekInMonth] = 2
GROUP BY YearNumber, [MonthNumber]);

UPDATE  dbo.dimTime
SET HolidayText = 'Veteran”s Day',
IsHoliday = 1
WHERE   DateId IN (SELECT CASE
WHEN DayOfWeekName = 'Saturday' THEN DateId - 1
WHEN DayOfWeekName = 'Sunday' THEN DateId + 1 ELSE DateId
END AS VeteransDateSK
FROM   dimTime
WHERE  [MonthNumber] = 11
AND [DAYOfMonth] = 11);
GO

--Fourth THURSDAY in November.
UPDATE  dimTime
SET HolidayText = 'Thanksgiving Day',
IsHoliday = 1
WHERE   [MonthNumber] = 11
AND [DAYOFWEEKName] = 'Thursday'
AND [DayOfWeekInMonth] = 4;
GO
--CHRISTMAS 
UPDATE  dbo.dimTime
SET HolidayText = 'Christmas Day',
IsHoliday = 1
WHERE   [MonthNumber] = 12
AND [DAYOfMonth] = 25;

