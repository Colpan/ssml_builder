module SsmlBuilder

  class Builder
    attr_reader :ssml_content

    def initialize
      @ssml_content = ""
    end

    def say(string)
      space_precheck
      @ssml_content += remove_characters(string)
    end

    def paragraph(string)
      @ssml_content += "<p>" + remove_characters(string) + "</p>"
    end

    def p(string)
      # ALIAS for paragraph
      paragraph(string)
    end

    def sentence(string)
      @ssml_content += "<s>" + remove_characters(string) + "</s>"
    end

    def rate(string,rate = "medium")
      space_precheck
      if !["x-slow", "slow", "medium", "fast", "x-fast"].include?(rate)
        rate = (rate.to_i > 20 ? rate.to_i : 20).to_s + "%"
      end
      @ssml_content += "<prosody rate=\"" + rate + "\">" + remove_characters(string) + "</prosody>"
    end

    def pitch(string,pitch = "medium")
      space_precheck
      if !["x-low", "low", "medium", "high", "x-high"].include?(pitch)
        pitch = pitch.to_f > -33.3 ? pitch.to_f : -33.3
        pitch = (pitch.to_f < 50.0 ? pitch : 50.0)
        pitch = pitch > 0 ? "+%g%" % ("%.2f" % pitch) : "%g%" % ("%.2f" % pitch)
      end
      @ssml_content += "<prosody pitch=\"" + pitch + "\">" + remove_characters(string) + "</prosody>"
    end

    def volume(string,volume = "medium")
      space_precheck
      if !["silent", "x-soft", "soft", "medium", "loud", "x-loud"].include?(volume)
        volume = volume.to_f < 4.08 ? volume.to_f : 4.08
        volume = volume > 0 ? "+%gdB" % ("%.2f" % volume) : "%gdB" % ("%.2f" % volume)
      end
      @ssml_content += "<prosody volume=\"" + volume + "\">" + remove_characters(string) + "</prosody>"
    end

    def prosody
      # UNKOWN HOW I WANT TO USE
    end

    def pause(length = "medium")
      space_precheck
      if ["none", "x-weak", "weak", "medium", "strong", "x-strong"].include?(length.downcase)
        @ssml_content += "<break strength=\"" + length.downcase + "\"/>"
      else
        @ssml_content += "<break time=\"" + length + "\"/>"
      end
    end

    def emphasis(string,level = "moderate")
      space_precheck
      @ssml_content += "<emphasis level=\"" + level + "\">" + string + "</emphasis>"
    end

    def audio(url)
      space_precheck
      @ssml_content += "<audio src=\"" + url + "\"/>"
    end

    def spell_out(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"spell-out\">" + string + "</say-as>"
    end

    def characters(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"characters\">" + string + "</say-as>"
    end

    def cardinal(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"cardinal\">" + string + "</say-as>"
    end

    def number(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"number\">" + string + "</say-as>"
    end

    def ordinal(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"ordinal\">" + string + "</say-as>"
    end

    def digits(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"digits\">" + string + "</say-as>"
    end

    def fraction(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"fraction\">" + string + "</say-as>"
    end

    def unit(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"unit\">" + string.gsub(/ /,'') + "</say-as>"
    end

    def date(year = nil, month = nil, day = nil)
      space_precheck
      year = year.nil? ? "????" : year.to_s
      month = month.nil? ? "??" : month.to_s.rjust(2, '0')
      day = day.nil? ? "??" : day.to_s.rjust(2, '0')
      @ssml_content += "<say-as interpret-as=\"date\">" + year + month + day + "</say-as>"
    end

    def time(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"time\">" + string + "</say-as>"
    end

    def telephone(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"telephone\">" + string + "</say-as>"
    end

    def phone(string)
      # ALIAS of telephone
      telephone(string)
    end

    def address(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"address\">" + string + "</say-as>"
    end

    def interjection(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"interjection\">" + string + "</say-as>"
    end

    def expletive(string)
      space_precheck
      @ssml_content += "<say-as interpret-as=\"expletive\">" + string + "</say-as>"
    end

    def sub(string,alias_str)
      space_precheck
      @ssml_content += "<sub alias=\"" + alias_str + "\">" + string + "</sub>"
    end

    def whisper(string)
      if !string.nil? && !string.empty?
        space_precheck
        @ssml_content += "<amazon:effect name=\"whispered\">" + string + "</amazon:effect>"
      end
    end

    def amazon_verb(string)
      space_precheck
      @ssml_content += "<w role=\"amazon:VB\">" + string + "</w>"
    end

    def amazon_participle(string)
      space_precheck
      @ssml_content += "<w role=\"amazon:VBD\">" + string + "</w>"
    end

    def amazon_noun(string)
      space_precheck
      @ssml_content += "<w role=\"amazon:NN\">" + string + "</w>"
    end

    def amazon_sense(string,sense = 1)
      space_precheck
      @ssml_content += "<w role=\"SENSE_" + sense.to_s + "\">" + string + "</w>"
    end

    def phoneme(string,alphabet = "ipa",ph = "")
      space_precheck
      @ssml_content += "<phoneme alphabet=\"" + alphabet + "\" ph=\"" + ph + "\">" + string + "</phoneme>"
    end

    def ssml
      return "<speak>" + @ssml_content + "</speak>"
    end

    private

      def remove_characters(string)
        return string.gsub(/['"`]/,'')
      end

      def space_precheck
        if !@ssml_content.empty? && @ssml_content[-1] != " "
          @ssml_content += " "
        end
      end

  end

end
