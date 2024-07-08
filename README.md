# Challenge Together

## Introduction
This is a community challenge app envisioned to be part of the Singapore government's One Service app. This app is used to administer a Recycling Challenge, where residents cooperate to hit recycling rate targets to collect points that can be converted to vouchers, thus encouraging recycling.

Features include: chart visualizations, background jobs, attendance taking and chat features. Comes with an admin portal to manage the community challenge events.

Demo videos:
* Consumer-facing features: https://www.youtube.com/watch?v=0RJqgfB22jQ
* Admin portal features: https://www.youtube.com/watch?v=jZxFLR6gWOo

## Technologies Used
This project was built with
* HTML
* CSS (Framework: Bootstrap)
* JavaScript
* Ruby on Rails
* PostgreSQL

Hosting: Heroku

## Product Wireframe
[Figma wireframe](https://www.figma.com/file/ZrEoJ8oehbevBHt2FmIuzu?type=design%27&node-id=1:2)

## System Design (ERD)
Key design considerations
* A community challenge may run over a long period of time (e.g. 1 year), therefore 1 challenge has N challenge events
* Users need to be grouped by their address to collaborate together at the estate-level (N users : 1 estate). Therefore, `addresses` and `estates` tables were created, and the `estate id` was used group the users into estate chats.
* As users could participate in multiple challenges, and the rewards programme for each challenge could be different, a join table `participations` was created, containing additional attributes related to the participation (e.g. points)
* To generate the chart visualisations tracking the points gained by the user, as well as the recyclable weight contributed per challenge event, changelog tables (i.e. `points_awards`, `actions`) were created

![Challenge Together Entity Resource Diagram](/public/challenge-erd.png)

## Feature Logic
### Joining a Challenge
* Upon joining the challenge, the `join` method creates a record in the `participation` table and also finds / initializes the estate-level group chatroom for the user to join in

```ruby
def join
  @user = current_user
  @challenge = Challenge.find(params[:id])
  @participation = Participation.new(user: @user, challenge: @challenge)
  authorize @participation
  @participation.save!

  @user_estate = @user.address.estate
  @chatroom = Chatroom.find_or_initialize_by(challenge: @challenge, estate: @user_estate)
  @chatroom.save!

  @chatroom_member = ChatroomMember.find_or_initialize_by(user: @user, chatroom: @chatroom)
  authorize @chatroom_member
  @chatroom_member.save!

  respond_to do |format|
    # return chatroom ID for newly joined member to access
    format.json { render json: { chatroomId: @chatroom.id }, status: :ok }
  end
end
```

### Challenge Event Attendance Taking
* Used [RQRCode Ruby Gem](https://github.com/whomwah/rqrcode) to generate QR code unique to each challenge event
* Upon scanning, users redirected to a page with all information pre-filled for acknowledgement.

```ruby
def show
  @challenge_event = ChallengeEvent.find(params[:id])
  authorize @challenge_event
  url = url_for(action: 'new', controller: '/actions', challenge_event_id: @challenge_event.id)
  @qr_code = RQRCode::QRCode.new(url)
  @svg = @qr_code.as_svg(
    offset: 0,
    color: '000',
    shape_rendering: 'crispEdges',
    standalone: true,
    module_size: 8
  )
  render layout: "admin_layout"
end
```

### Points disbursement to participating residents who've hit targets
* Created a Rails Active job that computes the recycling rate of the estate after the challenge event, and checks if this rate meets any challenge target
* If yes, increment the `total_points` of the participating users, and write a record to the `points_awards` table

```ruby
def perform
  puts "Check if points can be awarded based on participant's total recycling rate"
  challenge = Challenge.find_by(name: "National Recycling Challenge")
  latest_event = ChallengeEvent.where(challenge:).where("end_datetime < ?", Date.today.to_datetime).order(end_datetime: :desc).first
  estates = Estate.all
  estates.each do |estate|
    users_in_estate = User.includes(:address).where(address: { estate: })
    total_recyclable_waste = Action.includes(:user)
                                    .where(challenge_event: latest_event)
                                    .where(users: { id: users_in_estate.map(&:id) })
                                    .sum(:recyclable_weight)
    total_waste = users_in_estate.count * 6.0 # assume in this project, weekly waste generated is 6.0kg / user
    latest_recycling_rate = total_recyclable_waste / total_waste * 100
    puts "Recycling rate for estate #{estate.name} is #{latest_recycling_rate}%."

    rewards_programme_targets = RewardsProgramme.where(challenge:).order(target: :asc).pluck(:target)
    achieved_target = rewards_programme_targets.min_by { |target| (latest_recycling_rate - target).abs }
    points_for_user = RewardsProgramme.where(challenge:, target: achieved_target).pluck(:points).first
    puts "Points to give each user: #{points_for_user}"

    if points_for_user.positive?
      users_in_estate.each do |user|
        participation = Participation.find_by(user:, challenge:)
        participation.update!(points: (participation.points + points_for_user))
        total_points = TotalPoint.find_by(user:)
        total_points.update!(total_points: (total_points.total_points + points_for_user))
        PointsAward.create!(points: points_for_user, user:, challenge:, challenge_event: latest_event)
        # log the points award inside points award table
      end
      puts "Points awarded to each user in estate #{estate.name}!"
    else
      puts "No points for user as targets not hit"
    end
  end
end
```

### Challenge Performance Metrics (In consumer-facing UI and admin portal)
* Used [Chart.js](https://www.chartjs.org/docs/latest/getting-started/installation.html) library by pinning the package into importmap first, then registering the controllers, elements, scales, and plugins to use. For ease of use (though sacrificing on bundle size), I registered everything
* Wrote a JavaScript function in frontend to call backend to fetch the required data in JSON, which is then used in the `Chart` object of the library

```javascript
getPointsHistory() {
  const url = `/challenges/${this.challengeIdValue}/points_history`;
  fetch(url)
  .then(response => response.json())
  .then(data => {
    let labels1 = Object.keys(data.chartdata);
    let data1 = Object.values(data.chartdata);

    const pointsHistoryChart = new Chart(
      this.pointsTarget, // this is the canvas element where the chart will be rendered
      {
        type: 'line',
        options: {
          plugins: {
            legend: {
              display: false
            }
          }
        },
        data: {
          labels: labels1,
          datasets: [{
            label: 'Points',
            data: data1,
            fill: false,
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.1
          }]
        }
      }
    );

    this.tableTarget.innerHTML = data.tabledata;
  });
}
```


```ruby
def points_history
  challenge = Challenge.find(params[:id])
  @recent_points_history =
    ChallengeEvent
    .joins("LEFT JOIN points_awards ON challenge_events.id = points_awards.challenge_event_id AND points_awards.user_id = #{current_user.id}")
    .where(challenge:)
    .where("end_datetime < ?", Date.today.to_datetime)
    .where("end_datetime > ?", Date.today.weeks_ago(6).to_datetime)
    .order(end_datetime: :asc)
    .select('challenge_events.end_datetime, points_awards.points as points')
  authorize @recent_points_history
  respond_to :json
end
```

## Further Development
These features could be added in future if there is more time for the project:
* Visualise locations of nearest challenge event instead of redirecting users
* Send notifications to user when points are awarded
* Ensure "Scan QR code" button can open camera app directly
