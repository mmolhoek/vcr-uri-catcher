class URICatcher
  def self.catcher
    @catcher ||= Catcher.new
  end
  def self.execute(block)
    self.catcher.execute(block)
  end
  def self.when_visiting(uri)
    self.catcher.when_visiting(uri)
  end
end

class Catcher
  def initialize
    @uris = {}
    raise 'you not using VCR...' if VCR.nil?
    VCR.configure do |c|
      c.before_http_request do |request|
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
      @uris[uri] = { :once => once, :block => block }
    end
  end

  def uncatch(uri)
    return @uris.delete(uri)
  end

  def catch_request(r)
    if found = @uris.keys.find{|uri| (uri.class == String && uri == r.uri) || (uri.class == Regexp && r.uri =~ uri)}
      begin
        @uris[found][:block].call()
      ensure
        @uris.delete(found) if @uris[found][:once]
      end
    end
  end
end
