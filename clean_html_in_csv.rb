require 'csv'
require 'fileutils'
require 'html_massage'

c = CSV.read('itest-xiezuo.csv', headers: false,)

# csv header
# ["标题和要求", "范文", nil, "分析", "考试类型", "附件"]
c_clean = c.map do |title, article, unknown, comment, type, attach|
  title_clean = HtmlMassage.text title unless title.nil?
  article_clean = HtmlMassage.text article unless article.nil?
  comment_clean = HtmlMassage.text comment unless comment.nil?
 [title_clean, article_clean, unknown, comment_clean, type, attach].to_csv(force_quotes: true) 
end

File.write('itest-xiezuo-cleanup.csv', c_clean.join)

  
