---
title: How to Fix Misspelled Column Names in a Ruby on Rails Database
featured: false
layout: post

date: 2015-10-25 16:35:59 -07:00
last_modified_at: 2022-02-28T23:28:56.285Z
category: programming
---

I came across a small issue this afternoon while building out one of my first Ruby on Rails apps. When I generated the database table, I misspelled a column name. Luckily for me, it's easy enough to fix and this is how I did it.

### 1. Create a New Migration

At the command line from within your Rails application folder, run this:

.gist table { margin-bottom: 0; }

You'll be generating a new database migration with the name FixColumnName (which interprets to `[timestamp]_fix_column_name.rb`) inside the `db/migrate` folder inside your rails application. Open that `.rb` file and update it so it looks something like this:.gist table { margin-bottom: 0; }

`:table_name` – the name of the table in question

`:old_column` – the misspelled column name

`:new_column` – the correct column name

If you have multiple columns you need to change, introduce additional `rename_column` functions:

.gist table { margin-bottom: 0; }

Keep in mind that after this migration, you'll need to update your references to the column everywhere within your app.

Seems like a simple fix but as someone who's relatively new to Ruby on Rails, this saved me a load of time figuring out what to do and preventing me from starting over.

