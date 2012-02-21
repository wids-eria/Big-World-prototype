w = World.last


puts "Making circlers"

ProgressBar.color_status
ProgressBar.iter_rate_mode

pb = ProgressBar.new("Turtle", 20000)
1000.times do 
  t = SpacerTurtle.new
  t.world = w
  t.x = rand(w.width)
  t.y = rand(w.height)
  t.heading = rand(360)
  t.save!
  pb.inc
end
pb.finish

puts "World id = #{w.id}"
