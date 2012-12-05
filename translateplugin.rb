# @@secret = "AIzaSyC9WJWahqesZMN7gnrbVRbJlvaarr29-NY"

# require 'rubygems'
# require 'httpclient'


# module Google
#   module Language
#     Languages = {
#       'af' => 'AFRIKAANS',
#       'sq' => 'ALBANIAN',
#       'am' => 'AMHARIC',
#       'ar' => 'ARABIC',
#       'hy' => 'ARMENIAN',
#       'az' => 'AZERBAIJANI',

#       'eu' => 'BASQUE',
#       'be' => 'BELARUSIAN',
#       'bn' => 'BENGALI',
#       'bh' => 'BIHARI',
#       'bg' => 'BULGARIAN',
#       'my' => 'BURMESE',

#       'ca' => 'CATALAN',
#       'chr' => 'CHEROKEE',
#       'zh' => 'CHINESE',
#       'zh-CN' => 'CHINESE_SIMPLIFIED',
#       'zh-TW' => 'CHINESE_TRADITIONAL',
#       'hr' => 'CROATIAN',
#       'cs' => 'CZECH',

#       'da' => 'DANISH',
#       'dv' => 'DHIVEHI',
#       'nl' => 'DUTCH',

#       'en' => 'ENGLISH',
#       'eo' => 'ESPERANTO',
#       'et' => 'ESTONIAN',

#       'tl' => 'FILIPINO',
#       'fi' => 'FINNISH',
#       'fr' => 'FRENCH',

#       'gl' => 'GALICIAN',
#       'ka' => 'GEORGIAN',
#       'de' => 'GERMAN',
#       'el' => 'GREEK',
#       'gn' => 'GUARANI',
#       'gu' => 'GUJARATI',

#       'iw' => 'HEBREW',
#       'hi' => 'HINDI',
#       'hu' => 'HUNGARIAN',

#       'is' => 'ICELANDIC',
#       'id' => 'INDONESIAN',
#       'iu' => 'INUKTITUT',
#       'it' => 'ITALIAN',

#       'ja' => 'JAPANESE',

#       'kn' => 'KANNADA',
#       'kk' => 'KAZAKH',
#       'km' => 'KHMER',
#       'ko' => 'KOREAN',
#       'ku' => 'KURDISH',
#       'ky' => 'KYRGYZ',

#       'lo' => 'LAOTHIAN',
#       'lv' => 'LATVIAN',
#       'lt' => 'LITHUANIAN',

#       'mk' => 'MACEDONIAN',
#       'ms' => 'MALAY',
#       'ml' => 'MALAYALAM',
#       'mt' => 'MALTESE',
#       'mr' => 'MARATHI',
#       'mn' => 'MONGOLIAN',

#       'ne' => 'NEPALI',
#       'no' => 'NORWEGIAN',

#       'or' => 'ORIYA',

#       'ps' => 'PASHTO',
#       'fa' => 'PERSIAN',
#       'pl' => 'POLISH',
#       'pt-PT' => 'PORTUGUESE',
#       'pa' => 'PUNJABI',

#       'ro' => 'ROMANIAN',
#       'ru' => 'RUSSIAN',

#       'sa' => 'SANSKRIT',
#       'sr' => 'SERBIAN',
#       'sd' => 'SINDHI',
#       'si' => 'SINHALESE',
#       'sk' => 'SLOVAK',
#       'sl' => 'SLOVENIAN',
#       'es' => 'SPANISH',
#       'sw' => 'SWAHILI',
#       'sv' => 'SWEDISH',

#       'tg' => 'TAJIK',
#       'ta' => 'TAMIL',
#       'tl' => 'TAGALOG',
#       'te' => 'TELUGU',
#       'th' => 'THAI',
#       'bo' => 'TIBETAN',
#       'tr' => 'TURKISH',

#       'uk' => 'UKRAINIAN',
#       'ur' => 'URDU',
#       'uz' => 'UZBEK',
#       'ug' => 'UIGHUR',

#       'vi' => 'VIETNAMESE',

#       '' => 'UNKNOWN'
#     }

#     # judge whether the language is supported by google translate
#     def supported?(language)
#       if Languages.key?(language) || Languages.value?(language.upcase)
#         true
#       else
#         false
#       end
#     end
#     module_function :supported?

#     # get the abbrev of the language
#     def abbrev(language)
#       if supported?(language)
#         if Languages.key?(language)
#           language
#         else
#           language.upcase!
#           Languages.each do |k,v|
#             if v == language
#               return k
#             end
#           end
#         end
#       else
#         nil
#       end
#     end
#     module_function :abbrev
#   end
# end


