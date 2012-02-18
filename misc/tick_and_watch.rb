require 'beanstalk-client'
require 'stalker'

Split_Size = 10.0

tick_complete_stalk = Beanstalk::Pool.new(['localhost:11300'], 'turtle.tick.complete')

w = World.last
turtle_count = w.turtles.count

ProgressBar.color_status
ProgressBar.iter_rate_mode

def split_turtles_for_world(world)
  x_min = 0
  x_max = world.width
  x_split_size = (x_max - x_min) / Split_Size
  y_min = 0
  y_max = world.height
  y_split_size = (y_max - y_min) / Split_Size
  
  ret = []
  
  Split_Size.to_i.times do |x_iter|
    x_left = x_min + x_iter * x_split_size
    x_right = x_left + x_split_size
    Split_Size.to_i.times do |y_iter|
      y_bottom = y_min + y_iter * y_split_size
      y_top = y_bottom + y_split_size
      
      turtles = Turtle.all_of(:world_id=>world.id,  :_x.gte => x_left, :_x.lt => x_right, :_y.gte => y_bottom, :_y.lt => y_top)
      ret << turtles.map { |t| t.id }
    end
  end
  ret
end

def enqueue(turtle_lists)
  turtle_lists.each do |tl|
    #puts "Would have enqueued: #{tl}"  
    Stalker.enqueue('batch.tick', :turtle_ids => tl)
  end
end

10.times do |clock|
  pb = ProgressBar.new("Tick #{clock}", turtle_count)
  #Stalker.enqueue('world.tick', :world_id => w.id)
  enqueue split_turtles_for_world w
  turtle_count.times do
    job = tick_complete_stalk.reserve
    job.delete
    pb.inc
  end
  pb.finish
end