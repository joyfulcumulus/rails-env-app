@recent_recycled_history.each do |record|
  date = record.challenge_event.end_datetime.strftime("%e %b")
  json.set! date, record.recyclable_weight
end
