module BooksHelper

  def page_title
    @title ||= current_user.page_title || 'Importer'
    #@title = "good_book.csv"
    content_for(:title) {@title}
  end

end
