
class URICatcher
  class NoBlockGiven < StandardError;end
  class MissingVCR < StandardError;end
  class MissingURI < StandardError;end
  class NotAString < StandardError;end
  def self.catcher
    @catcher ||= Catcher.new
  end
  def self.execute(&block)
    if block
      self.catcher.execute(block)
    else
      raise NoBlockGiven
    end
  end
  def self.when_visiting(uri)
    if uri.is_a?(String)
      uri = Regexp.new(uri) if uri.scan(/\$|\^|{|}/).length > 0
      self.catcher.when_visiting(uri)
    else
      raise NotAString
    end
  end
end

class Catcher
  def initialize
    @uris = {}
    raise URICatcher::MissingVCR if VCR.nil?
    VCR.configure do |c|
      c.before_http_request do |request|
        STDERR.puts "URICatcher: caught uri #{request.uri}" if $VERBOSE
        catch_request(request) if active?
      end
    end
  end

  def when_visiting(uri)
    if @block
      catch(uri, @block)
    else
      raise 'you have to call execute_this_block first'
    end
  end

  def execute(block)
    @block = block
  end

  def active?
    @uris.keys.length > 0
  end

  def catch(uri, block, once:true)
    if @uris.has_key?(uri)
      raise "uri #{uri} already registered"
    else
      STDERR.puts "URICatcher: will try to catch uri #{uri}" if $VERBOSE
      @uris[uri] = { :once => once, :block => block }
    end
  end

  def uncatch(uri)
    return @uris.delete(uri)
  end

  def catch_request(r)
    if found = @uris.keys.find{|uri| (uri.class == String && uri == r.uri) || (uri.class == Regexp && r.uri =~ uri)}
      begin
        STDERR.puts "URICatcher: matched uri #{found}, calling block" if $VERBOSE
        @uris[found][:block].call()
      ensure
        @uris.delete(found) if @uris[found][:once]
      end
    end
  end
end
