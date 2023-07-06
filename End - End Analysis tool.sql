--With Hotels as (
--select * from ..[2018]
--union
--select * from ..[2019]
--union
--select * from ..[2020] )


--select arrival_date_year as Date,
--Hotels,
--sum((stays_in_week_nights+stays_in_weekend_nights) * adr) as Revenue 
--from Hotels 
--group by arrival_date_year,hotel



With Hotels as (
select * from ..[2018]
union
select * from ..[2019]
union
select * from ..[2020] )


select * from Hotels
left join ..market_segment on Hotels.market_segment = market_segment.market_segment
left join ..meal_cost on meal_cost.meal = Hotels.meal