module TravelBooksHelper
  def travel_book_desctiption(travel_book)
    travel_book.description || ""
  end

  def travel_book_date(travel_book, type)
    date = type == :start ? travel_book.start_date : travel_book.end_date
    date || "未定"
  end

  def travel_book_duration(travel_book)
    if travel_book.start_date && travel_book.end_date
      "#{travel_book.start_date} ~ #{travel_book.end_date}"
    elsif travel_book.start_date || travel_book.end_date
      "#{travel_book.start_date || ''} #{travel_book.end_date || ''}".strip
    else
      "未設定"
    end
  end

  def area_name(travel_book)
    travel_book.area&.name || "未設定"
  end

  def traveler_type_name(travel_book)
    travel_book.traveler_type&.name || "未設定"
  end

  def travel_book_is_public(travel_book)
    travel_book.is_public ? "公開" : "未公開"
  end
end
