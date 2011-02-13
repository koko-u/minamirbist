# -*- coding: utf-8 -*-

ならば /^以下のメンバーが表示される:$/ do |member_table|
  # table is a Cucumber::Ast::Table
  column_selector = (1..7).map { |i| "td:nth-child(#{i})" }.join(",")
  member_table.diff!(tablish("table tr.member", column_selector))
end

前提 /^以下のメンバーが登録されている:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

もし /^(\d+)番目のレコードを削除する$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
