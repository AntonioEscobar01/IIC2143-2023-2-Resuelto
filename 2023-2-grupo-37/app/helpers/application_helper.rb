module ApplicationHelper
  def star_rating(calificacion)
    if calificacion > 0
      full_stars = calificacion / 1
      half_stars = calificacion % 1 >= 0.5 ? 1 : 0
      5 - full_stars - half_stars

      # Si no te funciona con el emoji descomenta a esta parte
      # full_stars_html = '<i class="fas fa-star">*</i>' * full_stars

      full_stars_html = '⭐' * full_stars

      full_stars_html.html_safe
    else
      'Sin estrellas'
    end
  end
end

