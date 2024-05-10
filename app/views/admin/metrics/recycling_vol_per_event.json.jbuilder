@recycling_vol_in_range.each do |record|
  date = record.end_datetime.strftime("%e %b")
  json.set! date, (record.averagevol.nil? ? 0 : record.averagevol)
end
