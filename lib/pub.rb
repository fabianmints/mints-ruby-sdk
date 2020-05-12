require 'yaml'
require_relative './client.rb'
module Mints
  ##
  # == Public context API
  # Pub class contains functions that needs only an API key as authentication
  # == Usage example
  # Initialize
  #     pub = Mints::Pub.new(mints_url, api_key)
  # or if host and api_key are provided by mints_config.yml
  #     pub = Mints::Pub.new
  # Call any function
  #     pub.get_products
  # == Single resource options
  # * +include+ - [String] include a relationship
  # * +attributes+ - [Boolean] attach attributes to response
  # * +categories+ - [Boolean] attach categories to response
  # * +tags+ - [Boolean] attach tags to response
  # == Resource collections options 
  # * +search+ - [String] filter by a search word
  # * +scopes+ - [String] filter by a scope
  # * +filters+ - [String] filter by where clauses
  # * +jfilters+ - [String] filter using complex condition objects
  # * +catfilters+ - [String] filter by categories
  # * +fields+ - [String] indicates the columns that will be selected
  # * +sort+ - [String] indicates the columns that will be selected
  # * +include+ - [String] include a relationship
  # * +attributes+ - [Boolean] attach attributes to response
  # * +categories+ - [Boolean] attach categories to response
  # * +taxonomies+ - [Boolean] attach categories to response
  # * +tags+ - [Boolean] attach tags to response
  class Pub
    attr_reader :client

    ##
    # === Initialize.
    # Class constructor
    #
    # ==== Parameters
    # * +host+ - [String] It's the visitor IP
    # * +api_key+ - [String] Mints instance api key
    # * +contact_token+ - [String] Cookie 'mints_contact_id' value (mints_contact_token)
    # ==== Return
    # Returns a Client object
    def initialize(host=nil, api_key=nil, contact_token=nil)
      if host === nil and api_key === nil
        if File.exists?("#{Rails.root}/mints_config.yml")
          config = YAML.load_file("#{Rails.root}/mints_config.yml")
          host = config["mints"]["host"]
          api_key = config["mints"]["api_key"]
        else
          raise 'MintsBadCredentialsError'
        end
      end
      @client = Mints::Client.new(host, api_key, contact_token)
    end
    
    ##
    # === Register Visit.
    # Register a ghost/contact visit in Mints.Cloud
    #
    # ==== Parameters
    # * +request+ - [ActionDispatch::Request] request
    # * +ip+ - [String] It's the visitor IP
    # * +user_agent+ - The visitor's browser user agent
    # * +url+ - [String] URL visited
    def register_visit(request, ip=nil, user_agent=nil, url=nil)
      data = {
        ip_address: ip || request.remote_ip,
        user_agent: user_agent || request.user_agent,
        url: url || request.fullpath
      }
      response = @client.raw("post", "/register-visit", nil, data)
      return response
    end

    ##
    # === Register Visit timer.
    # Register a page visit time
    #
    # ==== Parameters
    # * +visit+ - [String] It's the visitor IP
    # * +time+ - [Integer] The visitor's browser user agent
    def register_visit_timer(visit, time)
      return @client.raw("get", "/register-visit-timer?visit=#{visit}&time=#{time}")
    end

    ##
    # === Get Content Page.
    # Get a single content page
    #
    # ==== Parameters
    # * +slug+ - [String] It's the slug 
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_content_page(slug, options = nil)
      return @client.raw("get", "/content/content-pages/#{slug}", options)
    end

    ##
    # === Get Content Templates.
    # Get a collection of content templates
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_content_templates(options = nil)
      return @client.raw("get", "/content/content-templates")
    end

    ##
    # === Get Content Template.
    # Get a single content template.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_content_template(slug, options = nil)
      return @client.raw("get", "/content/content-templates/#{slug}", options)
    end

    ##
    # === Get Content Instances.
    # Get a collection of content instances
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def content_instances(options) 
      return @client.raw("get", "/content/content-instances", options)
    end

    ##
    # === Get Content Instance.
    # Get a single content instance.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def content_instance(slug, options = nil)
      return @client.raw("get", "/content/content-instances/#{slug}", options)
    end

    ##
    # === Get Stories.
    # Get a collection of stories
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_stories(options = nil)
      return @client.raw("get", "/content/stories", options)
    end

    ##
    # === Get Story.
    # Get a single story.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_story(slug, options = nil)
      return @client.raw("get", "/content/stories/#{slug}", options)
    end

    ##
    # === Get Forms.
    # Get a collection of forms.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_forms(options = nil)
      return @client.raw("get", "/content/forms/{slug}", options)
    end

    ##
    # === Get Form.
    # Get a single form.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_form(slug, options = nil)
      return @client.raw("get", "/content/forms/{slug}", options)
    end

    ##
    # === Submit Form.
    # Submit a form.
    #
    # ==== Parameters
    # * +data+ - [Hash] Data to be submited
    def submit_form(data)
      return @client.raw("post", "/forms/store", nil, data)
    end

    ##
    # === Get Products.
    # Get a collection of products.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_products(options = nil)
      return @client.raw("get", "/ecommerce/products", options)
    end

    ##
    # === Get Product.
    # Get a single product.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_product(slug, options = nil)
      return @client.raw("get", "/ecommerce/products/#{slug}", options)
    end

    ##
    # === Get Product Brands.
    # Get a collection of product brands.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_product_brands(options = nil)
      return @client.raw("get", "/ecommerce/product-brands", options)
    end

    ##
    # === Get Product Brand.
    # Get a product brand.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_product_brand(slug, options = nil)
      return @client.raw("get", "/ecommerce/product-brands/#{slug}", options)
    end

    ##
    # === Get SKUs.
    # Get a collection of SKUs.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_skus(options = nil)
      return @client.raw("get", "/ecommerce/skus", options)
    end

    ##
    # === Get SKU.
    # Get a single SKU.
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_sku(slug, options = nil)
      return @client.raw("get", "/ecommerce/skus/#{slug}", options)
    end
    
    ##
    # === Get categories.
    # Get a collection of categories.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_categories(options = nil)
      return @client.raw("get", "/config/categories", options)
    end

    ##
    # === Get Category.
    # Get a single category
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_category(slug, options = nil)
      return @client.raw("get", "/config/categories/#{slug}", options)
    end

    ##
    # === Get Tags.
    # Get a collection of tags.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_tags(options)
      return @client.raw("get", "/config/tags", options)
    end

    ##
    # === Get Tag.
    # Get a single tag
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_tag(slug, options = nil)
      return @client.raw("get", "/config/tags/#{slug}", options)
    end

    ##
    # === Get Attributes.
    # Get a collection of attributes.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_attributes(options = nil)
      return @client.raw("get", "/config/attributes", options)
    end

    ##
    # === Get Taxonomies.
    # Get a collection of taxonomies.
    #
    # ==== Parameters
    # * +options+ - [Hash] List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter
    def get_taxonomies(options = nil)
      return @client.raw("get", "/config/taxonomies", options)
    end

    ##
    # === Get Taxonomy.
    # Get a single taxonomy
    #
    # ==== Parameters
    # * +slug+ - [String] It's the string identifier generated by Mints
    # * +options+ - [Hash] List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter
    def get_taxonomy(slug, options = nil)
      return @client.raw("get", "/config/taxonomies/#{slug}", options)
    end
  end
end
