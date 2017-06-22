# SSML Builder (for Amazon Alexa)

This gem implements a full suite of tools for working with SSML particularly with Amazon's Alexa. For full SSML documentation, please see:
[Amazon SSML Reference](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/speech-synthesis-markup-language-ssml-reference)

## Installation

### For Ruby Projects:

Add this line to your application's Gemfile:

```ruby
gem 'ssml_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ssml_builder

## Usage

This Gem provides methods to generate ssml strings using the core Builder module as well as providing an extension of the string class if that usage is preferred.

### SsmlBuilder::Builder

#### Basic Usage

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.say("Hello, how are you today?")
ssml_builder.pause("1s")
ssml_builder.p("This is a new paragraph.")

ssml_buider.ssml
# Output: "<speak>Hello, how are you today? <break time=\"1s\"/><p>This is a new paragraph.</p></speak>"
```

#### Available Commands

* [say](#say)
* [paragraph](#paragraph)
* [p](#p)
* [sentence](#sentence)
* [rate](#rate)
* [pitch](#pitch)
* [volume](#volume)
* [pause](#pause)
* [break](#break)
* [emphasis](#emphasis)
* [audio](#audio)
* [spell_out](#spell_out)
* [characters](#characters)
* [cardinal](#cardinal)
* [number](#number)
* [ordinal](#ordinal)
* [digits](#digits)
* [fraction](#fraction)
* [unit](#unit)
* [date](#date)
* [time](#time)
* [telephone](#telephone)
* [phone](#phone)
* [address](#address)
* [interjection](#interjection)
* [expletive](#expletive)
* [sub](#sub)
* [whisper](#whisper)
* [amazon_verb](#amazon_verb)
* [amazon_participle](#amazon_participle)
* [amazon_noun](#amazon_noun)
* [amazon_sense](#amazon_sense)
* [phoneme](#phoneme)

##### say

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.say("Hello, how are you today?")

ssml_buider.ssml
# Output: "<speak>Hello, how are you today?</speak>"
```

##### paragraph

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.paragraph("Hello, how are you today?")

ssml_buider.ssml
# Output: "<speak><p>Hello, how are you today?</p></speak>"
```

##### p

Alias for [paragraph](#paragraph)

##### sentence

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.sentence("Hello, how are you today?")

ssml_buider.ssml
# Output: "<speak><s>Hello, how are you today?</s></speak>"
```

##### rate

parameters
  - string
  - rate
    - optional, default: "medium"
    - can be integer or string
    - valid text inputs: "x-slow", "slow", "medium", "fast", "x-fast"

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.rate("Text",90)

ssml_buider.ssml
# Output: "<speak><prosody rate=\"90%\">Text</prosody></speak>"
```

##### pitch

parameters
  - string
  - pitch
    - optional, default: "medium"
    - can be integer, float, or string
    - minimum -33.3
    - maximum 50
    - valid text inputs: "x-low", "low", "medium", "high", "x-high"

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.pitch("Text",50)

ssml_buider.ssml
# Output: "<speak><prosody pitch=\"+50%\">Text</prosody></speak>"
```

##### volume

parameters
  - string
  - volume
    - optional, default: "medium"
    - can be integer, float, or string
    - maximum 4.08
    - valid text inputs: "silent", "x-soft", "soft", "medium", "loud", "x-loud"

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.volume("Text",2.3)

ssml_buider.ssml
# Output: "<speak><prosody volume=\"+2.3dB\">Text</prosody></speak>"
```

##### pause

parameters
  - string
    - optional, default: "medium"
    - can be text time such as: "1s", "100ms", etc.
    - valid text inputs: "none", "x-weak", "weak", "medium", "strong", "x-strong"

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.pause("1s")

ssml_buider.ssml
# Output: "<speak><break time=\"1s\"/></speak>"
```

##### break

Alias for [pause](#pause)

##### emphasis

parameters
  - string
  - emphasis
    - optional, default: "moderate"
    - valid text inputs: "reduced", "moderate", "strong"

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.emphasis("Text","strong")

ssml_buider.ssml
# Output: "<speak><emphasis level=\"strong\">Text</emphasis></speak>"
```

##### audio

parameters
  - url
    - [SSML Audio Guidelines](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/speech-synthesis-markup-language-ssml-reference#audio)

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.audio("http://s3.audio.file.com/audio.mp3")

ssml_buider.ssml
# Output: "<speak><audio src=\"http://s3.audio.file.com/audio.mp3\"/></speak>"
```

##### spell_out

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.spell_out("Spelling")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"spell-out\">Spelling</say-as></speak>"
```

##### characters

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.characters("Spelling")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"characters\">Spelling</say-as></speak>"
```

##### cardinal

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.cardinal("10")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"cardinal\">10</say-as></speak>"
```

##### number

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.number("10")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"number\">10</say-as></speak>"
```

##### ordinal

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.ordinal("10")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"ordinal\">10</say-as></speak>"
```

##### digits

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.digits("10")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"digits\">10</say-as></speak>"
```

##### fraction

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.fraction("3/20")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"fraction\">3/20</say-as></speak>"
```

##### unit

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.unit("10 meters")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"unit\">10meters</say-as></speak>"
```

##### date

parameters
  - year
    - string or integer
    - nil to leave out
  - month
    - string or integer
    - nil to leave out
  - day
    - string or integer
    - nil to leave out

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.date("2017",nil,10)

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"date\">2017??10</say-as></speak>"
```

##### time

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.time("2'")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"time\">2'</say-as></speak>"
```

##### telephone

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.telephone("1234567890")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"telephone\">1234567890</say-as></speak>"
```

##### phone

Alias for [telephone](#telephone)

##### address

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.address("342 W 1st St")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"address\">342 W 1st St</say-as></speak>"
```

##### interjection

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.interjection("Wow!")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"interjection\">Wow!</say-as></speak>"
```

##### expletive

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.expletive("Curse Word")

ssml_buider.ssml
# Output: "<speak><say-as interpret-as=\"expletive\">Curse Word</say-as></speak>"
```

##### sub

parameters
  - string
  - alias

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.sub("Al","aluminum")

ssml_buider.ssml
# Output: "<speak><sub alias=\"aluminum\">Al</sub></speak>"
```

##### whisper

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.whisper("Be very quiet")

ssml_buider.ssml
# Output: "<speak><amazon:effect name=\"whispered\">Be very quiet</amazon:effect></speak>"
```

##### amazon_verb

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.amazon_verb("read")

ssml_buider.ssml
# Output: "<speak><w role=\"amazon:VB\">read</w></speak>"
```

##### amazon_participle

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.amazon_participle("read")

ssml_buider.ssml
# Output: "<speak><w role=\"amazon:VBD\">read</w></speak>"
```

##### amazon_noun

parameters
  - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.amazon_noun("bath")

ssml_buider.ssml
# Output: "<speak><w role=\"amazon:NN\">bath</w></speak>"
```

##### amazon_sense

parameters
  - string
  - sense
    - integer
    - [Sense Documentation](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/speech-synthesis-markup-language-ssml-reference#w)

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.amazon_sense("bass",1)

ssml_buider.ssml
# Output: "<speak><w role=\"SENSE_1\">bass</w></speak>"
```

##### phoneme

[Amazon Phoneme Documentation](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/speech-synthesis-markup-language-ssml-reference#phoneme)

parameters
  - string
  - alphabet
    - string
  - ph
    - string

```ruby
require 'ssml_builder'
ssml_builder = SsmlBuilder::Builder.new
ssml_builder.phoneme("pecan","ipa","pɪˈkɑːn")

ssml_buider.ssml
# Output: "<speak><phoneme alphabet=\"ipa\" ph=\"pɪˈkɑːn\">pecan</phoneme></speak>"
```

### String


## Troubleshooting


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Please make sure to write specs for any new features!

# Team Members
* "Paul McMahon" <colpan@sircolpaniusjackson.com>