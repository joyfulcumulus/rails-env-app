@recent_points_history.each do |record|
  date = record.challenge_event.end_datetime.strftime("%e %b %Y")
  json.set! date, record.points
end
