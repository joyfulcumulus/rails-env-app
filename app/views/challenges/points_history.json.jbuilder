@recent_points_history.each do |record|
  date = record.end_datetime.strftime("%e %b")
  json.set! date, (record.points.nil? ? 0 : record.points)
end
