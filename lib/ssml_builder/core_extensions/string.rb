module SsmlBuilder::String

  def ssml_say
    return ssml_remove_special_characters(self)
  end

  def ssml_paragraph
    return "<p>" + ssml_remove_special_characters(self) + "</p>"
  end

  def ssml_p
    # ALIAS for paragraph
    return self.ssml_paragraph
  end

  def ssml_sentence
    return "<s>" + ssml_remove_special_characters(self) + "</s>"
  end

  def ssml_rate(rate = "medium")
    if !["x-slow", "slow", "medium", "fast", "x-fast"].include?(rate)
      rate = (rate.to_i > 20 ? rate.to_i : 20).to_s + "%"
    end
    return "<prosody rate=\"" + rate + "\">" + ssml_remove_special_characters(self) + "</prosody>"
  end

  def ssml_pitch(pitch = "medium")
    if !["x-low", "low", "medium", "high", "x-high"].include?(pitch)
      pitch = pitch.to_f > -33.3 ? pitch.to_f : -33.3
      pitch = (pitch.to_f < 50.0 ? pitch : 50.0)
      pitch = pitch > 0 ? "+%g%" % ("%.2f" % pitch) : "%g%" % ("%.2f" % pitch)
    end
    return "<prosody pitch=\"" + pitch + "\">" + ssml_remove_special_characters(self) + "</prosody>"
  end

  def ssml_volume(volume = "medium")
    if !["silent", "x-soft", "soft", "medium", "loud", "x-loud"].include?(volume)
      volume = volume.to_f < 4.08 ? volume.to_f : 4.08
      volume = volume > 0 ? "+%gdB" % ("%.2f" % volume) : "%gdB" % ("%.2f" % volume)
    end
    return "<prosody volume=\"" + volume + "\">" + ssml_remove_special_characters(self) + "</prosody>"
  end

  def ssml_prosody
    # UNKOWN HOW I WANT TO USE
  end

  def ssml_pause(length = "medium")
    if ["none", "x-weak", "weak", "medium", "strong", "x-strong"].include?(length.downcase)
      return "<break strength=\"" + length.downcase + "\"/>"
    else
      return "<break time=\"" + length + "\"/>"
    end
  end

  def ssml_break(length = "medium")
    # ALIAS for ssml_pause
    return self.ssml_pause(length)
  end

  def ssml_emphasis(level = "moderate")
    return "<emphasis level=\"" + level + "\">" + self + "</emphasis>"
  end

  def ssml_audio
    return "<audio src=\"" + self + "\"/>"
  end

  def ssml_spell_out
    return "<say-as interpret-as=\"spell-out\">" + self + "</say-as>"
  end

  def ssml_characters
    return "<say-as interpret-as=\"characters\">" + self + "</say-as>"
  end

  def ssml_cardinal
    return "<say-as interpret-as=\"cardinal\">" + self + "</say-as>"
  end

  def ssml_number
    return "<say-as interpret-as=\"number\">" + self + "</say-as>"
  end

  def ssml_ordinal
    return "<say-as interpret-as=\"ordinal\">" + self + "</say-as>"
  end

  def ssml_digits
    return "<say-as interpret-as=\"digits\">" + self + "</say-as>"
  end

  def ssml_fraction
    return "<say-as interpret-as=\"fraction\">" + self + "</say-as>"
  end

  def ssml_unit
    return "<say-as interpret-as=\"unit\">" + self.gsub(/ /,'') + "</say-as>"
  end

  def ssml_date
    return "<say-as interpret-as=\"date\">" + self + "</say-as>"
  end

  def ssml_time
    return "<say-as interpret-as=\"time\">" + self + "</say-as>"
  end

  def ssml_telephone
    return "<say-as interpret-as=\"telephone\">" + self + "</say-as>"
  end

  def ssml_phone
    # ALIAS of telephone
    return self.ssml_telephone
  end

  def ssml_address
    return "<say-as interpret-as=\"address\">" + self + "</say-as>"
  end

  def ssml_interjection
    return "<say-as interpret-as=\"interjection\">" + self + "</say-as>"
  end

  def ssml_expletive
    return "<say-as interpret-as=\"expletive\">" + self + "</say-as>"
  end

  def ssml_sub(alias_str)
    return "<sub alias=\"" + alias_str + "\">" + self + "</sub>"
  end

  def ssml_whisper
    return "<amazon:effect name=\"whispered\">" + self + "</amazon:effect>"
  end

  def ssml_amazon_verb
    return "<w role=\"amazon:VB\">" + self + "</w>"
  end

  def ssml_amazon_participle
    return "<w role=\"amazon:VBD\">" + self + "</w>"
  end

  def ssml_amazon_noun
    return "<w role=\"amazon:NN\">" + self + "</w>"
  end

  def ssml_amazon_sense(sense = 1)
    return "<w role=\"SENSE_" + sense.to_s + "\">" + self + "</w>"
  end

  def ssml_phoneme(alphabet = "ipa",ph = "")
    return "<phoneme alphabet=\"" + alphabet + "\" ph=\"" + ph + "\">" + self + "</phoneme>"
  end

  def to_ssml
    return "<speak>" + self + "</speak>"
  end

  private

    def ssml_remove_special_characters(string)
      return string.gsub(/['"`]/,'')
    end
end

class String
  include SsmlBuilder::String
end
