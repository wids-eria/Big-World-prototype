class Turtle
  include Mongoid::Document
  include Mongoid::Spacial::Document
  include LocativeDocumentInWorld
  
  field :heading, type: Float, default: 0
  
  before_save :wrap_heading
  
  def wrap_heading
    self.heading = self.heading % 360
  end
  
  def forward(distance)
    self.x += distance * Math::cos( Turtle.degrees_to_radians self.heading )
    self.y += distance * Math::sin( Turtle.degrees_to_radians self.heading )
    
    world = self.world
    
    while self.x > world.width
      self.x = self.x - world.width
    end
    
    while self.y > world.height
      self.y = self.y - world.height
    end
  end
  
  def turn_right(degrees)
    self.heading -= degrees
  end
  
  def turn_left(degrees)
    turn_right(0-degrees)
  end
  
  def tick
  end
  
  def do_tick
    tick
    save_with_reshard!
  end
  
  def self.degrees_to_radians(degrees)
    (degrees/180.0)*Math::PI
  end


  
end