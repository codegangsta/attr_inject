# attr\_inject

attr\_inject is an small and elegant dependency injection solution for Ruby.

#Intallation

# Usage

Create an Injector to map objects and factories to.

~~~ ruby
require "attr\_inject"

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

  attr\_inject :driver
  attr\_inject :passenger
  attr\_inject :driver

end
~~~
