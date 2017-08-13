module AdminsHelper
  def error_class tag
    @errors ||= {}
    @errors[tag] ? 'has-error' : ''
  end

  def expire_date
    (@our['expire'].to_date rescue nil) or Time.new + 1.day
  end
end
