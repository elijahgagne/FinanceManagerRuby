# README

Starting place [https://guides.rubyonrails.org/getting_started.html](https://guides.rubyonrails.org/getting_started.html)

Command line:

```bash
cd /data/dg/Code/ruby/FinanceManagerRuby

rails new FinanceManagerRuby
cd FinanceManagerRuby

rails routes
rails server

rails generate controller Welcome index
rails generate controller Transactions
rails generate model Transaction title:string text:text
rails db:migrate

rails generate model Transaction name:string payment_method:string category:string amount:decimal{8-2} submit_date:datetime status:integer --force
rails db:migrate
```

Database commands

```bash
# Open the database file
sqlite3 /data/dg/Code/ruby/FinanceManagerRuby/db/development.sqlite3

.header on
.mode column

.tables
.schema transactions

select * from transactions;
```

Re-do the database

```bash
cd /data/dg/Code/ruby/FinanceManagerRuby
sqlite3 db/development.sqlite3

drop table ar_internal_metadata;
drop table schema_migrations;
drop table transactions;

.quit

rm -f db/migrate/*

rails generate model Transaction name:string payment_method:string amount:decimal{8-2} submit_date:datetime status:string --force
rails db:migrate

sqlite3 /data/dg/Code/ruby/FinanceManagerRuby/db/development.sqlite3 <<EOF
attach database '/data/dg/Code/aspnetcore/FinanceManagerData/FinanceManager.db' as old;
delete from transactions;
update sqlite_sequence set seq=0 where name='transactions';
insert into transactions (name, payment_method, amount, submit_date, status, created_at, updated_at)
select
  d.Name [name]
, replace (p.Name, ' (manual)', '') [payment_method]
, d.Amount [amount]
,case substr(d.date, 0, 4)
   when 'Jan' then substr(d.date, 8, 4) || '-01-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Feb' then substr(d.date, 8, 4) || '-02-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Mar' then substr(d.date, 8, 4) || '-03-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Apr' then substr(d.date, 8, 4) || '-04-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'May' then substr(d.date, 8, 4) || '-05-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Jun' then substr(d.date, 8, 4) || '-06-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Jul' then substr(d.date, 8, 4) || '-07-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Aug' then substr(d.date, 8, 4) || '-08-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Sep' then substr(d.date, 8, 4) || '-09-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Oct' then substr(d.date, 8, 4) || '-10-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Nov' then substr(d.date, 8, 4) || '-11-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Dec' then substr(d.date, 8, 4) || '-12-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   else strftime('%Y-%m-%d 00:00:00.000000', replace(d.Date, ' 12:00AM', ''))
  end [submit_date]
, case d.Completed
    when 1 then 'completed'
    when 0 then 'pending'
  end [status]
, date('now') || '00:00:00.000000' [created_at]
, date('now') || '00:00:00.000000' [updated_at]
from old."Transaction" d
join old.PaymentMethod p on d.PaymentMethodID = p.PaymentMethodID
union
select
  b.Name [name]
, replace (p.Name, ' (manual)', '') [payment_method]
, d.Amount [amount]
, case substr(d.date, 0, 4)
   when 'Jan' then substr(d.date, 8, 4) || '-01-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Feb' then substr(d.date, 8, 4) || '-02-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Mar' then substr(d.date, 8, 4) || '-03-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Apr' then substr(d.date, 8, 4) || '-04-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'May' then substr(d.date, 8, 4) || '-05-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Jun' then substr(d.date, 8, 4) || '-06-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Jul' then substr(d.date, 8, 4) || '-07-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Aug' then substr(d.date, 8, 4) || '-08-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Sep' then substr(d.date, 8, 4) || '-09-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Oct' then substr(d.date, 8, 4) || '-10-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Nov' then substr(d.date, 8, 4) || '-11-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   when 'Dev' then substr(d.date, 8, 4) || '-12-' || replace(substr(d.date, 5, 2), ' ', '0') || ' 00:00:00.000000'
   else strftime('%Y-%m-%d 00:00:00.000000', replace(d.Date, ' 12:00AM', ''))
  end [submit_date]
, case p.Name
    when 'E-Check'  then 'automatic'
    when 'Chase'    then 'automatic'
    when 'Discover' then 'automatic'
    else 'manual'
  end [status]
, date('now') || '00:00:00.000000' [created_at]
, date('now') || '00:00:00.000000' [updated_at]
from DueDate d
join Bill b on d.BillID = b.BillID
join PaymentMethod p on b.PaymentMethodID = p.PaymentMethodID
where b.Enabled = 1
order by 4;
EOF
```
