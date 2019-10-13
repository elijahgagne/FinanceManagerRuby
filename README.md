# README

Starting place [https://guides.rubyonrails.org/getting_started.html](https://guides.rubyonrails.org/getting_started.html)

Command line:

```bash
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
.header on
.mode column
.tables
.schema transactions

select * from transactions;
```
