@participants_in_range.each do |record|
  date = record.end_datetime.strftime("%e %b")
  json.set! date, (record.participants.nil? ? 0 : record.participants)
end
