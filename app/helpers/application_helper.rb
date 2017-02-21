module ApplicationHelper

	def is_active?(link_path)
		if current_page?(link_path)
			"active"
		else
			""
		end
	end

	# http://davidlesches.com/blog/elegant-titles-and-seo-meta-tags-in-rails
	def title(title = nil)
		if title.present?
			content_for :title, title
		else
			content_for?(:title) ? content_for(:title) + ' | ' + APP_CONFIG['default_title'] : APP_CONFIG['default_title']
		end
	end

	def meta_keywords(tags = nil)
		if tags.present?
			content_for :meta_keywords, tags
		else
			content_for?(:meta_keywords) ? [content_for(:meta_keywords), APP_CONFIG['meta_keywords']].join(', ') : APP_CONFIG['meta_keywords']
		end
	end

	def meta_description(desc = nil)
		if desc.present?
			content_for :meta_description, desc
		else
			content_for?(:meta_description) ? content_for(:meta_description) : APP_CONFIG['meta_description']
		end
	end

end
