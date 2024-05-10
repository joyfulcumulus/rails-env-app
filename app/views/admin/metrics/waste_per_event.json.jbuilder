@events_in_range.each do |record|
  date = record.end_datetime.strftime("%e %b")
  json.set! date, @num_residents_in_estate * 6.0
end

# assume in this project, weekly waste generated is 6.0kg / user
