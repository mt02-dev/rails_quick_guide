### 解決したい事
 Docker + rails + postgresqlの環境でrspecのsystemtestを行いたいのですが   
 何が原因か検討がつかないため、質問させてください。   
 また、根本的に私が行いたいことは現実的なことであるのかも含めてお教えいただきたいです。   
 今回Ruby on Railsの速習実践ガイドを実施する中でDocker環境で進めてみようと試み、   
 本リポジトリのような環境を作成しました。また、調査する中でchromeのバージョンと   
 driverとchromeのバージョンが異なると動作しないという記載もあり、   
 chromeのstable版とchrome-driverのstable版のバージョンが異なることがわかり揃える方法を   
 調査しましたが、揃える方法がわかりませんでした。   
 また、115以降chromeとdriverが統合されたと読み取れたため、google-chrome-stableを入れない状態で実施、   
 driverではなくchrome-headless-shellを入れるなど行いましたが解決に至りませんでした。   

```sh
# google-chrome-stable
apt list -a 'google-chrome-stable'
Listing... Done
google-chrome-stable/stable,now 120.0.6099.224-1 amd64 [installed]

# chrome-driver
curl -sS https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_STABLE && echo
120.0.6099.109
```


### 今、起きている事
Docker 環境でsystemテストを実施しようとして以下のようにエラーメッセージが表示されている   
```   
 selenium::webdriver::error::sessionnotcreatederror:
            session not created: chrome failed to start: exited normally.
              (session not created: devtoolsactiveport file doesn't exist)
              (the process started from chrome location /opt/google/chrome/chrome is no longer running, so chromedriver is assuming that chrome has crashed.)
          # #0 0x560ef710af83 <unknown>
          # #1 0x560ef6dc3cf7 <unknown>
          # #2 0x560ef6dfb60e <unknown>
          # #3 0x560ef6df826e <unknown>
          # #4 0x560ef6e4880c <unknown>
          # #5 0x560ef6e3ce53 <unknown>
          # #6 0x560ef6e04dd4 <unknown>
          # #7 0x560ef6e061de <unknown>
          # #8 0x560ef70cf531 <unknown>
          # #9 0x560ef70d3455 <unknown>
          # #10 0x560ef70bbf55 <unknown>
          # #11 0x560ef70d40ef <unknown>
          # #12 0x560ef709f99f <unknown>
          # #13 0x560ef70f8008 <unknown>
          # #14 0x560ef70f81d7 <unknown>
          # #15 0x560ef710a124 <unknown>
          # #16 0x7f041c3bf044 <unknown>
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/remote/response.rb:55:in `assert_ok'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/remote/response.rb:34:in `initialize'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/remote/http/common.rb:83:in `new'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/remote/http/common.rb:83:in `create_response'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/remote/http/default.rb:103:in `request'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/remote/http/common.rb:59:in `call'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/remote/bridge.rb:601:in `execute'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/remote/bridge.rb:53:in `create_session'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/common/driver.rb:317:in `block in create_bridge'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/common/driver.rb:316:in `create_bridge'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/common/driver.rb:74:in `initialize'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/chrome/driver.rb:35:in `initialize'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/common/driver.rb:47:in `new'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver/common/driver.rb:47:in `for'
          # /usr/local/bundle/gems/selenium-webdriver-4.16.0/lib/selenium/webdriver.rb:89:in `for'
          # /usr/local/bundle/gems/capybara-3.39.2/lib/capybara/selenium/driver.rb:83:in `browser'
          # /usr/local/bundle/gems/capybara-3.39.2/lib/capybara/session.rb:105:in `driver'
          # /usr/local/bundle/gems/capybara-3.39.2/lib/capybara/session.rb:91:in `initialize'
          # /usr/local/bundle/gems/capybara-3.39.2/lib/capybara.rb:421:in `new'
          # /usr/local/bundle/gems/capybara-3.39.2/lib/capybara.rb:421:in `block in session_pool'
          # /usr/local/bundle/gems/capybara-3.39.2/lib/capybara.rb:317:in `current_session'
          # /usr/local/bundle/gems/capybara-3.39.2/lib/capybara/dsl.rb:46:in `page'
          # /usr/local/bundle/gems/capybara-3.39.2/lib/capybara/dsl.rb:52:in `visit'
          # ./spec/system/tasks_spec.rb:17:in `block (4 levels) in <top (required)>'
```

### 調べた事
* Rails + postgres + chromedriverのdocker-compose環境を作る   
https://qiita.com/mh4gf/items/e6e4551bcae0fb745ee8   
https://qiita.com/ngron/items/f61b8635b4d67f666d75   
* Debianにgoogle-chrome-stableをインストールする   
https://www.linuxcapable.com/how-to-install-google-chrome-on-debian-linux/   

* chrome version 115以降について
https://zenn.dev/route06/articles/78c30c6627a932   
https://chromedriver.chromium.org/downloads/version-selection

* chrome-for-testingの安定版について   
https://googlechromelabs.github.io/chrome-for-testing/

