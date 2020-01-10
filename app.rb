require 'ovto'

class MyApp < Ovto::App
  class State < Ovto::State
  end

  class Actions < Ovto::Actions
  end

  class Header < Ovto::Component
    def render
        o 'nav' do
            o 'div.nav-wrapper' do
                o 'a.brand-logo', 'Hamada Onsen Map'
                o 'ul#nav-mobile.right hide-on-med-and-down' do
                    o 'li' do
                        o 'a', {href: 'https://github.com/Hamada-rb/onsen'}, 'GitHub'
                    end
                end
            end
        end
    end
  end

  class MainComponent < Ovto::Component
    def render
        o 'div' do
            o Header
            o 'h1', 'Hamada Onsen Map'
        end
    end
  end
end

MyApp.run(id: 'ovto')