# How to use the h2g_ajaxchat-plugin-voicerecognition gem


Usage:

    require 'h2g_ajaxchat'
    require 'h2g_ajaxchat-plugin-voicerecognition'


    conf = '
    VoiceRecognition:
      lang: en-US
    '

    ac = AjaxChat.new(ChatCore.new, config: conf)

In the above example the voice recognition plugin is applied to AJAX chat index page which includes a button to set the microphone to listening mode, including the JavaScript to transcribe the text result into the input box.

## Resources

* h2g_ajaxchat-plugin-voicerecognition https://rubygems.org/gems/h2g_ajaxchat-plugin-voicerecognition

ajax chat ajaxchat plugin gem h2gajaxchat voice voicerecognition

