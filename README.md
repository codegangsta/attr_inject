# attr\_inject

attr\_inject is an small and elegant dependency injection solution for Ruby.

#Installation
`gem install attr_inject`

# Usage
attr\_inject can be used many ways scaling from the least inrtusive to more inrusive options. 

## Simple Example
Dependencies are injected via a Hash through the Object's constructor.

~~~ ruby
class Application
  
  # initialize our dependencies
  driver = Driver.new
  passenger = Passenger.new

  # inject our dependencies into our Car object
  car = Car.new :driver => driver, :passenger => passenger

end
~~~

~~~ ruby
class Car
  attr_inject :driver
  attr_inject :passenger

  def initialize(options)
    inject_attributes options
  end

end
~~~

## Injector Example
For more inversion of control, an Injector can be used.

~~~ ruby
class Application
  include Inject

  # Map our depedencies
  injector = Injector.new
  injector.map :driver, Driver.new
  injector.map :passenger, Passenger.new

  # Inject our dependencies into our car object
  car = Car.new
  injector.apply(car)

end
~~~

~~~ ruby
class Car
  attr_inject :driver
  attr_inject :passenger
end
~~~

## Factory Example
Create an Injector to map objects and factories to.

~~~ ruby
require "attr_inject"

class Application
  include Inject

  # Map our depedencies
  injector = Injector.new
  injector.map :driver, Driver.new
  injector.map :passenger, Passenger.new

  # Factory dependencies are called
  # on each inject and are passed it's
  # target object
  injector.factory :logger do |target|
    Logger.new(target)
  end

  # Inject our dependencies into our car object
  car = Car.new
  injector.apply(car)

end
~~~

Our car object explicitly defines what dependencies it wants.

~~~ ruby
class Car

  attr_inject :driver
  attr_inject :passenger
  attr_inject :logger

end
~~~
