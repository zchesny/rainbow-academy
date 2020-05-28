# RainbowAcademy

This is a Dynamic Sinatra Web Application that enables course creation, enrollment, and management in a Teacher-Student School domain.

### Teachers
- [x] Can sign up, login, and logout with a name and password
- [x] Can create courses 
- [x] Can edit their own courses 
- [x] Can update teachers on their own courses 
- [x] Can update enrollments on their own courses
- [x] Can view their homepage, which includes their daily schedule, weekly schedule, list of courses they teach, and list of students they teach

### Students 
- [x] Can sign up, login, and logout with a name and password
- [x] Can select courses to enroll in from a course catalog of all courses available 
- [x] Can update their own enrollments (add or drop courses), as long as the course they enroll in does not exceed capacity
- [x] Can view their homepage, which includes their daily schedule, weekly schedule, list of courses they're enrolled in, and list of teachers they have

### Courses
- [x] Have a name, description, capacity, location, weekly schedule, start time, and duration 
- [x] Have a list of teacher(s) who teach this course 
- [x] Have a list of student(s) who are enrolled in this course

### Validation Features
- [x] Prevents duplicate teacher names 
- [x] Prevents duplicate student names 
- [x] Prevents duplicate course names 
- [x] Prevents courses from being created if they do not have a valid name, description, valid capacity, location, start time, and duration
- [x] Prevents courses from being enrolled beyond capacity 

### Future Features
- [ ] Waitlisting classes 
- [ ] Admin role (can CRUD all students, teachers, and courses)
- [ ] Attendance log 
- [ ] History of changes log (CRUD on all students, teachers, and courses)
- [ ] Schedule overlap prevention 
- [ ] Improving the schedule layout/ design

## Installation

```
cd 'rainbow-academy'
```

And then execute:

    $ bundle install

Execute in terminal:

    $ bundle exec rackup -p 3000

## Usage

To run this gem, clone or download this repo and run: `bundle exec rackup -p 3000`

### Recommended Steps:

1. Sign up as a student or teacher
2. View all course listings 
3. View your homepage
4. Create courses as a teacher
5. Enroll in courses as a student
6. Manage your classes as a teacher
7. Manage your enrollments as a student 
8. Logout

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `shotgun` to experiment with changes in real time via a local host.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zchesny/rainbow-academy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RecipeFinder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'zchesny'/recipe_finder/blob/master/CODE_OF_CONDUCT.md).
