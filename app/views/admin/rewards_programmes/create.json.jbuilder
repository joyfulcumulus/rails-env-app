if @reward.persisted?
  json.inserted_reward render(partial: "admin/challenges/editreward_form", formats: :html, locals: {reward: @reward, challenge: @reward.challenge})
end
