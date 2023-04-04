module PublicContentInstances
  ##
  # === Get Content Instances.
  # Get a collection of content instances. _Note:_ Options must be specified.
  #
  # ==== Parameters
  # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
  #
  # ==== First Example
  #     options = {
  #       "template": "content_instance_template_slug"
  #     }
  #     @data = @mints_pub.get_content_instances(options)
  #
  # ==== Second Example
  #     options = {
  #       "template": "content_instance_template_slug",
  #       sort: "-id"
  #     }
  #     @data = @mints_pub.get_content_instances(options)
  def get_content_instances(options = nil)
    @client.raw('get', '/content/content-instances', options)
  end

  ##
  # === Get Content Instance.
  # Get a single content instance.
  #
  # ==== Parameters
  # slug:: (String) -- It's the string identifier generated by Mints.
  #
  # ==== Example
  #     @data = @mints_pub.get_content_instance("content_instance_slug")
  def get_content_instance(slug)
    @client.raw('get', "/content/content-instances/#{slug}")
  end
end
