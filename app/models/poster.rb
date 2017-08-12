class Poster
  Fields = {
    title: /./,
    expire: /^(\d{1,2}[.]){2}\d{4}$/,
    description: /./
  }
  def initialize params
    @our = {'date'=> Time.now}
    Fields.each do |k, re|
      next if re.match(@our[k.to_s] = params[k].to_s.strip)
      @errors ||= {}
      @errors[k] = 'Неверный ввод'
    end
  end

  attr_reader :our, :errors

  def save
    @our['expire'] = Date.new(*@our['expire'].split(/\D+/).reverse.map(&:to_i)).to_time
    Fetcher.new.our = @our
  end
end
