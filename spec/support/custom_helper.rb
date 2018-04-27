module CustomHelper

  def validate_default_scope(model, factory)
    model_name = model.camelize.constantize
    inactive_object = factory
    search = model_name.find(inactive_object.id)
    expect(search).to be_nil
    search_unscoped = model_name.unscoped.find(inactive_object.id)
    excpect(search_unscoped).not_to be_nil
  end

  def validate_role_method(role)
    user = create(role.parameterize.to_sym)
    expect(user.send("#{role}?")).to be_truthy
  end

  def validate_basic_email_sending(options = {})
    user = options[:user] || create(:basic_user)
    target_email = options[:to] || user.email
    open_last_email.should be_delivered_to target_email
    open_last_email.should have_subject options[:subject] if options[:subject]
  end

end
