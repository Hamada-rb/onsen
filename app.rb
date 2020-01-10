require 'ovto'

class MyApp < Ovto::App
  class State < Ovto::State
  end

  class Actions < Ovto::Actions
  end

  class MainComponent < Ovto::Component
    def render
        o 'h1', 'Hamada Onsen Map'
    end
  end
end

MyApp.run(id: 'ovto')