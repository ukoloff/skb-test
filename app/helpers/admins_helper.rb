module AdminsHelper
  def error_class tag
    @errors ||= {}
    @errors[tag] ? 'has-error' : ''
  end
end
