@recycling_rate_in_range.each do |record|
  date = record.end_datetime.strftime("%e %b")
  json.set! date, (record.recyclingrate.nil? ? 0 : record.recyclingrate * 100.0 )
end
