require "rulers/version"
require "rulers/routing"
require "rulers/array"

module Rulers
  class Application
    def call(env)
      `echo debug > debug.txt`;

      begin
        if env['PATH_INFO'] == '/favicon.ico'
          return [404, {'Content-Type' => 'text/html'}, []]
        end

        klass, act = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(act)
        [200, {'Content-Type' => 'text/html'}, [text]]
      rescue
        [500, {'Content-Type' => 'text/html'}, ["It's is a bad route!"]]
      end
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
