require 'ovto'
require 'json'

class MyApp < Ovto::App
  class State < Ovto::State
    item :onsen, default: [
      {
          name: "旭温泉あさひ荘",
          address: "〒697-0427 島根県浜田市旭町木田９５４−３",
          about: "【営業時間】9時～20時／【定休日】毎週水曜日【その他ご案内】当施設は日帰りのみです※宿泊はできません",
          url: "http://asahionsen.net/selected/"   
      }
    ]
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

  class Onsens < Ovto::Component
    def render(onsens:)
      o 'div.row' do
        onsens.each do |onsen|
          o 'div.col', style: {width: '100%'} do
            o 'div.card' do
              o 'div.card-content.white-text' do
                o 'span.card-title', onsen["name"]
                o 'p', onsen["address"]
                o 'p', onsen["about"]
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

  class MainComponent < Ovto::Component
    def render
        o 'div' do
            o Header
            o 'div.container' do
                o 'h1.center-align', 'Hamada Onsen Map'
                o Onsens, onsens: state.onsen
            end
        end
    end
  end
end

MyApp.run(id: 'ovto')