10.times do |n|
  User.create!(
    name: FFaker::Name.name,
    email: FFaker::Internet.email,
    password: "abc123123",
    password_confirmation: "abc123123",
    activated: true,
    activated_at: Time.zone.now
  )
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

User.create!(
  name: "James",
  email: "james@gmail.com",
  password: "abc123123",
  password_confirmation: "abc123123",
  activated: true,
  activated_at: Time.zone.now,
  is_admin: true
)

10.times do |n|
  Course.create!(
    name: FFaker::Book.author,
    description: FFaker::CompanyIT.name,
    user_id: users.ids.sample
  )
end
courses = Course.all.ids
10.times do 
  Word.create!(
    course_id: courses.sample,
    name: "place",
    meaning: "ĝịa điểm",
    pronounce: "place",
    example: "This is place"
  )
end
