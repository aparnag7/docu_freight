require "docu_freight/version"
require "prawn"
require 'erb'

module DocuFreight
  class InvalidFileTypeError < StandardError; end
  class Generator
    VALID_FILE_TYPES = %w[pdf doc]
    TEMPLATE_DIR = File.expand_path('templates', __dir__)
    

    def initialize(file_type, data)
      validate_type!(file_type)
      @file_type = file_type
      @data = data
    end

    def generate
      template = load_template
      content = render_template(template, data)
      generate_pdf(content)
    end

    attr_reader :file_type, :data

    private

      def validate_type!(file_type)
        unless VALID_FILE_TYPES.include?(file_type)
          raise InvalidFileTypeError, "Invalid file file_type: #{file_type}. Supported file types are: #{VALID_FILE_TYPES.join(', ')}"
        end
      end

      def load_template
        File.read(File.join(TEMPLATE_DIR, "shipping.erb"))
      end
  
      def render_template(template, data)
        ERB.new(template).result_with_hash(data)
      end

      def generate_pdf(content)
        pdf = Prawn::Document.new
        pdf.text content, align: :left, size: 12, leading: 2
        pdf.render
      end

      # def file_name
      #   "#{document_type}_#{reference_number}_#{Time.now.strftime('%Y%m%d')}.pdf"
      # end
  end
end
