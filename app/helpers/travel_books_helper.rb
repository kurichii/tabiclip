module TravelBooksHelper
  def travel_book_description(travel_book)
    travel_book.description.blank? ? "-" : travel_book.description
  end

  def travel_book_duration(travel_book)
    return t("helpers.date_undecided") unless travel_book.start_date || travel_book.end_date
    "#{fmt_date(travel_book.start_date)} - #{fmt_date(travel_book.end_date)}"
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
