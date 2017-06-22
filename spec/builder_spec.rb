require 'rspec'
require 'ssml_builder'

describe SsmlBuilder::Builder do

  describe "Building SSML" do

    context "on say" do
      it "properly generates ssml string" do
        speech = SsmlBuilder::Builder.new
        speech.say("Hello there!")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak>Hello there!</speak>")
        speech.say("How are you?")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak>Hello there! How are you?</speak>")
      end

      it "should escape any quotes or apostrophes" do
        speech = SsmlBuilder::Builder.new
        speech.say("How's it going?")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak>Hows it going?</speak>")
        speech.say('How"s it going?')
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak>Hows it going? Hows it going?</speak>")
      end
    end

    context "on paragraph" do
      it "should appropriate paragraph tags in ssml response" do
        speech = SsmlBuilder::Builder.new
        speech.paragraph("Hello how are you doing this fine day?")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><p>Hello how are you doing this fine day?</p></speak>")
      end

      it "should escape any apostrophes or quotes" do
        speech = SsmlBuilder::Builder.new
        speech.paragraph("How's it going?")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><p>Hows it going?</p></speak>")
        speech.paragraph('How"s it going?')
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><p>Hows it going?</p><p>Hows it going?</p></speak>")
      end

      it "should work with alias p" do
        speech = SsmlBuilder::Builder.new
        speech.p("Hello how are you doing this fine day?")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><p>Hello how are you doing this fine day?</p></speak>")
      end
    end

    context "on sentence" do
      it "should apply appropriate sentence tags in ssml response" do
        speech = SsmlBuilder::Builder.new
        speech.sentence("Hello how are you doing this fine day?")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><s>Hello how are you doing this fine day?</s></speak>")
      end

      it "should escape any apostrophes or quotes" do
        speech = SsmlBuilder::Builder.new
        speech.sentence("How's it going?")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><s>Hows it going?</s></speak>")
        speech.sentence('How"s it going?')
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><s>Hows it going?</s><s>Hows it going?</s></speak>")
      end
    end

    context "on rate" do
      it "should set the rate of speech with integer" do
        speech = SsmlBuilder::Builder.new
        speech.rate("Text",90)
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody rate=\"90%\">Text</prosody></speak>")
      end

      it "should set the rate of speech with number string without %" do
        speech = SsmlBuilder::Builder.new
        speech.rate("Text","90")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody rate=\"90%\">Text</prosody></speak>")
      end

      it "should set the rate of speech with number string with %" do
        speech = SsmlBuilder::Builder.new
        speech.rate("Text","90%")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody rate=\"90%\">Text</prosody></speak>")
      end

      it "should have a minimum of 20%" do
        speech = SsmlBuilder::Builder.new
        speech.rate("Text","10%")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody rate=\"20%\">Text</prosody></speak>")
      end

      it "should also accept text based rates" do
        speech = SsmlBuilder::Builder.new
        speech.rate("Text","medium")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody rate=\"medium\">Text</prosody></speak>")
      end
    end

    context "on pitch" do
      it "should set the pitch of speech with integer" do
        speech = SsmlBuilder::Builder.new
        speech.pitch("Text",30)
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody pitch=\"+30%\">Text</prosody></speak>")
      end

      it "should set the pitch of speech with number string without %" do
        speech = SsmlBuilder::Builder.new
        speech.pitch("Text","-30")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody pitch=\"-30%\">Text</prosody></speak>")
      end

      it "should set the pitch of speech with number string with %" do
        speech = SsmlBuilder::Builder.new
        speech.pitch("Text","30%")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody pitch=\"+30%\">Text</prosody></speak>")
      end

      it "should have a minimum of -33.3%" do
        speech = SsmlBuilder::Builder.new
        speech.pitch("Text","-50%")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody pitch=\"-33.3%\">Text</prosody></speak>")
      end

      it "should have a maximum of 50%" do
        speech = SsmlBuilder::Builder.new
        speech.pitch("Text","55%")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody pitch=\"+50%\">Text</prosody></speak>")
      end

      it "should also accept text based rates" do
        speech = SsmlBuilder::Builder.new
        speech.pitch("Text","medium")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody pitch=\"medium\">Text</prosody></speak>")
      end
    end

    context "on volume" do
      it "should set the volume of speech with integer" do
        speech = SsmlBuilder::Builder.new
        speech.volume("Text",2.3)
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody volume=\"+2.3dB\">Text</prosody></speak>")
      end

      it "should set the volume of speech with number string without %" do
        speech = SsmlBuilder::Builder.new
        speech.volume("Text","-2.3")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody volume=\"-2.3dB\">Text</prosody></speak>")
      end

      it "should set the pitch of speech with number string with %" do
        speech = SsmlBuilder::Builder.new
        speech.volume("Text","2.3dB")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody volume=\"+2.3dB\">Text</prosody></speak>")
      end

      it "should have a maximum of 4.08dB" do
        speech = SsmlBuilder::Builder.new
        speech.volume("Text","5dB")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody volume=\"+4.08dB\">Text</prosody></speak>")
      end

      it "should also accept text based rates" do
        speech = SsmlBuilder::Builder.new
        speech.volume("Text","medium")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><prosody volume=\"medium\">Text</prosody></speak>")
      end
    end

    context "on prosody" do
    end

    context "on pause" do
      it "should build a pause tag for 1 second" do
        speech = SsmlBuilder::Builder.new
        speech.pause("1s")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><break time=\"1s\"/></speak>")
      end

      it "should build a pause tag for 100 milliseconds" do
        speech = SsmlBuilder::Builder.new
        speech.pause("100ms")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><break time=\"100ms\"/></speak>")
      end

      it "should build a pause tag for different strengths" do
        speech = SsmlBuilder::Builder.new
        speech.pause("strong")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><break strength=\"strong\"/></speak>")

        speech = SsmlBuilder::Builder.new
        speech.pause("X-WEAK")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><break strength=\"x-weak\"/></speak>")
      end

      it "should build a normal medium pause if no parameter supplied" do
        speech = SsmlBuilder::Builder.new
        speech.pause
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><break strength=\"medium\"/></speak>")
      end
    end

    context "on emphasis" do
      it "properly formats emphasis ssml string" do
        speech = SsmlBuilder::Builder.new
        speech.emphasis("puts","strong")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><emphasis level=\"strong\">puts</emphasis></speak>")
      end

      it "properly formats emphasis ssml string and defaults to moderate" do
        speech = SsmlBuilder::Builder.new
        speech.emphasis("puts")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><emphasis level=\"moderate\">puts</emphasis></speak>")
      end
    end

    context "on audio" do
      it "properly formats audio ssml string" do
        speech = SsmlBuilder::Builder.new
        speech.audio("http://s3.audio.file.com/audio.mp3")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><audio src=\"http://s3.audio.file.com/audio.mp3\"/></speak>")
      end
    end

    context "on spell_out or characters" do
      it "uses the proper spell_out ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.spell_out("Spelling")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"spell-out\">Spelling</say-as></speak>")
      end

      it "uses the proper characters ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.characters("Characters")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"characters\">Characters</say-as></speak>")
      end
    end

    context "on cardinal or number" do
      it "uses the proper cardinal ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.cardinal("10")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"cardinal\">10</say-as></speak>")
      end

      it "uses the proper number ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.number("10")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"number\">10</say-as></speak>")
      end
    end

    context "on ordinal" do
      it "uses the proper ordinal ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.ordinal("10")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"ordinal\">10</say-as></speak>")
      end
    end

    context "on digits" do
      it "uses the proper digits ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.digits("10")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"digits\">10</say-as></speak>")
      end
    end

    context "on fraction" do
      it "uses the proper fraction ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.fraction("3/20")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"fraction\">3/20</say-as></speak>")
      end
    end

    context "on unit" do
      it "uses the proper unit ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.unit("3meters")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"unit\">3meters</say-as></speak>")
      end

      it "removes spaces if present" do
        speech = SsmlBuilder::Builder.new
        speech.unit("3 meters")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"unit\">3meters</say-as></speak>")
      end
    end

    context "on date" do
      it "uses the proper date ssml tag with numbers" do
        speech = SsmlBuilder::Builder.new
        speech.date(2017,5,10)
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"date\">20170510</say-as></speak>")
      end

      it "uses the proper date ssml tag with strings" do
        speech = SsmlBuilder::Builder.new
        speech.date("2017","5","10")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"date\">20170510</say-as></speak>")
      end

      it "uses the proper date ssml tag with empty inputs" do
        speech = SsmlBuilder::Builder.new
        speech.date(nil,"5","10")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"date\">????0510</say-as></speak>")
      end
    end

    context "on time" do
      it "uses the proper time ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.time("1'")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"time\">1'</say-as></speak>")
      end
    end

    context "on telephone" do
      it "uses the proper telephone ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.telephone("3428977499")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"telephone\">3428977499</say-as></speak>")
      end
    end

    context "on address" do
      it "uses the proper address ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.address("342 W 1st St")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"address\">342 W 1st St</say-as></speak>")
      end
    end

    context "on interjection" do
      it "uses the proper interjection ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.interjection("Wow.")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"interjection\">Wow.</say-as></speak>")
      end
    end

    context "on expletive" do
      it "uses the proper expletive ssml tag" do
        speech = SsmlBuilder::Builder.new
        speech.expletive("Bleep")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><say-as interpret-as=\"expletive\">Bleep</say-as></speak>")
      end
    end

    context "on sub" do
      it "uses the proper alias and entry sub tag" do
        speech = SsmlBuilder::Builder.new
        speech.sub("Al","aluminum")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><sub alias=\"aluminum\">Al</sub></speak>")
      end
    end

    context "on whisper" do
      it "properly formats whisper ssml string" do
        speech = SsmlBuilder::Builder.new
        speech.whisper("I know what you did last summer.")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><amazon:effect name=\"whispered\">I know what you did last summer.</amazon:effect></speak>")
      end

      it "properly ignores empty inputs" do
        speech = SsmlBuilder::Builder.new
        speech.say("Hi there!")
        speech.whisper(nil)
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak>Hi there!</speak>")
      end
    end

    context "on amazon_verb" do
      it "properly formats w tag with amazon verb" do
        speech = SsmlBuilder::Builder.new
        speech.amazon_verb("read")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><w role=\"amazon:VB\">read</w></speak>")
      end
    end

    context "on amazon_participle" do
      it "properly formats w tag with amazon past participle" do
        speech = SsmlBuilder::Builder.new
        speech.amazon_participle("read")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><w role=\"amazon:VBD\">read</w></speak>")
      end
    end

    context "on amazon_noun" do
      it "properly formats w tag with amazon noun" do
        speech = SsmlBuilder::Builder.new
        speech.amazon_noun("bath")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><w role=\"amazon:NN\">bath</w></speak>")
      end
    end

    context "on amazon_sense" do
      it "properly formats w tag with amazon sense 1" do
        speech = SsmlBuilder::Builder.new
        speech.amazon_sense("bass",1)
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><w role=\"SENSE_1\">bass</w></speak>")
      end
    end

    context "on phoneme" do
      it "properly formats w tag with amazon sense 1" do
        speech = SsmlBuilder::Builder.new
        speech.phoneme("pecan","ipa","pɪˈkɑːn")
        expect(speech.ssml.is_a?(String)).to eq(true)
        expect(speech.ssml).to eq("<speak><phoneme alphabet=\"ipa\" ph=\"pɪˈkɑːn\">pecan</phoneme></speak>")
      end
    end

  end
  
end
