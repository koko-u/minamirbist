Given /^the following members:$/ do |members|
  Member.create!(members.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) member$/ do |pos|
  visit members_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following members:$/ do |expected_members_table|
  expected_members_table.diff!(tableish('table tr', 'td,th'))
end



