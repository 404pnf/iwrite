require 'test/unit'
require_relative '../clean_html_in_csv.rb'

# testing
class TestCleanUp < Test::Unit::TestCase

  INPUTFILE_EXMAPLE = 'input_example.csv'
  OUTPUTFILE_EXMAPLE = 'output_example.csv'
  OUTPUTFILE = 'output.csv'

  # generating file
  cleaned = cleanup_html(INPUTFILE_EXMAPLE)
  File.write(OUTPUTFILE, cleaned.join)

  MD5_INPUTFILE_EXMAPLE = '461a57ad4ab19b7fedfb021efbfba627'
  MD5_OUTPUTFILE_EXMAPLE = '1accba053a579144a74d3f49ab77936f'
  MD5_OUPUTFILE = Digest::MD5.hexdigest(File.read OUTPUTFILE)

  def test_cleanup_html   

    # assert input exmaple data is not changed          
    assert_equal MD5_INPUTFILE_EXMAPLE, Digest::MD5.hexdigest(File.read INPUTFILE_EXMAPLE), 'input example changed?'
    # assert output exmaple data is not changed
    assert_equal MD5_OUTPUTFILE_EXMAPLE, Digest::MD5.hexdigest(File.read OUTPUTFILE_EXMAPLE), 'output example changed?'
    # the generated outputfile is equal to output exmaple data
    assert_equal MD5_OUTPUTFILE_EXMAPLE, MD5_OUPUTFILE, 'output is not identical to ouput example'
  end
end