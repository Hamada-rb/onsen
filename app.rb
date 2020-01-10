require 'ovto'
require 'json'

class MyApp < Ovto::App
  class State < Ovto::State
    item :word, default: ""
    item :onsen, default: [
      {
        name: "旭温泉あさひ荘",
        address: "〒697-0427 島根県浜田市旭町木田９５４−３",
        url: "http://asahionsen.net/selected/",
        showable: true   
      },
      {
        name: "美又温泉会館",
        address: "697-0301 島根県浜田市金城町追原11番乙地",
        url: "http://www.kankou-hamada.org/modules/guide/index.php?action=SpotView&spot_id=1043",
        showable: true
      }
    ]
  end

  class Actions < Ovto::Actions
    def set_word(word:)
      { word: word }
    end

    def search(word:)
      result = state.onsen.map{|onsen|
        o = onsen
        if o["name"].include?(word)
          o["showable"] = true
        else
          o["showable"] = false
        end
        o
      }
      { onsen: result }
    end
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

  class Onsens < Ovto::Component
    def render(onsens:)
      o 'div.row' do
        onsens.each do |onsen|
          if onsen["showable"]
            o 'div.col', style: {width: '100%'} do
              o 'div.card' do
                o 'div.card-content.white-text' do
                  o 'span.card-title', onsen["name"]
                  o 'p', onsen["address"]
                  o 'div.card-action' do
                    o 'a', { href: onsen["url"] }, "Webサイトへ"
                  end
                end
              end
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
            o 'div.container' do
                o 'h1.center-align', 'Hamada Onsen Map'
                o 'input', { type: 'text', onchange: ->(e){ actions.set_word(word: e.target.value) }, value: state.word}
                o 'span.center-align' do
                  o 'div.link-btn' do
                    o 'a.btn', { onclick: ->(e){ actions.search(word: state.word)}}, "search"
                  end
                end
                o Onsens, onsens: state.onsen
            end
        end
    end
  end
end

MyApp.run(id: 'ovto')