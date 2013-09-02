require 'csv'
require 'fileutils'
require 'html_massage'

# USAGE: ruby -w script.rb inputfile

# csv header
# ["标题和要求", "范文", nil, "分析", "考试类型", "附件"]

def html2text(*arr)
  arr.map { |str| HtmlMassage.text str unless str.nil? }
end

def cleanup_html inputfile
	c = CSV.read(inputfile, headers: false,)
	c.map do |title, article, unknown, comment, type, attach|	
		title_clean, article_clean, comment_clean = html2text(title, article, comment)
	  [title_clean, article_clean, unknown, comment_clean, type, attach].to_csv(force_quotes: true) 
	end
end

inputfile = ARGV[0] || 'itest-xiezuo.csv'
c_clean = cleanup_html(inputfile)
p "生成了itest-xiezuo-cleanup.csv"
File.write('itest-xiezuo-cleanup.csv', c_clean.join)
