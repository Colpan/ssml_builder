require 'rspec'
require 'ssml_builder'

describe 'Using the string based ssml builder' do

  describe "creating ssml string" do

    context "on say" do
      it "properly generates ssml string" do
        speech = "Hello there!".ssml_say
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak>Hello there!</speak>")
      end

      it "should escape any quotes or apostrophes" do
        speech = "How's it going?".ssml_say
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak>Hows it going?</speak>")
        speech = 'How"s it going?'.ssml_say
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak>Hows it going?</speak>")
      end
    end

    context "on paragraph" do
      it "should appropriate paragraph tags in ssml response" do
        speech = "Hello how are you doing this fine day?".ssml_paragraph
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><p>Hello how are you doing this fine day?</p></speak>")
      end

      it "should escape any apostrophes or quotes" do
        speech = "How's it going?".ssml_paragraph
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><p>Hows it going?</p></speak>")
        speech = 'How"s it going?'.ssml_paragraph
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><p>Hows it going?</p></speak>")
      end

      it "should work with alias p" do
        speech = "Hello how are you doing this fine day?".ssml_p
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><p>Hello how are you doing this fine day?</p></speak>")
      end
    end

    context "on sentence" do
      it "should appropriate sentence tags in ssml response" do
        speech = "Hello how are you doing this fine day?".ssml_sentence
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><s>Hello how are you doing this fine day?</s></speak>")
      end

      it "should escape any apostrophes or quotes" do
        speech = "How's it going?".ssml_sentence
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><s>Hows it going?</s></speak>")
        speech = 'How"s it going?'.ssml_sentence
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><s>Hows it going?</s></speak>")
      end
    end

    context "on rate" do
      it "should set the rate of speech with integer" do
        speech = "Text".ssml_rate(90)
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody rate=\"90%\"/>Text</speak>")
      end

      it "should set the rate of speech with number string without %" do
        speech = SsmlBuilder::Builder.new
        speech = "Text".ssml_rate("90")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody rate=\"90%\"/>Text</speak>")
      end

      it "should set the rate of speech with number string with %" do
        speech = "Text".ssml_rate("90%")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody rate=\"90%\"/>Text</speak>")
      end

      it "should have a minimum of 20%" do
        speech = "Text".ssml_rate("10%")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody rate=\"20%\"/>Text</speak>")
      end

      it "should also accept text based rates" do
        speech = "Text".ssml_rate("medium")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody rate=\"medium\"/>Text</speak>")
      end
    end

    context "on pitch" do
      it "should set the pitch of speech with integer" do
        speech = "Text".ssml_pitch(30)
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody pitch=\"+30%\"/>Text</speak>")
      end

      it "should set the pitch of speech with number string without %" do
        speech = "Text".ssml_pitch("-30")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody pitch=\"-30%\"/>Text</speak>")
      end

      it "should set the pitch of speech with number string with %" do
        speech = "Text".ssml_pitch("30%")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody pitch=\"+30%\"/>Text</speak>")
      end

      it "should have a minimum of -33.3%" do
        speech = "Text".ssml_pitch("-50%")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody pitch=\"-33.3%\"/>Text</speak>")
      end

      it "should have a maximum of 50%" do
        speech = "Text".ssml_pitch("-50%")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody pitch=\"+50%\"/>Text</speak>")
      end

      it "should also accept text based rates" do
        speech = "Text".ssml_pitch("medium")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody pitch=\"medium\"/>Text</speak>")
      end
    end

    context "on volume" do
      it "should set the volume of speech with integer" do
        speech = "Text".ssml_volume(2.3)
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody volume=\"+2.3dB\"/>Text</speak>")
      end

      it "should set the volume of speech with number string without %" do
        speech = "Text".ssml_volume("-2.3")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody volume=\"-2.3dB\"/>Text</speak>")
      end

      it "should set the pitch of speech with number string with %" do
        speech = "Text".ssml_volume("2.3dB")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody volume=\"+2.3dB\"/>Text</speak>")
      end

      it "should have a maximum of 4.08dB" do
        speech = "Text".ssml_volume("5dB")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody volume=\"+4.08dB\"/>Text</speak>")
      end

      it "should also accept text based rates" do
        speech = "Text".ssml_volume("medium")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><prosody volume=\"medium\"/>Text</speak>")
      end
    end

    context "on prosody" do
    end

    context "on pause" do
      it "should build a pause tag for 1 second" do
        speech = "".ssml_pause("1s")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><break time=\"1s\"/></speak>")
      end

      it "should build a pause tag for 100 milliseconds" do
        speech = "".ssml_pause("100ms")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><break time=\"100ms\"/></speak>")
      end

      it "should build a pause tag for different strengths" do
        speech = "".ssml_pause("strong")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><break strength=\"strong\"/></speak>")

        speech = "".ssml_pause("X-WEAK")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><break strength=\"x-weak\"/></speak>")
      end

      it "should build a normal medium pause if no parameter supplied" do
        speech = "".ssml_pause
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><break strength=\"medium\"/></speak>")
      end
    end

    context "on emphasis" do
      it "properly formats emphasis ssml string" do
        speech = "puts".ssml_emphasis("strong")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><emphasis level=\"strong\">puts</emphasis></speak>")
      end

      it "properly formats emphasis ssml string and defaults to moderate" do
        speech = "puts".ssml_emphasis
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><emphasis level=\"moderate\">puts</emphasis></speak>")
      end
    end

    context "on audio" do
      it "properly formats audio ssml string" do
        speech = "http://s3.audio.file.com/audio.mp3".ssml_audio
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><audio src=\"http://s3.audio.file.com/audio.mp3\"/></speak>")
      end
    end

    context "on spell_out or characters" do
      it "uses the proper spell_out ssml tag" do
        speech = "Spelling".ssml_spell_out
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"spell-out\">Spelling</say-as></speak>")
      end

      it "uses the proper characters ssml tag" do
        speech = "Characters".ssml_characters
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"characters\">Characters</say-as></speak>")
      end
    end

    context "on cardinal or number" do
      it "uses the proper cardinal ssml tag" do
        speech = "10".ssml_cardinal
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"cardinal\">10</say-as></speak>")
      end

      it "uses the proper number ssml tag" do
        speech = "10".ssml_number
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"number\">10</say-as></speak>")
      end
    end

    context "on ordinal" do
      it "uses the proper ordinal ssml tag" do
        speech = "10".ssml_ordinal
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"ordinal\">10</say-as></speak>")
      end
    end

    context "on digits" do
      it "uses the proper digits ssml tag" do
        speech = "10".ssml_digits
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"digits\">10</say-as></speak>")
      end
    end

    context "on fraction" do
      it "uses the proper fraction ssml tag" do
        speech = "3/20".ssml_fraction
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"fraction\">3/20</say-as></speak>")
      end
    end

    context "on unit" do
      it "uses the proper unit ssml tag" do
        speech = "3meters".ssml_unit
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"unit\">3meters</say-as></speak>")
      end

      it "removes spaces if present" do
        speech = "3 meters".ssml_unit
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"unit\">3meters</say-as></speak>")
      end
    end

    context "on date" do
      it "uses the proper date ssml tag with numbers" do
        speech = "20170510".ssml_date
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"date\">20170510</say-as></speak>")
      end
    end

    context "on time" do
      it "uses the proper time ssml tag" do
        speech = "1'".ssml_time
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"time\">1'</say-as></speak>")
      end
    end

    context "on telephone" do
      it "uses the proper telephone ssml tag" do
        speech = "3428977499".ssml_telephone
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"telephone\">3428977499</say-as></speak>")
      end
    end

    context "on address" do
      it "uses the proper address ssml tag" do
        speech = "342 W 1st St".ssml_address
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"address\">342 W 1st St</say-as></speak>")
      end
    end

    context "on interjection" do
      it "uses the proper interjection ssml tag" do
        speech = "Wow.".ssml_interjection
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"interjection\">Wow.</say-as></speak>")
      end
    end

    context "on expletive" do
      it "uses the proper expletive ssml tag" do
        speech = "Bleep".ssml_expletive
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><say-as interpret-as=\"expletive\">Bleep</say-as></speak>")
      end
    end

    context "on sub" do
      it "uses the proper alias and entry sub tag" do
        speech = "Al".ssml_sub("aluminum")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><sub alias=\"aluminum\">Al</sub></speak>")
      end
    end

    context "on whisper" do
      it "properly formats whisper ssml string" do
        speech = "I know what you did last summer.".ssml_whisper
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><amazon:effect name=\"whispered\">I know what you did last summer.</amazon:effect></speak>")
      end
    end

    context "on amazon_verb" do
      it "properly formats w tag with amazon verb" do
        speech = "read".ssml_amazon_verb
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><w role=\"amazon:VB\">read</w></speak>")
      end
    end

    context "on amazon_participle" do
      it "properly formats w tag with amazon past participle" do
        speech = "read".ssml_amazon_participle
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><w role=\"amazon:VBD\">read</w></speak>")
      end
    end

    context "on amazon_noun" do
      it "properly formats w tag with amazon noun" do
        speech = "bath".ssml_amazon_noun
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><w role=\"amazon:NN\">bath</w></speak>")
      end
    end

    context "on amazon_sense" do
      it "properly formats w tag with amazon sense 1" do
        speech = "bass".ssml_amazon_sense(1)
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><w role=\"SENSE_1\">bass</w></speak>")
      end
    end

    context "on phoneme" do
      it "properly formats w tag with amazon sense 1" do
        speech = "pecan".ssml_phoneme("ipa","pɪˈkɑːn")
        expect(speech.is_a?(String)).to eq(true)
        expect(speech.to_ssml).to eq("<speak><phoneme alphabet=\"ipa\" ph=\"pɪˈkɑːn\">pecan</phoneme></speak>")
      end
    end

  end

end
