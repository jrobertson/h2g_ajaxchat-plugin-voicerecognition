#!/usr/bin/env ruby

# file: h2g_ajaxchat-plugin-voicerecognition.rb

# description: Used with the h2g_ajaxchat gem to facilitate voice input to text.


class AjaxChatPluginVoiceRecognition

  def initialize(settings)
    @lang = settings[:lang] || 'en-GB'
  end

  def apply(ac)

    html = ac.views[:index].html

    a = html.lines
    r = a.grep /<input name="usermsg"/
    i = a.index(r.first)
    a2 = a.insert i+1, "<button id='start-button'>Start Listening</button>\n"
    ac.views[:index].html = a2.join

    ac.views[:index].js = ac.views[:index].js + js()

  end

  private

  def js()
<<EOF
// voice recognition

  function startListening() {
    var recognition = new (webkitSpeechRecognition || SpeechRecognition)();
    recognition.lang = '#{@lang}';
    recognition.interimResults = false;
    recognition.maxAlternatives = 1;
    recognition.start();

    [
     'onaudiostart',
     'onaudioend',
     'onend',
     'onerror',
     'onnomatch',
     'onresult',
     'onsoundstart',
     'onsoundend',
     'onspeechend',
     'onstart'
    ].forEach(function(eventName) {
      recognition[eventName] = function(e) {
        console.log(eventName, e);
      };
    });

    document.querySelector('#start-button').innerHTML = 'Listening...';

    recognition.onend = function() {
      document.querySelector('#start-button').innerHTML = 'Start Listening';
    };
    recognition.onresult = function() {
      e = document.querySelector('#usermsg');
      e.value = event.results[0][0].transcript;
      ajaxRequest('chatter?msg=' + e.value, ajaxResponse1)
      e.value = '';
    };
  };

  (function() {
    document.querySelector('#start-button').addEventListener('click', startListening);
  })();

EOF
  end
end

