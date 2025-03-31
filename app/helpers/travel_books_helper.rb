module TravelBooksHelper
  def travel_book_description(travel_book)
    travel_book.description.blank? ? "-" : travel_book.description
  end

  def travel_book_duration(travel_book)
    return t("helpers.date_undecided") if travel_book.start_date.nil? && travel_book.end_date.nil?
    "#{fmt_date(travel_book.start_date)} - #{fmt_date(travel_book.end_date)}"
  end

  # 日付をフォーマットする
  def fmt_date(date)
    return t("helpers.undecided") if date.nil?
    format_date = I18n.l(date.to_date, format: :default)
  end

  def area_name(travel_book)
    travel_book.area&.name || t("helpers.undecided")
  end

  def traveler_type_name(travel_book)
    travel_book.traveler_type&.name || t("helpers.undecided")
  end

  def travel_book_is_public(travel_book)
    travel_book.is_public ? t("helpers.public") : t("helpers.unpublic")
  end
end
