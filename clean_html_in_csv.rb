require 'csv'
require 'fileutils'
require 'html_massage'
require 'digest/md5'

# USAGE: ruby -w script.rb inputfile

# csv header
# ["标题和要求", "范文", nil, "分析", "考试类型", "附件"]

def html2text(*arr)
  arr.map { |str| HtmlMassage.text str unless str.nil? }
end

def cleanup_html(inputfile)
  c = CSV.read(inputfile, headers: false)
  c.map do |title, article, unknown, comment, type, attach|
    title_clean, article_clean, comment_clean = html2text(title, article, comment)
    [title_clean, article_clean, unknown, comment_clean, type, attach].to_csv(force_quotes: true)
  end
end

def main
  input = ARGV[0] || 'data/itest-xiezuo.csv'
  p "输入文件是#{input}"
  out = ARGV[1] || 'data/itest-xiezuo-cleanup.csv'
  cleaned = cleanup_html(input)
  p "生成了#{out}"
  File.write(out, cleaned.join)
end

# run
main if __FILE__ == $PROGRAM_NAME