# module Translate
#   class UnsupportedLanguagePair < StandardError
#   end

#   class RTranslate
#     # Google AJAX Language REST Service URL
#     GOOGLE_TRANSLATE_URL = "https://www.googleapis.com/language/translate/v2"  #"http://ajax.googleapis.com/ajax/services/language/translate"

#     # Default version of Google AJAX Language API
#     DEFAULT_VERSION = "2"

#     attr_reader :version, :key
#     attr_reader :default_from, :default_to

#     class << self
#       def translate(text, from, to, key)
#         RTranslate.new.translate(text, { :from => from, :to => to , :key => key})
#       end
#       alias_method :t, :translate

#       def translate_strings(text_array, from, to)
#         RTranslate.new.translate_strings(text_array, {:from => from, :to => to})
#       end

#       def translate_string_to_languages(text, options)
#         RTranslate.new.translate_string_to_languages(text, options)
#       end

#       def batch_translate(translate_options)
#         RTranslate.new.batch_translate(translate_options)
#       end
#     end

#     def initialize(version = DEFAULT_VERSION, key = nil, default_from = nil, default_to = nil)
#       @version = version
#       @key = key
#       @default_from = default_from
#       @default_to = default_to

#       if @default_from && !(Google::Language.supported?(@default_from))
#         raise StandardError, "Unsupported source language '#{@default_from}'"
#       end

#       if @default_to && !(Google::Language.supported?(@default_to))
#         raise StandardError, "Unsupported destination language '#{@default_to}'"
#       end
#     end

#     # translate the string from a source language to a target language.
#     #
#     # Configuration options:
#     # * <tt>:from</tt> - The source language
#     # * <tt>:to</tt> - The target language
#     # * <tt>:userip</tt> - The IP address of the end-user on whose behalf the request is being made
#     def translate(text, options = { })
#       from = options[:from] || @default_from
#       to = options[:to] || @default_to
#       if (from.nil? || Google::Language.supported?(from)) && Google::Language.supported?(to)
#         from = from ? Google::Language.abbrev(from) : nil
#         to = Google::Language.abbrev(to)

#         text.mb_chars.scan(/(.{1,300})/).flatten.inject("") do |result, st|
#           url = "#{GOOGLE_TRANSLATE_URL}?q=#{CGI.escape(st.to_s)}&source=#{CGI.escape(from)}&target=#{CGI.escape(to)}"
#           url << "&key=#{@key || options[:key]}" if @key || options[:key]
#           url << "&userip=#{options[:userip]}" if options[:userip]
          
#           result += CGI.unescapeHTML(do_translate(url))
#         end
#       else
#         raise UnsupportedLanguagePair, "Translation from '#{from}' to '#{to}' isn't supported yet!"
#       end
#     end

#     # translate several strings, all from the same source language to the same target language.
#     #
#     # Configuration options
#     # * <tt>:from</tt> - The source language
#     # * <tt>:to</tt> - The target language
#     def translate_strings(text_array, options = { })
#       text_array.collect do |text|
#         self.translate(text, options)
#       end
#     end

#     # Translate one string into several languages.
#     #
#     # Configuration options
#     # * <tt>:from</tt> - The source language
#     # * <tt>:to</tt> - The target language list
#     # Example:
#     #
#     # translate_string_to_languages("China", {:from => "en", :to => ["zh-CN", "zh-TW"]})
#     def translate_string_to_languages(text, option)
#       option[:to].collect do |to|
#         self.translate(text, { :from => option[:from], :to => to })
#       end
#     end

#     # Translate several strings, each into a different language.
#     #
#     # Examples:
#     #
#     # batch_translate([["China", {:from => "en", :to => "zh-CN"}], ["Chinese", {:from => "en", :to => "zh-CN"}]])
#     def batch_translate(translate_options)
#       translate_options.collect do |text, option|
#         self.translate(text, option)
#       end
#     end

#     private
#     def do_translate(url) #:nodoc:
#       clnt = HTTPClient.new
#       jsondoc = clnt.get_content(url)
# #      jsondoc = Net::HTTP.get(URI.parse(url))
#       response = JSON.parse(jsondoc)
#       #puts response.inspect
#       response["data"]["translations"][0]["translatedText"]
#     rescue Exception => e
#       raise StandardError, e.message
#     end
#   end
# end


class TranslatePlugin
  include Purugin::Plugin
  description( 'Translate', 0.3 )
  
#  include Translate

  def translate(message)
#      `rtranslate  \"#{message}\" -f fr -t en -k #{@@secret}`
#      RTranslate.translate(message, 'en', 'fr')
  end

  def on_enable

    event(:async_player_chat) do |e|
#      puts translate(e.message)
    end
  end
end
