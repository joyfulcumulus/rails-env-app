@recent_recycled_history.each do |record|
  date = record.end_datetime.strftime("%e %b")
  json.set! date, (record.weight.nil? ? 0 : record.weight)
end
