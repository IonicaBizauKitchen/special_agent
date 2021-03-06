require 'special_agent/device'

module SpecialAgent
  DEBUG = false
  DEBUG_LEVEL = 1

  class UserAgent
    attr_accessor :user_agent_string
    attr_accessor :user_language
    attr_accessor :device

    def initialize(user_agent_string)
      self.parse(user_agent_string)
    end

    def parse(user_agent)
      self.user_agent_string = user_agent
      self.device = SpecialAgent::Device.new(self.user_agent_string)

      SpecialAgent.debug "Device   = #{self.device}"
      SpecialAgent.debug "Platform = #{self.device.platform}"
      SpecialAgent.debug "OS       = #{self.device.operating_system}"
      SpecialAgent.debug "Engine   = #{self.device.engine}"
      SpecialAgent.debug "Browser  = #{self.device.engine.browser}"

      self.summary
    end

    def is_computer?(type=nil)
      self.device.is_computer?(type)
    end

    def is_mobile?(type=nil)
      self.device.is_mobile?(type)
    end

    def is_bot?(type=nil)
      self.device.is_bot?(type)
    end

    def to_s
      [self.device,
        self.device.platform,
        self.device.operating_system,
        self.device.engine,
        self.device.engine.browser
        ].compact.join(", ")
    end

    def to_human_string
      if self.device && self.device.engine && self.device.engine.browser
        "User has a #{self.device} running #{self.device.engine.browser} (which is based on #{self.device.engine})."
      else
        "User has some kind of device that I've never seen."
      end
    end

    def summary
      SpecialAgent.debug
      SpecialAgent.debug "SUMMARY"
      SpecialAgent.debug "  Is computer? #{self.is_computer?}"
      if self.is_computer?
        SpecialAgent.debug "    Is a Mac? #{self.is_computer? :mac}"
        SpecialAgent.debug "    Is a PC? #{self.is_computer? :pc}"
      end
      SpecialAgent.debug "  Is mobile? #{self.is_mobile?}"
      if self.is_mobile?
        SpecialAgent.debug "    Is an iPhone? #{self.is_mobile? :iphone}"
        SpecialAgent.debug "    Is an iPad? #{self.is_mobile? :ipad}"
        SpecialAgent.debug "    Is an iPod? #{self.is_mobile? :ipod}"
        SpecialAgent.debug "    Is an Android? #{self.is_mobile? :android}"
      end
      SpecialAgent.debug "  Is bot? #{self.is_bot?}"
      SpecialAgent.debug
    end
  end

  def self.debug(str="", level=1)
    puts str if DEBUG && (DEBUG_LEVEL >= level)
  end

end
