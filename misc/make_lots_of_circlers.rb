w = World.new 
w.width = 400
w.height = 400
w.save!

puts "Initializing Patches"
w.initialize_patches


puts "Making circlers"

ProgressBar.color_status
ProgressBar.iter_rate_mode

pb = ProgressBar.new("Turtle", 20000)
20000.times do 
  t = CirclerTurtle.new
  t.world = w
  t.x = rand(w.width)
  t.y = rand(w.height)
  t.heading = rand(360)
  t.save!
  pb.inc
end
pb.finish

puts "World id = #{w.id}"
