json.chartdata do
  @recent_points_history.each do |record|
    date = record.end_datetime.strftime("%e %b")
    json.set! date, (record.points.nil? ? 0 : record.points)
  end
end

json.tabledata render(partial: "challenges/home/pointstable", formats: :html, locals: { pointsdata: @recent_points_history })
