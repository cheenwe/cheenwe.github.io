# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/tmp/cron_whenever.log"
set :output, {:error => '/home/chenwei/z.error.log', :standard => '/home/chenwei/z.standard.log'}

every 3.hours do # 1.minute 1.day 1.week 1.month 1.year is also supported
  runner "MyModel.some_process"
  rake "my:rake:task"
  command "/usr/bin/my_great_command"
end

every 1.day, :at => '4:30 am' do
  runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
end

every :hour do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  runner "SomeModel.ladeeda"
end

every :sunday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
  runner "Task.do_something_great"
end

every '0 0 27-31 * *' do
  command "echo 'you can use raw cron syntax too'"
end

every :day, :at => '12:20am', :roles => [:app] do
  rake "app_server:task"
end

# job_type :ruby, "cd /home/chenwei/workspace/blog/cheenwe.github.io/_posts/sh/ && /usr/bin/ruby 'send_mail'.rb"

every 1.minute do
    command "cd /home/chenwei/workspace/blog/cheenwe.github.io/_posts/sh/ &&ruby test.rb"
  # "#{Time.now}_-------------------------1s task----------------"
  # ruby 'have_a_rest'
end
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
