module MarkdownHelper
  require "redcarpet"
  require "redcarpet/render_strip"

  def markdown(text)
    render_options = {
      filter_html:     true, # htmlを出力しない
      safe_links_only: true, # 安全であると見なされるプロトコルのリンクのみを生成
      link_attributes: { rel: 'nofollow', target: "_blank" },
    }

    extensions = {
      autolink:           true, # <>で囲まれてなくてもリンクを認識
      no_intra_emphasis:  true, # 単語中の強調を認識しない
    }

    renderer = Redcarpet::Render::HTML.new(render_options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end
