# Add seed data here. Seed your database with `rake db:seed`
laura = Teacher.create(name: "Laura C", password: "pass")
catherine = Teacher.create(name: "Catherine", password: "pass")
lou_anne = Teacher.create(name: "Lou Ann", password: "pass")

nita = Student.create(name: "Nita", password: "pass")
charlie = Student.create(name: "Charlie", password: "pass")
tim = Student.create(name: "Tim", password: "pass")

friendship = Course.create(name: "Friendship", description: "learn how to make friends", capacity: 14, location: "Boardroom",
                            schedule_days: "Mon/Wed/Fri", start_time: "9:00 AM", end_time: "10:00 AM", duration: "60", military_start_time: "9:00")
painting = Course.create(name: "Painting", description: "learn how to paint", capacity: 15, location: "artroom",
                            schedule_days: "Mon/Wed/Fri", start_time: "10:00 AM", end_time: "11:00 AM", duration: "60", military_start_time: "10:00")
magazine = Course.create(name: "Magazine", description: "look through magazines", capacity: 12, location: "house",
                            schedule_days: "Tue/Thu", start_time: "1:30 PM", end_time: "2:00 PM", duration: "30", military_start_time: "13:30")
relationship = Course.create(name: "Relationship", description: "learn about healthy relationships", capacity: 10, location: "Office",
                            schedule_days: "Tue/Thu", start_time: "9:00 AM", end_time: "10:00 AM", duration: "60", military_start_time: "9:00")
horses = Course.create(name: "Horses", description: "learn how to ride and care for horses", capacity: 4, location: "barn",
                            schedule_days: "Mon/Wed/Fri", start_time: "1:00 PM", end_time: "2:30 PM", duration: "90", military_start_time: "13:00")
beading = Course.create(name: "Beading", description: "learn how to bead", capacity: 6, location: "building",
                            schedule_days: "Mon/Wed/Fri", start_time: "8:00 AM", end_time: "10:00 AM", duration: "120", military_start_time: "8:00")

# Teachers
laura.courses << friendship
laura.courses << relationship
laura.courses << beading

catherine.courses << beading
catherine.courses << magazine
catherine.courses << painting

lou_anne.courses << horses
lou_anne.courses << friendship
lou_anne.courses << magazine

# Students
nita.courses << friendship
tim.courses << relationship
charlie.courses << beading

nita.courses << beading
tim.courses << magazine
charlie.courses << painting

nita.courses << horses
tim.courses << friendship
charlie.courses << magazine
