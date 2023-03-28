# frozen_string_literal: true

module Forms
  ##
  # === Get Forms.
  # Get a collection of forms.
  #
  # ==== Example
  #     @data = @mints_pub.get_forms
  def get_forms(options = nil)
    @client.raw('get', '/content/forms', options)
  end

  ##
  # === Get Form.
  # Get a single form.
  #
  # ==== Parameters
  # slug:: (String) -- It's the string identifier generated by Mints.
  #
  # ==== Example
  #     @data = @mints_pub.get_form("form_slug")
  def get_form(slug, options = nil)
    @client.raw('get', "/content/forms/#{slug}", options)
  end

  ##
  # === Submit Form.
  # Submit a form with data.
  #
  # ==== Parameters
  # data:: (Hash) -- Data to be submitted.
  #
  # ==== Example
  #     data = {
  #       'form_slug': 'form_slug',
  #       'email': 'email@example.com',
  #       'given_name': 'given_name',
  #       'f1': 'Field 1 answer',
  #       'f2': 'Field 2 answer',
  #       'f3': 'Field 3 answer'
  #     }
  #     @data = @mints_pub.submit_form(data)
  def submit_form(data)
    @client.raw('post', '/content/forms/submit', nil, data_transform(data))
  end
end