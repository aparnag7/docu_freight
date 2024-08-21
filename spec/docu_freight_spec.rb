RSpec.describe DocuFreight::Generator do
  let!(:type) {"pdf"}
  let!(:data) do
    {
      "customer_name": "John Doe",
      "order_name": "Order #1234",
      "shipping_address": "1234 Elm Street, Springfield, IL, 62701"
    }
  end
  let(:generator) { described_class.new(type, data) }

  it "has a version number" do
    expect(DocuFreight::VERSION).not_to be_nil
  end

  it "throws an error when the file type is invalid" do  
    expect { described_class.new("image", data) }.to raise_error(DocuFreight::InvalidFileTypeError)
  end

  context '#generate' do 
    it "returns a PDF string" do 
        pdf_output = generator.generate
        expect(pdf_output).to be_a(String)
        expect(pdf_output[0..3]).to eq('%PDF')
    end
  end
end
